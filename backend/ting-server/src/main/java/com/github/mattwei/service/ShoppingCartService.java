package com.github.mattwei.service;

import com.github.mattwei.dto.ShoppingCartDTO;

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
}
