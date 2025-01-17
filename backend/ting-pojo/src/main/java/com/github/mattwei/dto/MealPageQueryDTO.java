package com.github.mattwei.dto;

import lombok.Data;

import java.io.Serializable;

/**
 * Description:
 *  封裝餐點的查詢條件
 * @Author Matt Wei
 * @Create 2025/1/15 上午 09:40
 */
@Data
public class MealPageQueryDTO implements Serializable {

    private String name;

    private Long categoryId;

    private Integer status;

    private Integer page;

    private Integer pageSize;
}
