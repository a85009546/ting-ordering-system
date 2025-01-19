package com.github.mattwei.controller.customer;

import com.github.mattwei.constant.StatusConstant;
import com.github.mattwei.dto.MealPageQueryDTO;
import com.github.mattwei.entity.Meal;
import com.github.mattwei.mapper.MealMapper;
import com.github.mattwei.result.PageResult;
import com.github.mattwei.result.Result;
import com.github.mattwei.service.MealService;
import com.github.mattwei.vo.MealVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

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
    @Autowired
    private RedisTemplate redisTemplate;
    @Autowired
    private MealMapper mealMapper;



    /**
     * 根據分類id查詢餐點及其口味數據
     * @param categoryId
     * @return
     */
    @GetMapping("/list")
    public Result<List<MealVO>> list(Long categoryId){
        // 構造 redis 中的 key，規則: meal_分類id
        String key = "meal_" + categoryId;

        // 查詢 redis 中是否存在餐點數據
        List<MealVO> list = (List<MealVO>) redisTemplate.opsForValue().get(key);
        if(list != null && list.size() > 0){
            // 如果存在，直接返回，無須查詢DB
            return Result.success(list);
        }

        log.info("根據分類id查詢餐點: {}", categoryId);
        Meal meal = new Meal();
        meal.setCategoryId(categoryId);
        meal.setStatus(StatusConstant.ENABLE); // 查詢上架中的
        // 如果不存在，查詢DB，將查詢到的數據放入 redis
        list = mealService.listWithFlavor(meal);
        redisTemplate.opsForValue().set(key, list);

        return Result.success(list);
    }
}
