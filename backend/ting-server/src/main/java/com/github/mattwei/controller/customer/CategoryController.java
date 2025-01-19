package com.github.mattwei.controller.customer;

import com.github.mattwei.result.Result;
import com.github.mattwei.service.CategoryService;
import com.github.mattwei.vo.CategoryVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * Description:
 *  顧客端 分類控制
 * @Author Matt Wei
 * @Create 2025/1/19 上午 10:30
 */
@RestController("customerCategoryController")
@RequestMapping("/customer/category")
@Slf4j
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

    /**
     * 獲取啟用中的分類列表，用在餐點瀏覽時，顯示所有分類
     * @return
     */
    @GetMapping
    public Result<List<CategoryVO>> list(){
        return Result.success(categoryService.list());
    }
}
