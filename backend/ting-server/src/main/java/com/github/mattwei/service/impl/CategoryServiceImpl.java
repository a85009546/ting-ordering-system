package com.github.mattwei.service.impl;

import com.github.mattwei.constant.MessageConstant;
import com.github.mattwei.dto.CategoryPageQueryDTO;
import com.github.mattwei.entity.Category;
import com.github.mattwei.exception.DeletionNotAllowedException;
import com.github.mattwei.mapper.CategoryMapper;
import com.github.mattwei.mapper.MealMapper;
import com.github.mattwei.result.PageResult;
import com.github.mattwei.service.CategoryService;
import com.github.mattwei.vo.CategoryVO;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

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
    @Autowired
    private MealMapper mealMapper;

    /**
     * 新增餐點分類
     * @param category
     */
    @Override
    public void save(Category category) {
        // 默認分類狀態為 0-禁用
        category.setStatus(0);
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
    public CategoryVO getById(Long id) {
        Category category = categoryMapper.getById(id);
        CategoryVO categoryVO = CategoryVO.builder()
                .id(category.getId())
                .name(category.getName())
                .build();
        return categoryVO;
    }

    /**
     * 修改分類
     * @param category
     */
    @Override
    public void update(Category category) {
        category.setUpdateTime(LocalDateTime.now());
        categoryMapper.update(category);
    }

    /**
     * 根據id刪除分類
     * @param id
     */
    @Override
    public void deleteById(Long id) {
        // 查詢當前分類下是否有餐點，如果有則拋出異常
        Integer count = mealMapper.countByCategoryId(id);
        if(count > 0){
            // 當前分類有餐點，不能刪除
            throw new DeletionNotAllowedException(MessageConstant.CATEGORY_BE_RELATED_BY_MEAL);
        }
        // 若沒有拋出異常，則刪除
        categoryMapper.deleteById(id);
    }

    /**
     * 獲取分類列表
     * @return
     */
    @Override
    public List<CategoryVO> list() {
        return categoryMapper.list();
    }
}
