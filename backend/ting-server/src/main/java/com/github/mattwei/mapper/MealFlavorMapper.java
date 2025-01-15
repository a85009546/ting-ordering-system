package com.github.mattwei.mapper;

import com.github.mattwei.entity.MealFlavor;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/14 下午 11:04
 */
@Mapper
public interface MealFlavorMapper {

    /**
     * 批量插入口味數據
     * @param flavors
     */
    void insertBatch(List<MealFlavor> flavors);

    /**
     * 根據mealId批次刪除相關的口味數據
     * @param mealIds
     */
    void deleteByMealIds(List<Long> mealIds);
}
