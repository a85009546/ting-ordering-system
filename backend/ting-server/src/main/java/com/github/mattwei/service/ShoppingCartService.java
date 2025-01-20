package com.github.mattwei.service;

import com.github.mattwei.dto.ShoppingCartDTO;
import com.github.mattwei.entity.ShoppingCart;

import java.util.List;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/19 下午 08:29
 */
public interface ShoppingCartService {

    /**
     * 添加購物車
     * @param shoppingCartDTO
     */
    void addShoppingCart(ShoppingCartDTO shoppingCartDTO);


    /**
     * 查看購物車
     */
    List<ShoppingCart> showShoppingCart();
}
