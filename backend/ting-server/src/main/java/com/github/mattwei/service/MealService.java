package com.github.mattwei.service;

import com.github.mattwei.dto.MealDTO;
import com.github.mattwei.dto.MealPageQueryDTO;
import com.github.mattwei.entity.Meal;
import com.github.mattwei.result.PageResult;
import com.github.mattwei.vo.MealVO;

import java.util.List;

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

    /**
     * 餐點條件分頁查詢
     * @param mealPageQueryDTO
     * @return
     */
    PageResult pageQuery(MealPageQueryDTO mealPageQueryDTO);

    /**
     * 批次刪除餐點
     * @param ids
     */
    void deleteBatch(List<Long> ids);

    /**
     * 根據id查詢餐點和對應的口味
     * @param id
     * @return
     */
    MealVO getByIdWithFlavor(Long id);

    /**
     * 編輯餐點
     * @param mealDTO
     */
    void updateWithFlavor(MealDTO mealDTO);

    /**
     * 變更餐點分類狀態
     * @param status
     * @param id
     */
    void changeStatus(Integer status, Long id);


    /**
     * 根據分類id查詢餐點及其口味數據
     * @param meal
     * @return
     */
    List<MealVO> listWithFlavor(Meal meal);
}
