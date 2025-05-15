package com.github.mattwei.service.impl;

import com.github.mattwei.dto.MealSalesDTO;
import com.github.mattwei.entity.Orders;
import com.github.mattwei.mapper.OrderMapper;
import com.github.mattwei.mapper.UserMapper;
import com.github.mattwei.service.ReportService;
import com.github.mattwei.vo.*;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import static java.lang.System.out;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/25 下午 07:39
 */
@Service
public class ReportServiceImpl implements ReportService {

    @Autowired
    private OrderMapper orderMapper;
    @Autowired
    private UserMapper userMapper;

    /**
     * 統計指定時間區間內的營業額數據
     * @param begin
     * @param end
     * @return
     */
    @Override
    public TurnoverReportVO getTurnoverStatistics(LocalDate begin, LocalDate end) {
        // 當前集合用於存放begin到end的所有日期
        List<LocalDate> dateList = new ArrayList<>();

        // dateList 還要轉成字符串，在建構VO時用StringUtils.join()操作
        dateList.add(begin);
        while(!begin.equals(end)){
            begin = begin.plusDays(1);
            dateList.add(begin);
        }
        // 格式化日期，移除年份
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM-dd");
        // 儲存移除年份後的日期
        List<String> formattedDateList = new ArrayList<>();

        // turnoverList，儲存每日營業額
        List<Double> turnoverList = new ArrayList<>();
        for (LocalDate date : dateList) {
            // 查詢 date 日期對應的營業額數據 : 狀態為"已完成"的訂單金額合計
            // 設置每天的開始與結束時間，精確到秒數
            LocalDateTime beginTime = LocalDateTime.of(date, LocalTime.MIN);
            LocalDateTime endTime = LocalDateTime.of(date, LocalTime.MAX);
            // select sum(amount) from orders where order_time > ? and order_time < ?  and status = 5
            Map map = new HashMap();
            map.put("begin", beginTime);
            map.put("end", endTime);
            map.put("status", Orders.COMPLETED);
            Double turnover =  orderMapper.sumByMap(map);
            turnoverList.add(turnover == null ? 0.0 : turnover);

            formattedDateList.add(date.format(formatter)); // 格式化為 MM-dd
        }

        return TurnoverReportVO.builder()
                .dateList(StringUtils.join(formattedDateList, ","))
                .turnoverList(StringUtils.join(turnoverList, ","))
                .build();
    }

    /**
     * 統計指定時間區間內的顧客數據
     * @param begin
     * @param end
     * @return
     */
    @Override
    public CustomerReportVO getCustomerStatistics(LocalDate begin, LocalDate end) {
        List<LocalDate> dateList = new ArrayList<>();
        // dateList
        dateList.add(begin);
        while(!begin.equals(end)){
            begin = begin.plusDays(1);
            dateList.add(begin);
        }
        // 格式化日期，移除年份
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM-dd");
        // 儲存移除年份後的日期
        List<String> formattedDateList = new ArrayList<>();

        // 存放每天的新增顧客數量
        // SQL: select count(id) from user where create_time > ? and create_time < ? and role = 1
        List<Integer> newCustomerList = new ArrayList<>();
        // 存放每天的總顧客數量
        // SQL: select count(id) from user where create_time < ? and role = 1，與上面共用同一個動態SQL就行
        List<Integer> totalCustomerList = new ArrayList<>();

        for (LocalDate date : dateList) {
            LocalDateTime beginTime = LocalDateTime.of(date, LocalTime.MIN);
            LocalDateTime endTime = LocalDateTime.of(date, LocalTime.MAX);
            Map map = new HashMap();
            map.put("end", endTime);
            // 先查總顧客數，因為只需要 end
            Integer totalCustomer = userMapper.countByMap(map);

            map.put("begin", beginTime);
            // 新增用戶數量
            Integer newCustomer = userMapper.countByMap(map);
            totalCustomerList.add(totalCustomer);
            newCustomerList.add(newCustomer);

            formattedDateList.add(date.format(formatter)); // 格式化為 MM-dd
        }
        return CustomerReportVO.builder()
                .dateList(StringUtils.join(formattedDateList, ","))
                .totalCustomerList(StringUtils.join(totalCustomerList, ","))
                .newCustomerList(StringUtils.join(newCustomerList, ","))
                .build();
    }

