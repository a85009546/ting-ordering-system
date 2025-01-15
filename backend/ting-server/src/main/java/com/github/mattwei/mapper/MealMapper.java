package com.github.mattwei.mapper;

import com.github.mattwei.annotation.AutoFill;
import com.github.mattwei.dto.MealPageQueryDTO;
import com.github.mattwei.entity.Meal;
import com.github.mattwei.enumeration.OperationType;
import com.github.mattwei.vo.MealVO;
import com.github.pagehelper.Page;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

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
     * @param categoryId
     * @return
     */
    @Select("select count(id) from meal where category_id = #{categoryId}")
    Integer countByCategoryId(Long categoryId);

    /**
     * 插入餐點數據
     * @param meal
     */
    @AutoFill(value = OperationType.INSERT)
    void insert(Meal meal);

    /**
     * 分頁查詢
     * @param mealPageQueryDTO
     * @return
     */
    Page<MealVO> pageQuery(MealPageQueryDTO mealPageQueryDTO);

    /**
     * 根據id查詢餐點
     * @param id
     * @return
     */
    @Select("select * from meal where id = #{id}")
    Meal getById(Long id);


    /**
     * 根據id集合批次刪除餐點數據
     * @param ids
     */
    void deleteByIds(List<Long> ids);
}
