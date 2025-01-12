package com.github.mattwei.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * Description:
 *  餐點口味關係
 * @Author Matt Wei
 * @Create 2025/1/12 下午 10:53
 */

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MealFlavor implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long id;

    private Long mealId;

    private String name;

    // 口味數據列表
    private String value;
}
