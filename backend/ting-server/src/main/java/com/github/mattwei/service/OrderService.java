package com.github.mattwei.service;

import com.github.mattwei.dto.OrderSumbitDTO;
import com.github.mattwei.vo.OrderSubmitVO;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/21 下午 09:26
 */
public interface OrderService {
    /**
     * 顧客下單
     * @param orderSumbitDTO
     * @return
     */
    OrderSubmitVO submitOrder(OrderSumbitDTO orderSumbitDTO);
}
