package com.github.mattwei.controller.admin;

import com.github.mattwei.dto.OrdersPageQueryDTO;
import com.github.mattwei.entity.Orders;
import com.github.mattwei.result.PageResult;
import com.github.mattwei.result.Result;
import com.github.mattwei.service.OrderService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/23 上午 10:29
 */
@RestController("adminOrderController")
@RequestMapping("/admin/order")
@Slf4j
public class OrderController {


    @Autowired
    private OrderService orderService;
    /**
     * 訂單條件分頁查詢
     * @param ordersPageQueryDTO
     * @return
     */
    @GetMapping("/conditionSearch")
    public Result<PageResult> conditionSearch(OrdersPageQueryDTO ordersPageQueryDTO){
        PageResult pageResult = orderService.conditionSearch(ordersPageQueryDTO);
        return Result.success(pageResult);
    }
}
