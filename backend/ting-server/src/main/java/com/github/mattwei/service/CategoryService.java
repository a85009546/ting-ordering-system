package com.github.mattwei.service;

import com.github.mattwei.entity.Category;

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
}
