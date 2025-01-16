package com.github.mattwei.dto;

import com.github.mattwei.entity.MealFlavor;
import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/14 下午 10:49
 */

@Data
public class MealDTO implements Serializable {


    private Long id;

    private String name;

    private Long categoryId;

    private BigDecimal price;

    private List<MealFlavor> mealFlavors = new ArrayList<>();

    private String image;

    private String description;
}
