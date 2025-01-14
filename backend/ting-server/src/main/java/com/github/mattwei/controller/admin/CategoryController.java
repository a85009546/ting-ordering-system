package com.github.mattwei.controller.admin;

import com.github.mattwei.dto.CategoryPageQueryDTO;
import com.github.mattwei.entity.Category;
import com.github.mattwei.result.PageResult;
import com.github.mattwei.result.Result;
import com.github.mattwei.service.CategoryService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

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

    /**
     * 分類的條件分頁查詢
     * @param categoryPageQueryDTO
     * @return
     */
    @GetMapping("/page")
    public Result<PageResult> page(CategoryPageQueryDTO categoryPageQueryDTO){
        log.info("分類分頁查詢，參數為: {}", categoryPageQueryDTO);
        PageResult pageResult = categoryService.pageQuery(categoryPageQueryDTO);
        return Result.success(pageResult);
    }

    /**
     * 變更分類狀態
     * @param status
     * @param id
     * @return
     */
    @PostMapping("/status/{status}")
    public Result changeStatus(@PathVariable Integer status, Long id){
        log.info("修改分類狀態，參數為: {}, {}", status, id);
        categoryService.changeStatus(status, id);
        return Result.success();
    }

    /**
     * 根據id查詢分類
     * @param id
     * @return
     */
    @GetMapping("/{id}")
    public Result<String> getNameById(@PathVariable Long id){
        log.info("根據id查詢分類名稱，參數為: {}", id);
        String name = categoryService.getNameById(id);
        return Result.success(name);
    }

    /**
     * 修改分類
     * @param category
     * @return
     */
    @PutMapping
    public Result update(@RequestBody Category category){
        categoryService.update(category);
        return Result.success();
    }


}
