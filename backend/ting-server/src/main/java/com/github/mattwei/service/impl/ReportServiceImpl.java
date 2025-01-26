package com.github.mattwei.service.impl;

import com.github.mattwei.entity.Orders;
import com.github.mattwei.mapper.OrderMapper;
import com.github.mattwei.mapper.UserMapper;
import com.github.mattwei.service.ReportService;
import com.github.mattwei.vo.CustomerReportVO;
import com.github.mattwei.vo.TurnoverReportVO;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

        // turnoverList
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
        }

        return TurnoverReportVO.builder()
                .dateList(StringUtils.join(dateList, ","))
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
        }
        return CustomerReportVO.builder()
                .dateList(StringUtils.join(dateList, ","))
                .totalCustomerList(StringUtils.join(totalCustomerList, ","))
                .newCustomerList(StringUtils.join(newCustomerList, ","))
                .build();
    }
}
