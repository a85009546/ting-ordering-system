package com.github.mattwei.controller.customer;

import com.github.mattwei.dto.ShoppingCartDTO;
import com.github.mattwei.entity.ShoppingCart;
import com.github.mattwei.result.Result;
import com.github.mattwei.service.ShoppingCartService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/19 下午 08:25
 */

@RestController
@RequestMapping("/customer/shoppingCart")
@Slf4j
public class ShoppingCartController {

    @Autowired
    private ShoppingCartService shoppingCartService;

    /**
     * 添加購物車
     * @param shoppingCartDTO
     * @return
     */
    @PostMapping("/add")
    public Result add(@RequestBody ShoppingCartDTO shoppingCartDTO) {
        log.info("添加購物車，餐點為: {}", shoppingCartDTO);
        shoppingCartService.addShoppingCart(shoppingCartDTO);
        return Result.success();
    }

    /**
     * 查看購物車
     * @return
     */
    @GetMapping("/list")
    public Result<List<ShoppingCart>> list(){
        List<ShoppingCart> shoppingCartList = shoppingCartService.showShoppingCart();
        return Result.success(shoppingCartList);
    }

    /**
     * 清空購物車
     * @return
     */
    @DeleteMapping("/clean")
    public Result clean(){
        log.info("清空購物車");
        shoppingCartService.clean();
        return Result.success();
    }
}
