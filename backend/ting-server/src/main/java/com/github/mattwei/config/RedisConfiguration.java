package com.github.mattwei.config;

import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.StringRedisSerializer;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/15 下午 01:41
 */

@Configuration
@Slf4j
public class RedisConfiguration {

    @Bean
    public RedisTemplate redisTemplate(RedisConnectionFactory redisConnectionFactory) {
        log.info("開始創建 RedisTemplate 模板物件...");
        RedisTemplate redisTemplate = new RedisTemplate();
        // 設置 redis 的連接工廠物件
        redisTemplate.setConnectionFactory(redisConnectionFactory);
        // 設置 redis key 的序列化器
        redisTemplate.setKeySerializer(new StringRedisSerializer());
        return redisTemplate;

    }
}
