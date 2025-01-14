package com.github.mattwei.controller.admin;

import com.github.mattwei.entity.Category;
import com.github.mattwei.result.Result;
import com.github.mattwei.service.CategoryService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/14 下午 02:27
 */

@RestController
@RequestMapping("/admin/category")
@Slf4j
public class CategoryController {

    @Autowired
    private CategoryService categoryService;


    /**
     * 新增餐點分類
     * @param category
     * @return
     */
    @PostMapping
    public Result save(@RequestBody Category category){
        log.info("新增餐點分類: {}", category);
        categoryService.save(category);
        return Result.success();
    }
}
