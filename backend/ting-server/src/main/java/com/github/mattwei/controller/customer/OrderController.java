package com.github.mattwei.controller.customer;

import com.github.mattwei.dto.OrderSumbitDTO;
import com.github.mattwei.result.PageResult;
import com.github.mattwei.result.Result;
import com.github.mattwei.service.OrderService;
import com.github.mattwei.vo.OrderSubmitVO;
import com.github.mattwei.vo.OrderVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/21 下午 09:24
 */
@RestController("customerOrderController")
@RequestMapping("/customer/order")
@Slf4j
public class OrderController {

    @Autowired
    private OrderService orderService;

    /**
     * 顧客下單
     * @param orderSumbitDTO
     * @return
     */
    @PostMapping("/submit")
    public Result<OrderSubmitVO> submit(@RequestBody OrderSumbitDTO orderSumbitDTO){
        log.info("顧客下單: {}", orderSumbitDTO);
        OrderSubmitVO orderSubmitVO = orderService.submitOrder(orderSumbitDTO);
        return Result.success(orderSubmitVO);
    }

    /**
     * 顧客支付
     * @param id
     * @return
     */
    @PutMapping("/pay/{id}")
    public Result pay(@PathVariable Long id){
        log.info("顧客支付，訂單id為: {}", id);
        orderService.payOrder(id);
        return Result.success();
    }

    /**
     * 歷史訂單分頁查詢
     * @param page
     * @param pageSize
     * @param status
     * @return
     */
    @GetMapping("/historyOrders")
    public Result<PageResult> page(int page, int pageSize, Integer status){
        PageResult pageResult = orderService.pageQuery4Customer(page, pageSize, status);
        return Result.success(pageResult);
    }

    /**
     * 查詢訂單詳情
     * @param id
     * @return
     */
    @GetMapping("orderDetail/{id}")
    public Result<OrderVO> details(@PathVariable Long id){
        OrderVO orderVO = orderService.details(id);
        return Result.success(orderVO);
    }

    /**
     * 顧客取消訂單
     * @param id
     * @return
     */
    @PutMapping("/cancel/{id}")
    public Result cancel(@PathVariable Long id){
        orderService.userCancelById(id);
        return Result.success();
    }

    /**
     * 顧客再來一單
     * @param id
     * @return
     */
    @PostMapping("/repetition/{id}")
    public Result repetition(@PathVariable Long id){
        orderService.repetition(id);
        return Result.success();
    }

    /**
     * 顧客催單
     * @param id
     * @return
     */
    @GetMapping("/reminder/{id}")
    public Result reminder(@PathVariable Long id){
        orderService.reminder(id);
        return Result.success();
    }
}
