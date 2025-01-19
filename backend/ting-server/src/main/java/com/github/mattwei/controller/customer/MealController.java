package com.github.mattwei.controller.customer;

import com.github.mattwei.dto.MealPageQueryDTO;
import com.github.mattwei.result.PageResult;
import com.github.mattwei.result.Result;
import com.github.mattwei.service.MealService;
import com.github.mattwei.vo.MealVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Description:
 *  顧客端餐點管理
 * @Author Matt Wei
 * @Create 2025/1/19 上午 09:30
 */
@RestController("customerMealController")
@RequestMapping("/customer/meal")
@Slf4j
public class MealController {

    @Autowired
    private MealService mealService;

    /**
     * 餐點根據分類id分頁查詢，並且只顯示上架中的
     * @param mealPageQueryDTO
     * @return
     */
    @GetMapping("/page")
    public Result<PageResult> page(MealPageQueryDTO mealPageQueryDTO){
        log.info("根據分類id查詢餐點: {}", mealPageQueryDTO);
        // 查詢上架中的
        mealPageQueryDTO.setStatus(1);
        PageResult pageResult = mealService.pageQuery(mealPageQueryDTO);
        return Result.success(pageResult);
    }
}
