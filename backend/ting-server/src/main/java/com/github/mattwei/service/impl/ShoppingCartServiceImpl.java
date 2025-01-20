package com.github.mattwei.service.impl;

import com.github.mattwei.context.BaseContext;
import com.github.mattwei.dto.ShoppingCartDTO;
import com.github.mattwei.entity.Meal;
import com.github.mattwei.entity.ShoppingCart;
import com.github.mattwei.mapper.MealMapper;
import com.github.mattwei.mapper.ShoppingCartMapper;
import com.github.mattwei.service.ShoppingCartService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/19 下午 08:29
 */
@Service
public class ShoppingCartServiceImpl implements ShoppingCartService {

    @Autowired
    private ShoppingCartMapper shoppingCartMapper;
    @Autowired
    private MealMapper mealMapper;
    /**
     * 添加購物車
     * @param shoppingCartDTO
     */
    @Override
    public void addShoppingCart(ShoppingCartDTO shoppingCartDTO) {
        // SQL: select * from shopping_cart where user_id = ? and meal_id = ? and meal_flavor = ?
        // 要先判斷商品是否已存在購物車
        ShoppingCart shoppingCart = new ShoppingCart();
        BeanUtils.copyProperties(shoppingCartDTO, shoppingCart);
        Long userId = BaseContext.getCurrentId();
        shoppingCart.setUserId(userId);

        List<ShoppingCart> list = shoppingCartMapper.list(shoppingCart);

        // 如果已存在，只需要將該數量加一
        if(list != null && list.size() > 0){
            ShoppingCart cart = list.get(0);
            cart.setNumber(cart.getNumber() + 1); // update shopping_cart set number = ? where id = ?
            shoppingCartMapper.updateNumberById(cart);
        }else{ // 如果不存在，需要插入一條購物車數據
            // 要查詢當前購物車的數據
            Meal meal = mealMapper.getById(shoppingCartDTO.getMealId());
            shoppingCart.setName(meal.getName());
            shoppingCart.setImage(meal.getImage());
            shoppingCart.setNumber(1); // 首次添加
            shoppingCart.setAmount(meal.getPrice());
            shoppingCart.setCreateTime(LocalDateTime.now());
            shoppingCartMapper.insert(shoppingCart);
        }
    }

    /**
     * 查看購物車
     */
    @Override
    public List<ShoppingCart> showShoppingCart() {
        // 根據當前用戶id查詢
        Long userId = BaseContext.getCurrentId();
        ShoppingCart shoppingCart = ShoppingCart.builder()
                .userId(userId)
                .build();
        List<ShoppingCart> list = shoppingCartMapper.list(shoppingCart);
        return list;
    }
}