    /**
     * 統計指定時間區間內的訂單數據
     * @param begin
     * @param end
     * @return
     */
    @Override
    public OrderReportVO getOrdersStatistics(LocalDate begin, LocalDate end) {
        List<LocalDate> dateList = new ArrayList<>();
        dateList.add(begin);
        while(!begin.equals(end)){
            begin = begin.plusDays(1);
            dateList.add(begin);
        }
        // 格式化日期，移除年份
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM-dd");
        // 儲存移除年份後的日期
        List<String> formattedDateList = new ArrayList<>();

        List<Integer> orderCountList = new ArrayList<>();
        List<Integer> validOrderCountList = new ArrayList<>();
        for (LocalDate date : dateList) {
            LocalDateTime beginTime = LocalDateTime.of(date, LocalTime.MIN);
            LocalDateTime endTime = LocalDateTime.of(date, LocalTime.MAX);
            // 查詢每天的訂單總數 select count(id) from orders where order_time > ? and order_time < ?
            Integer orderCount = getOrderCount(beginTime, endTime, null);
            // 查詢每天的有效訂單數 select count(id) from orders where order_time > ? and order_time < ? and status = 5
            Integer validOrderCount = getOrderCount(beginTime, endTime, Orders.COMPLETED);

            orderCountList.add(orderCount);
            validOrderCountList.add(validOrderCount);

            formattedDateList.add(date.format(formatter)); // 格式化為 MM-dd
        }
        // 計算時間區間內的訂單總數量
        Integer totalOrderCount = orderCountList.stream().reduce(Integer::sum).get();
        // 計算時間區間內的有效訂單數量
        Integer validOrderCount = validOrderCountList.stream().reduce(Integer::sum).get();
        // 計算訂單完成率
        Double orderCompletionRate = 0.0;
        if(totalOrderCount != 0){
            orderCompletionRate = validOrderCount.doubleValue() / totalOrderCount;
        }

        return OrderReportVO.builder()
                .dateList(StringUtils.join(formattedDateList, ","))
                .orderCountList(StringUtils.join(orderCountList, ","))
                .validOrderCountList(StringUtils.join(validOrderCountList, ","))
                .totalOrderCount(totalOrderCount)
                .validOrderCount(validOrderCount)
                .orderCompletionRate(orderCompletionRate)
                .build();
    }

    /**
     * 統計指定時間區間內的銷量Top10
     * @param begin
     * @param end
     * @param status
     * @return
     */
    private Integer getOrderCount(LocalDateTime begin, LocalDateTime end, Integer status){
        Map map = new HashMap();
        map.put("begin", begin);
        map.put("end", end);
        map.put("status", status);
        return orderMapper.countByMap(map);
    }

    @Override
    public SalesTop10ReportVO getSalesTop10(LocalDate begin, LocalDate end) {
        LocalDateTime beginTime = LocalDateTime.of(begin, LocalTime.MIN);
        LocalDateTime endTime = LocalDateTime.of(end, LocalTime.MAX);

        List<MealSalesDTO> salesTop10 = orderMapper.getSalesTop(beginTime, endTime);
        List<String> names = salesTop10.stream().map(MealSalesDTO::getName).collect(Collectors.toList());
        List<Integer> numbers = salesTop10.stream().map(MealSalesDTO::getNumber).collect(Collectors.toList());

        String nameList = StringUtils.join(names, ",");
        String numberList = StringUtils.join(numbers, ",");

        return SalesTop10ReportVO.builder()
                .nameList(nameList)
                .numberList(numberList)
                .build();
    }

