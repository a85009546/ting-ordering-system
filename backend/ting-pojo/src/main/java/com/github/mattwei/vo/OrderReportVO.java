package com.github.mattwei.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/26 下午 12:05
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class OrderReportVO implements Serializable {

    private String dateList;

    // 每日訂單數
    private String orderCountList;

    // 每日有效訂單數
    private String validOrderCountList;

    // 訂單總數
    private Integer totalOrderCount;

    // 有效訂單數
    private Integer validOrderCount;

    // 訂單完成率
    private Double orderCompletionRate;
}
