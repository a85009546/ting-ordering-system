package com.github.mattwei.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/19 下午 08:18
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ShoppingCart implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long id;

    private String name;

    private String image;

    private Long userId;

    private Long mealId;

    private String mealFlavor;

    private Integer number; // 數量

    private BigDecimal amount; // 金額

    private LocalDateTime createTime;
}
