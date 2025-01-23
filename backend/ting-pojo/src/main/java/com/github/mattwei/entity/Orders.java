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
     * 訂單狀態 1待支付 2待接單 3已接單 4派送中 5已完成 6已取消 7退款
     */
    public static final Integer PENDING_PAYMENT = 1;
    public static final Integer TO_BE_CONFIRMED = 2;
    public static final Integer CONFIRMED = 3;
    public static final Integer DELIVERY_IN_PROGRESS = 4;
    public static final Integer COMPLETED = 5;
    public static final Integer CANCELLED = 6;

    /**
     * 支付狀態 1已支付 2退款
     */
    public static final Integer UN_PAID = 0;
    public static final Integer PAYED = 1;
    public static final Integer REFUND = 2;

    private static final long serialVersionUID = 1L;

    private Long id;
    // 訂單號
    private String number;

    // 訂單狀態 1待支付 2待接單 3已接單 4派送中 5已完成 6已取消 7退款
    private Integer status;

    // 下單用戶id
    private Long userId;

    private Long addressBookId;

    private LocalDateTime orderTime;

    // 結帳時間
    private LocalDateTime checkoutTime;

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

    // 訂單取消原因
    private String cancelReason;

    // 拒單原因
    private String rejectionReason;

    // 訂單取消時間
    private LocalDateTime cancelTime;

    private LocalDateTime estimatedDeliveryTime;

    // 配送狀態 1立即送出 0選擇具體時間
    private Integer deliveryStatus;

    // 送達時間
    private LocalDateTime deliveryTime;
}
