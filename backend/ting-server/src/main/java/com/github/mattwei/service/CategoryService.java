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
}
