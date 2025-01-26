package com.github.mattwei.controller.admin;

import com.github.mattwei.result.Result;
import com.github.mattwei.service.ReportService;
import com.github.mattwei.vo.CustomerReportVO;
import com.github.mattwei.vo.OrderReportVO;
import com.github.mattwei.vo.TurnoverReportVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;

/**
 * Description:
 *  數據統計
 * @Author Matt Wei
 * @Create 2025/1/25 下午 07:32
 */
@RestController
@RequestMapping("/admin/report")
@Slf4j
public class ReportController {

    @Autowired
    private ReportService reportService;
    /**
     * 營業額統計
     * @param begin
     * @param end
     * @return
     */
    @GetMapping("/turnoverStatistics")
    public Result<TurnoverReportVO> turnoverStatistics(
            @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate begin,
            @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate end) {
        log.info("營業額數據統計: {}, {}", begin, end);
        return Result.success(reportService.getTurnoverStatistics(begin, end));
    }

    /**
     * 顧客數統計
     * @param begin
     * @param end
     * @return
     */
    @GetMapping("/customerStatistics")
    public Result<CustomerReportVO> customerStatistics(
            @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate begin,
            @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate end){
        log.info("顧客數據計: {}, {}", begin, end);
        return Result.success(reportService.getCustomerStatistics(begin, end));
    }

    /**
     * 訂單數據統計
     * @param begin
     * @param end
     * @return
     */
    @GetMapping("/ordersStatistics")
    public Result<OrderReportVO> ordersStatistics(
            @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate begin,
            @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate end){
        log.info("訂單數據統計: {}, {}", begin, end);
        return Result.success(reportService.getOrdersStatistics(begin, end));
    }

}

















