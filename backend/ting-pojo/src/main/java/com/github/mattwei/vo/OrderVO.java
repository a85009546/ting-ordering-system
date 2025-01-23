package com.github.mattwei.vo;

import com.github.mattwei.entity.OrderDetail;
import com.github.mattwei.entity.Orders;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.List;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/23 下午 01:06
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderVO extends Orders implements Serializable {

    // 訂單餐點訊息
    private String orderMeals;

    // 訂單詳情
    private List<OrderDetail> orderDetailList;
}
