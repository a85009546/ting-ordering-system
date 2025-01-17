package com.github.mattwei.controller.admin;

import com.github.mattwei.dto.MealDTO;
import com.github.mattwei.dto.MealPageQueryDTO;
import com.github.mattwei.result.PageResult;
import com.github.mattwei.result.Result;
import com.github.mattwei.service.MealService;
import com.github.mattwei.service.impl.MealServiceImpl;
import com.github.mattwei.vo.MealVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Description:
 *  餐點管理
 * @Author Matt Wei
 * @Create 2025/1/14 下午 10:51
 */

@RestController
@RequestMapping("/admin/meal")
@Slf4j
public class MealController {

    @Autowired
    private MealService mealService;

    /**
     * 新增餐點
     * @param mealDTO
     * @return
     */
    @PostMapping
    public Result save(@RequestBody MealDTO mealDTO){
        log.info("新增餐點: {}", mealDTO);
        mealService.saveWithFlavor(mealDTO);
        return Result.success();
    }

    /**
     * 餐點的條件分頁查詢
     * @param mealPageQueryDTO
     * @return
     */
    @GetMapping("/page")
    public Result<PageResult> page(MealPageQueryDTO mealPageQueryDTO){
        log.info("餐點分頁查詢: {}", mealPageQueryDTO);
        PageResult pageResult = mealService.pageQuery(mealPageQueryDTO);
        return Result.success(pageResult);
    }

    /**
     * 批次刪除餐點
     * @param ids
     * @return
     */
    @DeleteMapping
    public Result delete(@RequestParam List<Long> ids){
        log.info("批次刪除餐點: {}", ids);
        mealService.deleteBatch(ids);
        return Result.success();
    }

    /**
     * 根據id查詢餐點和對應的口味
     * @param id
     * @return
     */
    @GetMapping("/{id}")
    public Result<MealVO> getById(@PathVariable Long id){
        log.info("根據id查詢餐點: {}", id);
        MealVO mealVO = mealService.getByIdWithFlavor(id);
        return Result.success(mealVO);
    }

    /**
     * 編輯餐點
     * @param mealDTO
     * @return
     */
    @PutMapping
    public Result update(@RequestBody MealDTO mealDTO){
        log.info("編輯餐點: {}", mealDTO);
        mealService.updateWithFlavor(mealDTO);
        return Result.success();
    }
}
