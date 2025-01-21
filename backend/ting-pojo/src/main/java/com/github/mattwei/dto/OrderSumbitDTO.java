package com.github.mattwei.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/21 下午 09:18
 */
@Data
public class OrderSumbitDTO implements Serializable {

    private Long addressBookId;

    // 總金額
    private BigDecimal amount;

    private String remark;

    // 預計送達時間
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime estimatedDeliveryTime;

    // 配送狀態 1立即送出 0選擇具體時間
    private Integer deliveryStatus;

}
