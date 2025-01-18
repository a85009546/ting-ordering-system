package com.github.mattwei.service.impl;

import com.github.mattwei.constant.MessageConstant;
import com.github.mattwei.constant.StatusConstant;
import com.github.mattwei.dto.MealDTO;
import com.github.mattwei.dto.MealPageQueryDTO;
import com.github.mattwei.entity.Category;
import com.github.mattwei.entity.Meal;
import com.github.mattwei.entity.MealFlavor;
import com.github.mattwei.exception.DeletionNotAllowedException;
import com.github.mattwei.mapper.MealFlavorMapper;
import com.github.mattwei.mapper.MealMapper;
import com.github.mattwei.result.PageResult;
import com.github.mattwei.service.MealService;
import com.github.mattwei.vo.MealVO;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
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

    /**
     * 餐點條件分頁查詢
     * @param mealPageQueryDTO
     * @return
     */
    @Override
    public PageResult pageQuery(MealPageQueryDTO mealPageQueryDTO) {
        PageHelper.startPage(mealPageQueryDTO.getPage(), mealPageQueryDTO.getPageSize());

        Page<MealVO> page = mealMapper.pageQuery(mealPageQueryDTO);

        return new PageResult(page.getTotal(), page.getResult());
    }

    /**
     * 批次刪除餐點
     * @param ids
     */
    @Override
    @Transactional
    public void deleteBatch(List<Long> ids) {
        // 先判斷當前餐點是否能刪除
        // 上架中不能刪
        for (Long id : ids) {
            Meal meal = mealMapper.getById(id);
            if(meal.getStatus() == StatusConstant.ENABLE){
                throw new DeletionNotAllowedException(MessageConstant.MEAL_ON_SALE);
            }
        }
        // 根據id集合批次刪除餐點數據
        // SQL: delete from meal where id in (1,2,3)
        mealMapper.deleteByIds(ids);
        // 根據餐點id集合批次刪除餐點相關的口味數據
        // SQL: delete from meal_flavor where meal_id in (1,2,3)
        mealFlavorMapper.deleteByMealIds(ids);
    }

    /**
     * 根據id查詢餐點和對應的口味
     * @param id
     * @return
     */
    @Override
    public MealVO getByIdWithFlavor(Long id) {
        // 查詢餐點表
        Meal meal = mealMapper.getById(id);
        // 查詢口味表
        List<MealFlavor> flavors = mealFlavorMapper.getByMealId(id);
        // 將查詢結果封裝到 MealVO 中
        MealVO mealVO = new MealVO();
        BeanUtils.copyProperties(meal, mealVO);
        mealVO.setFlavors(flavors);
        return mealVO;
    }

    /**
     * 根據id編輯餐點和對應的口味
     * @param mealDTO
     */
    @Override
    public void updateWithFlavor(MealDTO mealDTO) {
        // 更新餐點表
        Meal meal = new Meal();
        BeanUtils.copyProperties(mealDTO, meal);
        mealMapper.update(meal);

        // 更新口味表，先刪除後再新增
        mealFlavorMapper.deleteByMealId(mealDTO.getId());
        List<MealFlavor> flavors = mealDTO.getMealFlavors();
        if(flavors != null && flavors.size() > 0){
            // 給每個口味數據附上mealId
            flavors.forEach(mealFlavor -> {
                mealFlavor.setMealId(mealDTO.getId());
            });
            // 向口味表插入 n 條數據
            mealFlavorMapper.insertBatch(flavors);
        }
    }


    /**
     * 變更餐點分類狀態
     * @param status
     * @param id
     */
    @Override
    public void changeStatus(Integer status, Long id) {
        Meal meal = Meal.builder()
                .id(id)
                .status(status)
                .updateTime(LocalDateTime.now())
                .build();
        mealMapper.update(meal);
    }
}
