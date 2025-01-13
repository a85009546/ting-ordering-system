package com.github.mattwei.config;

import com.github.mattwei.interceptor.JwtTokenInterceptor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurationSupport;


/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/13 下午 08:21
 */

@Configuration
@Slf4j
public class WebMvcConfiguration extends WebMvcConfigurationSupport {

    @Autowired
    private JwtTokenInterceptor jwtTokenInterceptor;

    /**
     * 註冊自定義攔截器
     * @param registry
     */
    @Override
    protected void addInterceptors(InterceptorRegistry registry) {
        log.info("開始註冊自定義攔截器...");
        registry.addInterceptor(jwtTokenInterceptor)
                                // 攔截所有請求
                                .addPathPatterns("/**")
                                // 排除 /auth 路徑下的請求
                                .excludePathPatterns("/auth/**");
    }
}
