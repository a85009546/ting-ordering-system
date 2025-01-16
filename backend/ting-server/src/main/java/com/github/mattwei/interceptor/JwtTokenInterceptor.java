package com.github.mattwei.interceptor;

import com.github.mattwei.constant.JwtClaimsConstant;
import com.github.mattwei.context.BaseContext;
import com.github.mattwei.properties.JwtProperties;
import com.github.mattwei.utils.JwtUtil;
import io.jsonwebtoken.Claims;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Description:
 *  令牌攔截器
 * @Author Matt Wei
 * @Create 2025/1/13 下午 09:37
 */

@Component
@Slf4j
public class JwtTokenInterceptor implements HandlerInterceptor {

    @Autowired
    private JwtProperties jwtProperties;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // 判斷當前攔截到的是Controller的方法還是其他資源
        if(!(handler instanceof HandlerMethod)){
            // 當前攔截到的不是動態方法，直接放行
            return true;
        }

        // 從請求中獲取令牌
        String token = request.getHeader(jwtProperties.getTokenName());

        // 進行驗證
        try {
            log.info("jwt校驗: {}", token);
            Claims claims = JwtUtil.parseJWT(jwtProperties.getSecretKey(), token);
            Long userId = Long.valueOf(claims.get(JwtClaimsConstant.USER_ID).toString());
            log.info("當前用戶id: {}", userId);
            // 將當前用戶id存入ThreadLocal
            BaseContext.setCurrentId(userId);
            return true;
        } catch (Exception e) {
            // 校驗失敗，響應 401 狀態碼
            response.setStatus(401);
            return false;
        }
    }
}
