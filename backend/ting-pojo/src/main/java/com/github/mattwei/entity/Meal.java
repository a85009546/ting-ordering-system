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
 *  餐點
 * @Author Matt Wei
 * @Create 2025/1/12 下午 10:50
 */

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Meal implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long id;

    private String name;

    private Long categoryId;

    private BigDecimal price;

    private String image;

    private String description;

    // 餐點狀態 0:下架 1:上架
    private Integer status;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;
}
