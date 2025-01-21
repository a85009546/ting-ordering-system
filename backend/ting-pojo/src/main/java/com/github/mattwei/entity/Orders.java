package com.github.mattwei.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/21 下午 09:43
 */

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Orders implements Serializable {

    /**
     * 訂單狀態 1待接單 2已接單 3派送中 4已完成 5退款
     */
    public static final Integer TO_BE_CONFIRMED = 1;
    public static final Integer CONFIRMED = 2;
    public static final Integer DELIVERY_IN_PROGRESS = 3;
    public static final Integer COMPLETED = 4;
    public static final Integer CANCELLED = 5;

    /**
     * 支付狀態 1已支付 2退款
     */
    public static final Integer PAYED = 1;
    public static final Integer REFUND = 2;

    private static final long serialVersionUID = 1L;

    private Long id;
    // 訂單號
    private String number;

    // 訂單狀態 1待接單 2已接單 3派送中 4已完成 5退款
    private Integer status;

    // 下單用戶id
    private Long userId;

    private Long addressBookId;

    private LocalDateTime orderTime;

    // 支付狀態 1已支付 2退款
    private Integer payStatus;

    // 實收金額
    private BigDecimal amount;

    private String remark;

    private String phone;

    // 詳細地址
    private String address;

    private String userName;

    private String consignee;

    // 拒單原因
    private String rejectionReason;

    private LocalDateTime estimatedDeliveryTime;

    // 配送狀態 1立即送出 0選擇具體時間
    private Integer deliveryStatus;

    // 送達時間
    private LocalDateTime deliveryTime;
}
