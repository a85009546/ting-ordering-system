package com.github.mattwei.mapper;

import com.github.mattwei.dto.CategoryPageQueryDTO;
import com.github.mattwei.entity.Category;
import com.github.pagehelper.Page;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/14 下午 02:36
 */

@Mapper
public interface CategoryMapper {


    /**
     * 插入餐點分類數據
     * @param category
     */
    @Insert("insert into category (name, status, create_time, update_time) " +
            "values (#{name}, #{status}, #{createTime}, #{updateTime})")
    void insert(Category category);

    /**
     * 分類的條件分頁查詢
     * @param categoryPageQueryDTO
     * @return
     */
    Page<Category> pageQuery(CategoryPageQueryDTO categoryPageQueryDTO);

    /**
     * 變更分類狀態
     * @param category
     */
    void update(Category category);

    /**
     * 根據id查詢分類名稱
     * @param id
     * @return
     */
    @Select("select * from category where id = #{id}")
    Category getById(Long id);
}
