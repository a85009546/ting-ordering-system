package com.github.mattwei.service.impl;

import com.github.mattwei.constant.JwtClaimsConstant;
import com.github.mattwei.dto.UserLoginDTO;
import com.github.mattwei.entity.MenuItem;
import com.github.mattwei.entity.User;
import com.github.mattwei.mapper.AuthMapper;
import com.github.mattwei.mapper.UserMapper;
import com.github.mattwei.properties.JwtProperties;
import com.github.mattwei.result.Result;
import com.github.mattwei.service.AuthService;
import com.github.mattwei.utils.JwtUtil;
import com.github.mattwei.vo.UserLoginVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.util.DigestUtils;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/13 上午 10:34
 */

@Service
@Slf4j
public class AuthServiceImpl implements AuthService {

    @Autowired
    private AuthMapper authMapper;
    @Autowired
    private JwtProperties jwtProperties;
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private RedisTemplate redisTemplate;
    /**
     * 根據用戶名查詢用戶信息
     * @param account
     * @return
     */
    @Override
    public User findByAccount(String account) {
        return authMapper.findByAccount(account);
    }

    /**
     * 顧客註冊
     * @param user
     */
    @Override
    public void register(User user) {
        String password = user.getPassword();

        // 密碼加密
        user.setPassword(DigestUtils.md5DigestAsHex(password.getBytes()));
        authMapper.insert(user);
    }

    /**
     * 登入
     * @param user
     * @return
     */
    @Override
    public UserLoginVO login(User user) {
        // 更新用戶最後登入時間
        user.setUpdateTime(LocalDateTime.now());
        userMapper.update(user);
        // 登入成功，獲取令牌以及路徑資源
        Map<String, Object> claims = new HashMap<>();
        claims.put(JwtClaimsConstant.USER_ID, user.getId());
        String token = JwtUtil.createJWT(
                jwtProperties.getSecretKey(),
                jwtProperties.getTtl(),
                claims
        );
        // 構建 redis 緩存鍵，規則 toekn:user:userId
        String key = "token:user:" + user.getId();
        // 根據 userId 存儲 token
        redisTemplate.opsForValue().set(key, token, 3, TimeUnit.HOURS); // 過期時間設置為三小時，與JWT一致

        // 根據角色獲取對應資源，1為customer，2為employee，3為admin
        List<MenuItem> menuItems = authMapper.getMenuItemsByRole(user.getRole());

        // 封裝返回數據
        return UserLoginVO.builder()
                .id(user.getId())
                .role(user.getRole())
                .name(user.getName())
                .account(user.getAccount())
                .balance(user.getBalance())
                .avatar(user.getAvatar())
                .token(token)
                .menuItems(menuItems)
                .build();
    }
}
