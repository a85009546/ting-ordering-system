package com.github.mattwei.service;

import com.github.mattwei.dto.CategoryPageQueryDTO;
import com.github.mattwei.entity.Category;
import com.github.mattwei.result.PageResult;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/14 下午 02:32
 */
public interface CategoryService {
    /**
     * 新增餐點分類
     * @param category
     */
    void save(Category category);

    /**
     * 分類的條件分頁查詢
     * @param categoryPageQueryDTO
     * @return
     */
    PageResult pageQuery(CategoryPageQueryDTO categoryPageQueryDTO);

    /**
     * 變更分類狀態
     * @param status
     * @param id
     */
    void changeStatus(Integer status, Long id);

    /**
     * 根據id查詢分類名稱
     * @param id
     * @return
     */
    String getNameById(Long id);

    /**
     * 修改分類
     * @param category
     */
    void update(Category category);

    /**
     * 根據id刪除分類
     * @param id
     */
    void deleteById(Long id);
}
