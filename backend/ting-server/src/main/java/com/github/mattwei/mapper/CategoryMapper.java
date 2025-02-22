package com.github.mattwei.mapper;

import com.github.mattwei.annotation.AutoFill;
import com.github.mattwei.dto.CategoryPageQueryDTO;
import com.github.mattwei.entity.Category;
import com.github.mattwei.enumeration.OperationType;
import com.github.mattwei.vo.CategoryVO;
import com.github.pagehelper.Page;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

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
    @AutoFill(value = OperationType.INSERT)
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

    /**
     * 根據id刪除分類
     * @param id
     */
    @Delete("delete from category where id = #{id}")
    void deleteById(Long id);

    /**
     * 獲取啟用中的所有分類
     * @return
     */
    @Select("select * from category where status = 1")
    List<CategoryVO> list();
}
