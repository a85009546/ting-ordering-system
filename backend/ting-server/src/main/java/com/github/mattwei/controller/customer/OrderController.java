package com.github.mattwei.controller.customer;

import com.github.mattwei.dto.OrderSumbitDTO;
import com.github.mattwei.result.Result;
import com.github.mattwei.service.OrderService;
import com.github.mattwei.vo.OrderSubmitVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
}
