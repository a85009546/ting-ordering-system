package com.github.mattwei.service;

import com.github.mattwei.vo.CustomerReportVO;
import com.github.mattwei.vo.OrderReportVO;
import com.github.mattwei.vo.TurnoverReportVO;

import java.time.LocalDate;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/25 下午 07:39
 */
public interface ReportService {

    /**
     * 統計指定時間區間內的營業額數據
     * @param begin
     * @param end
     * @return
     */
    TurnoverReportVO getTurnoverStatistics(LocalDate begin, LocalDate end);

    /**
     * 統計指定時間區間內的顧客數據
     * @param begin
     * @param end
     * @return
     */
    CustomerReportVO getCustomerStatistics(LocalDate begin, LocalDate end);

    /**
     * 統計指定時間區間內的訂單數據
     * @param begin
     * @param end
     * @return
     */
    OrderReportVO getOrdersStatistics(LocalDate begin, LocalDate end);
}