    /**
     * 導出運營報表
     * @param response
     */
    @Override
    public void exportBusinessData(HttpServletResponse response) {
        // 設置響應頭
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=\"運營數據統計報表.xlsx\"");
        // 1. 調用 getBusinessData，獲得營業數據
        LocalDate dateBegin = LocalDate.now().minusDays(30);
        LocalDate dateEnd = LocalDate.now().minusDays(1);
        BusinessDataVO businessDataVO = getBusinessData(
                LocalDateTime.of(dateBegin, LocalTime.MIN), LocalDateTime.of(dateEnd, LocalTime.MAX));
        // 2. 通過 POI 將數據寫入到Excel文件中
        InputStream in = this.getClass().getClassLoader().getResourceAsStream("template/運營數據報表模板.xlsx");
        try {
            // 基於模板文件創建一個新的Excel文件
            XSSFWorkbook excel = new XSSFWorkbook(in);
            // 獲取 工作表
            XSSFSheet sheet = excel.getSheet("Sheet1");
            // 填充數據 - 時間
            sheet.getRow(1).getCell(1).setCellValue("時間: " + dateBegin + " 至 " + dateEnd);
            // 獲取第四行
            XSSFRow row = sheet.getRow(3);
            row.getCell(2).setCellValue(businessDataVO.getTurnover());
            row.getCell(4).setCellValue(businessDataVO.getOrderCompletionRate());
            row.getCell(6).setCellValue(businessDataVO.getNewCustomerCount());
            // 獲取第五行
            row = sheet.getRow(4);
            row.getCell(2).setCellValue(businessDataVO.getValidOrderCount());
            row.getCell(4).setCellValue(businessDataVO.getUnitPrice());

            // 填充明細數據
            for(int i = 0 ; i < 30 ; i++){
                LocalDate date = dateBegin.plusDays(i);
                // 查詢某一天的營業數據
                BusinessDataVO businessData = getBusinessData(LocalDateTime.of(date, LocalTime.MIN), LocalDateTime.of(date, LocalTime.MAX));
                // 獲取某一行
                row = sheet.getRow(7 + i);
                row.getCell(1).setCellValue(date.toString());
                row.getCell(2).setCellValue(businessData.getTurnover());
                row.getCell(3).setCellValue(businessData.getValidOrderCount());
                row.getCell(4).setCellValue(businessData.getOrderCompletionRate());
                row.getCell(5).setCellValue(businessData.getUnitPrice());
                row.getCell(6).setCellValue(businessData.getNewCustomerCount());
            }

            // 3. 通過輸出流將 Excel 文件下載到客戶端瀏覽器上
            ServletOutputStream out = response.getOutputStream();
//            FileOutputStream out = new FileOutputStream(new File("D:\\test.xlsx"));
            excel.write(out);

            // 關閉資源
            System.out.close();
            excel.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * 根據時間區間統計營業數據
     * @param begin
     * @param end
     * @return
     */
    public BusinessDataVO getBusinessData(LocalDateTime begin, LocalDateTime end) {
        /**
         * 營業額: 當日已完成訂單的總金額
         * 有效訂單: 當日已完成訂單的數量
         * 訂單完成綠: 有效訂單 / 總訂單數
         * 平均客單價: 營業額 / 有效訂單數
         * 新增用戶: 當日新增用戶的數量
         */
        Map map = new HashMap();
        map.put("begin",begin);
        map.put("end",end);
        // 查詢總訂單數
        Integer totalOrderCount = orderMapper.countByMap(map);

        map.put("status", Orders.COMPLETED);
        // 營業額
        Double turnover = orderMapper.sumByMap(map);
        turnover = turnover == null ? 0.0 : turnover;

        // 有效訂單數
        Integer validOrderCount = orderMapper.countByMap(map);

        Double unitPrice = 0.0;

        Double orderCompletionRate = 0.0;
        if(totalOrderCount != 0 && validOrderCount != 0){
            // 訂單完成率
            orderCompletionRate = validOrderCount.doubleValue() / totalOrderCount;
            // 平均客單價
            unitPrice = turnover / validOrderCount;
        }
        // 新增用戶數
        Integer newCustomerCount = userMapper.countByMap(map);

        return BusinessDataVO.builder()
                .turnover(turnover)
                .validOrderCount(validOrderCount)
                .orderCompletionRate(orderCompletionRate)
                .unitPrice(unitPrice)
                .newCustomerCount(newCustomerCount)
                .build();
    }

}




















