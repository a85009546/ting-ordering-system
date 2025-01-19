package com.github.mattwei.config;

import com.github.mattwei.interceptor.JwtTokenInterceptor;
import com.github.mattwei.json.JacksonObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurationSupport;

import java.util.List;


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


    /**
     * 擴展Spring MVC的訊息轉換器
     * @param converters the list of configured converters to extend
     */
    @Override
    protected void extendMessageConverters(List<HttpMessageConverter<?>> converters) {
        log.info("擴展訊息轉換器...");
        // 創建一個訊息轉換器對象
        MappingJackson2HttpMessageConverter converter = new MappingJackson2HttpMessageConverter();
        // 需要為訊息轉換器設置一個對象轉換器，訊息轉換器可以將Java物件序列化為json數據
        converter.setObjectMapper(new JacksonObjectMapper());

        // 將自己的訊息轉換器加入容器中
        converters.add(0, converter);
    }
}
