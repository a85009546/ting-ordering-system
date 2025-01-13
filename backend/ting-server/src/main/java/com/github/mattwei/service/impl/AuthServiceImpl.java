package com.github.mattwei.service.impl;

import com.github.mattwei.entity.User;
import com.github.mattwei.mapper.AuthMapper;
import com.github.mattwei.result.Result;
import com.github.mattwei.service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.DigestUtils;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/13 上午 10:34
 */

@Service
public class AuthServiceImpl implements AuthService {

    @Autowired
    private AuthMapper authMapper;

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
     * 註冊
     * @param user
     */
    @Override
    public void register(User user) {
        String password = user.getPassword();

        // 密碼加密
        user.setPassword(DigestUtils.md5DigestAsHex(password.getBytes()));
        authMapper.insert(user);
    }
}
