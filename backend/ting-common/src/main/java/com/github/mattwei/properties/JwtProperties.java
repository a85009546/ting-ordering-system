package com.github.mattwei.properties;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/13 下午 06:59
 */

@Component
@ConfigurationProperties(prefix = "ting.jwt")
@Data
public class JwtProperties {


    private String secretKey;
    private long ttl;
    private String tokenName;
}
