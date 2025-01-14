package com.github.mattwei.service.impl;

import com.github.mattwei.dto.MealDTO;
import com.github.mattwei.entity.Meal;
import com.github.mattwei.entity.MealFlavor;
import com.github.mattwei.mapper.MealFlavorMapper;
import com.github.mattwei.mapper.MealMapper;
import com.github.mattwei.service.MealService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/14 下午 10:54
 */
@Service
public class MealServiceImpl implements MealService {

    @Autowired
    private MealMapper mealMapper;
    @Autowired
    private MealFlavorMapper mealFlavorMapper;

    /**
     * 新增餐點以及對應的口味數據
     * @param mealDTO
     */
    @Override
    @Transactional
    public void saveWithFlavor(MealDTO mealDTO) {

        Meal meal = new Meal();
        BeanUtils.copyProperties(mealDTO, meal);
        // 默認餐點狀態為 1-上架
        meal.setStatus(1);
        // 向餐點表插入 1 條數據
        mealMapper.insert(meal);

        // 獲取insert語句生成的主鍵值
        Long mealId = meal.getId();

        List<MealFlavor> flavors = mealDTO.getMealFlavors();
        // 判斷有無口味數據
        if(flavors != null && flavors.size() > 0){
            // 給每個口味數據附上mealId
            flavors.forEach(mealFlavor -> {
                mealFlavor.setMealId(mealId);
            });
            // 向口味表插入 n 條數據
            mealFlavorMapper.insertBatch(flavors);
        }
    }
}
