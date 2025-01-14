package com.github.mattwei.controller.admin;

import com.github.mattwei.dto.MealDTO;
import com.github.mattwei.result.Result;
import com.github.mattwei.service.MealService;
import com.github.mattwei.service.impl.MealServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
}
