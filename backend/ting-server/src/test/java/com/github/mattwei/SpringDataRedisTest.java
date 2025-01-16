package com.github.mattwei;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.redis.core.*;

import java.util.List;
import java.util.Set;
import java.util.concurrent.TimeUnit;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/15 下午 01:46
 */
//@SpringBootTest
public class SpringDataRedisTest {
    @Autowired
    private RedisTemplate redisTemplate;


    @Test
    public void testRedisTemplate(){
        System.out.println(redisTemplate);
        ValueOperations valueOperations = redisTemplate.opsForValue();
        HashOperations hashOperations = redisTemplate.opsForHash();
        ListOperations listOperations = redisTemplate.opsForList();
        SetOperations setOperations = redisTemplate.opsForSet();
        ZSetOperations zSetOperations = redisTemplate.opsForZSet();
    }

    /**
     * 操作字符串類型的數據
     */
    @Test
    public void testString(){
        // set get setex setnx
        redisTemplate.opsForValue().set("city","Chiayi");
        String city = (String) redisTemplate.opsForValue().get("city");
        System.out.println(city);
        redisTemplate.opsForValue().set("code","1234",3, TimeUnit.MINUTES);
        redisTemplate.opsForValue().setIfAbsent("lock","1");
        redisTemplate.opsForValue().setIfAbsent("lock","2");
    }

    /**
     * 操作Hash類型的數據
     */
    @Test
    public void testHash(){
        // hset hget hdel hkeys hvals
        HashOperations hashOperations = redisTemplate.opsForHash();

        hashOperations.put("user:1","name","Matt Wei");
        hashOperations.put("user:1","age","30");

        String name = (String) hashOperations.get("user:1", "name");
        System.out.println(name);

        Set keys = hashOperations.keys("user:1");
        System.out.println(keys);

        List values = hashOperations.values("user:1");
        System.out.println(values);

        hashOperations.delete("user:1", "age");
    }
}
