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
 * @Create 2025/1/26 下午 08:49
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class BusinessDataVO implements Serializable {

    private Double turnover;

    private Integer validOrderCount;

    private Double orderCompletionRate;

    // 平均客單價
    private Double unitPrice;

    // 新增用戶數
    private Integer newCustomerCount;
}
