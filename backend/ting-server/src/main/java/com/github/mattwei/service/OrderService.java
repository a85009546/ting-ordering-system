package com.github.mattwei.service;

import com.github.mattwei.dto.*;
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
     * 顧客支付
     * @param id
     */
    void payOrder(Long id);

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
     * 查詢訂單詳情
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

    /**
     * 管理端 - 取消訂單
     * @param ordersCancelDTO
     */
    void cancel(OrdersCancelDTO ordersCancelDTO);

    /**
     * 管理端 - 派送訂單
     * @param id
     */
    void delivery(Long id);

    /**
     * 管理端 - 完成訂單
     * @param id
     */
    void complete(Long id);


    /**
     * 顧客端 - 訂單分頁查詢
     * @param page
     * @param pageSize
     * @param status
     * @return
     */
    PageResult pageQuery4Customer(int page, int pageSize, Integer status);

    /**
     * 顧客端 - 取消訂單
     * @param id
     */
    void userCancelById(Long id);

    /**
     * 顧客端 - 再來一單
     * @param id
     */
    void repetition(Long id);

    /**
     * 顧客端 - 催單
     * @param id
     */
    void reminder(Long id);
}
