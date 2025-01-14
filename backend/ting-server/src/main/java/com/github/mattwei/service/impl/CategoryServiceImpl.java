package com.github.mattwei.service.impl;

import com.github.mattwei.dto.CategoryPageQueryDTO;
import com.github.mattwei.entity.Category;
import com.github.mattwei.mapper.CategoryMapper;
import com.github.mattwei.result.PageResult;
import com.github.mattwei.service.CategoryService;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
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

    /**
     * 分類的條件分頁查詢
     * @param categoryPageQueryDTO
     * @return
     */
    @Override
    public PageResult pageQuery(CategoryPageQueryDTO categoryPageQueryDTO) {
        PageHelper.startPage(categoryPageQueryDTO.getPage(), categoryPageQueryDTO.getPageSize());
        Page<Category> page = categoryMapper.pageQuery(categoryPageQueryDTO);
        return new PageResult(page.getTotal(), page.getResult());
    }

    /**
     * 變更分類狀態
     * @param status
     * @param id
     */
    @Override
    public void changeStatus(Integer status, Long id) {
        Category category = Category.builder()
                .id(id)
                .status(status)
                .updateTime(LocalDateTime.now())
                .build();
        categoryMapper.update(category);
    }

    /**
     * 根據id查詢分類名稱
     * @param id
     * @return
     */
    @Override
    public String getNameById(Long id) {
        Category category = categoryMapper.getById(id);
        return category.getName();
    }
}
