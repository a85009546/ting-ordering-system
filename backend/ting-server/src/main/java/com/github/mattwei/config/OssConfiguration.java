package com.github.mattwei.config;

import com.github.mattwei.properties.AliOssProperties;
import com.github.mattwei.utils.AliOssUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * Description:
 *  配置類，用來創建AliOssUtil物件
 * @Author Matt Wei
 * @Create 2025/1/14 下午 09:53
 */

@Configuration
@Slf4j
public class OssConfiguration {

    @Bean
    @ConditionalOnMissingBean
    // 參數注入 AliOssProperties
    public AliOssUtil aliOssUtil(AliOssProperties aliOssProperties){
        log.info("開始創建阿里云文件上傳工具類物件: {}", aliOssProperties);
        return new AliOssUtil(aliOssProperties.getEndpoint(),
                aliOssProperties.getAccessKeyId(),
                aliOssProperties.getAccessKeySecret(),
                aliOssProperties.getBucketName());
    }
}
