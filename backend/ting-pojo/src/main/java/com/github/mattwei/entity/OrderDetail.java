package com.github.mattwei.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/21 下午 10:11
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class OrderDetail implements Serializable {


    private static final long serialVersionUID = 1L;

    private Long id;

    private String name;

    private String image;

    private Long orderId;

    private Long mealId;

    private String MealFlavor;

    private Integer number;

    private BigDecimal amount;
}
