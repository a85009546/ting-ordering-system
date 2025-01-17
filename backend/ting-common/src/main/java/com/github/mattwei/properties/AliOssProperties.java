package com.github.mattwei.properties;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/14 下午 09:43
 */

@Component
@ConfigurationProperties(prefix = "ting.alioss")
@Data
public class AliOssProperties {

    private String endpoint;
    private String accessKeyId;
    private String accessKeySecret;
    private String bucketName;
}
