package com.github.mattwei.dto;

import lombok.Data;

import java.io.Serializable;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/19 下午 08:23
 */
@Data
public class ShoppingCartDTO implements Serializable {

    private Long mealId;

    private String mealFlavor;
}
