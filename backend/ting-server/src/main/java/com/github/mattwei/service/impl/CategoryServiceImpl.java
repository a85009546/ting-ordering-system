package com.github.mattwei.service.impl;

import com.github.mattwei.entity.Category;
import com.github.mattwei.mapper.CategoryMapper;
import com.github.mattwei.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/14 下午 02:32
 */

@Service
public class CategoryServiceImpl implements CategoryService {

    @Autowired
    private CategoryMapper categoryMapper;

    /**
     * 新增餐點分類
     * @param category
     */
    @Override
    public void save(Category category) {
        // 默認分類狀態為 0-禁用
        category.setStatus(0);
        category.setCreateTime(LocalDateTime.now());
        categoryMapper.insert(category);
    }
}
