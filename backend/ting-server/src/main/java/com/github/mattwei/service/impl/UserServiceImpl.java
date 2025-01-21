package com.github.mattwei.service.impl;

import com.github.mattwei.entity.User;
import com.github.mattwei.mapper.UserMapper;
import com.github.mattwei.result.Result;
import com.github.mattwei.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/21 下午 11:00
 */
@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    /**
     * 根據id查詢用戶
     * @param id
     * @return
     */
    @Override
    public User getById(Long id) {
        return userMapper.getById(id);
    }

    /**
     * 根據id更新用戶資訊
     * @param user
     */
    @Override
    public void update(User user) {
        userMapper.update(user);
    }
}

