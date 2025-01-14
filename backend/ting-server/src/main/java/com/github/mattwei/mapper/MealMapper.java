package com.github.mattwei.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/14 下午 06:15
 */
@Mapper
public interface MealMapper {
    /**
     * 根據分類id查詢餐點數量
     * @param id
     * @return
     */
    @Select("select count(id) from meal where category_id = #{categoryId}")
    Integer countByCategoryId(Long categoryId);
}
