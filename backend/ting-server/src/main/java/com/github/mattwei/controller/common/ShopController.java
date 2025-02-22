package com.github.mattwei.controller.common;

import com.github.mattwei.result.Result;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/18 下午 09:34
 */
@RestController("commonShopController")
@RequestMapping("/shop")
@Slf4j
public class ShopController {

    public static final String KEY = "SHOP_STATUS";

    @Autowired
    private RedisTemplate redisTemplate;


    /**
     * 查詢店家的營業狀態
     */
    @GetMapping("/status")
    public Result<Integer> getStatus(){
        Integer status = (Integer) redisTemplate.opsForValue().get(KEY);
        log.info("獲取到店家的營業狀態為: {}", status == 1 ? "營業中" : "休息中");
        return Result.success(status);
    }
}
