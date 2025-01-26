package com.github.mattwei.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/26 下午 02:48
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MealSalesDTO implements Serializable {

    // 餐點名稱
    private String name;

    // 銷量
    private Integer number;
}
