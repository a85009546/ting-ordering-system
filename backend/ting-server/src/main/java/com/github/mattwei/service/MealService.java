package com.github.mattwei.service;

import com.github.mattwei.dto.MealDTO;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/14 下午 10:54
 */
public interface MealService {
    /**
     * 新增餐點以及對應的口味數據
     * @param mealDTO
     */
    void saveWithFlavor(MealDTO mealDTO);
}
