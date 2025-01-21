package com.github.mattwei.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/21 下午 09:21
 */

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class OrderSubmitVO implements Serializable {

    // 訂單id
    private Long id;

    // 訂單號
    private String orderNumber;

    // 訂單金額
    private BigDecimal orderAmount;

    // 下單時間
    private LocalDateTime orderTime;
}
