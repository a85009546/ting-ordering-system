package com.github.mattwei.controller.customer;

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
     * 根據分類id分頁查詢餐點及其對應的口味，並且只顯示上架中的
     * @param mealPageQueryDTO
     * @return
     */
//    @GetMapping("/page")
//    public Result<PageResult> page(MealPageQueryDTO mealPageQueryDTO){
//        // 構造 redis 中的 key，規則: meal_分類id_page_當前頁數_size_當前頁面大小_總條數
//        Integer total = mealMapper.countByCategoryId(mealPageQueryDTO.getCategoryId());
//        String key = "meal_" + mealPageQueryDTO.getCategoryId() +
//                    ":page_" + mealPageQueryDTO.getPage() +
//                ":size_" + mealPageQueryDTO.getPageSize() + ":total_" + total;
//
//        // 查詢 redis 中是否存在餐點數據
//        List<MealVO> list = (List<MealVO>) redisTemplate.opsForValue().get(key);
//        if(list != null && list.size() > 0){
//            // 如果存在，直接返回，無須查詢DB
//            PageResult pageResult = new PageResult();
//            // 要去查詢當前分類的總數，不能以list大小當作總條數
//            // 根據分類id查詢餐點數量
//            pageResult.setTotal(total.longValue());
//            pageResult.setRecords(list); // 將列表設為當前頁的數據
//            return Result.success(pageResult);
//        }
//
//        // 如果不存在，查詢DB，將查詢到的數據放入 redis
//        log.info("根據分類id查詢餐點: {}", mealPageQueryDTO);
//        // 查詢上架中的
//        mealPageQueryDTO.setStatus(1);
//        PageResult pageResult = mealService.pageQueryWithFlavor(mealPageQueryDTO);
//        // 如果 Redis 沒有數據，將查詢結果放入 Redis
//        redisTemplate.opsForValue().set(key, pageResult.getRecords());
//        return Result.success(pageResult);
//    }

    /**
     * 根據分類id查詢餐點及其口味數據
     * @param categoryId
     * @return
     */
    @GetMapping("/list")
    public Result<List<MealVO>> list(Long categoryId){
        List<MealVO> list = mealService.listWithFlavor(categoryId);
        return Result.success(list);
    }
}
