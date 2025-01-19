package com.github.mattwei.mapper;

import com.github.mattwei.entity.ShoppingCart;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Update;

import java.util.List;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/19 下午 08:43
 */
@Mapper
public interface ShoppingCartMapper {

    /**
     * 動態條件查詢
     * @param shoppingCart
     * @return
     */
    List<ShoppingCart> list(ShoppingCart shoppingCart);

    /**
     * 根據id修改餐點數量
     * @param shoppingCart
     */
    @Update("update shopping_cart set number = #{number} where id = #{id}")
    void updateNumberById(ShoppingCart shoppingCart);

    /**
     * 插入購物車數據
     * @param shoppingCart
     */
    @Insert("insert into shopping_cart (name, image, user_id, meal_id, meal_flavor, number, amount, create_time) " +
            "values (#{name}, #{image}, #{userId}, #{mealId}, #{mealFlavor}, #{number}, #{amount}, #{createTime})")
    void insert(ShoppingCart shoppingCart);
}
