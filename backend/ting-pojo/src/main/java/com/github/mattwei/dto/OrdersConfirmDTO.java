package com.github.mattwei.dto;

import lombok.Data;

import java.io.Serializable;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/23 下午 01:29
 */
@Data
public class OrdersConfirmDTO implements Serializable {

    private Long id;

    // 訂單狀態 1待支付 2待接單 3已接單 4派送中 5已完成 6已取消 7退款
    private Integer status;
}
