package com.github.mattwei.service;

import com.github.mattwei.dto.OrderSumbitDTO;
import com.github.mattwei.dto.OrdersConfirmDTO;
import com.github.mattwei.dto.OrdersPageQueryDTO;
import com.github.mattwei.dto.OrdersRejectionDTO;
import com.github.mattwei.result.PageResult;
import com.github.mattwei.vo.OrderStatisticsVO;
import com.github.mattwei.vo.OrderSubmitVO;
import com.github.mattwei.vo.OrderVO;

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

    /**
     * 管理端 - 訂單條件分頁查詢
     * @param ordersPageQueryDTO
     * @return
     */
    PageResult conditionSearch(OrdersPageQueryDTO ordersPageQueryDTO);

    /**
     * 管理端 - 各個狀態的訂單數量統計
     * @return
     */
    OrderStatisticsVO statistics();

    /**
     * 管理端 - 查詢訂單詳情
     * @param id
     * @return
     */
    OrderVO details(Long id);

    /**
     * 管理端 - 接單
     * @param ordersConfirmDTO
     */
    void confirm(OrdersConfirmDTO ordersConfirmDTO);

    /**
     * 管理端 - 拒單
     * @param ordersRejectionDTO
     */
    void rejection(OrdersRejectionDTO ordersRejectionDTO);
}
