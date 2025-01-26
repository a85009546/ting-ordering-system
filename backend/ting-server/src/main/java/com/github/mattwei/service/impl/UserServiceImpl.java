package com.github.mattwei.service.impl;

import com.github.mattwei.constant.MessageConstant;
import com.github.mattwei.context.BaseContext;
import com.github.mattwei.dto.PasswordDTO;
import com.github.mattwei.entity.User;
import com.github.mattwei.exception.PasswordErrorException;
import com.github.mattwei.mapper.AuthMapper;
import com.github.mattwei.mapper.UserMapper;
import com.github.mattwei.result.Result;
import com.github.mattwei.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.DigestUtils;

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
    @Autowired
    private AuthMapper authMapper;

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

    /**
     * 修改用戶密碼
     * @param passwordDTO
     */
    @Override
    public void changePassword(PasswordDTO passwordDTO) {
        // 1. 校驗原密碼是否正確
        Long userId = BaseContext.getCurrentId();
        User user = userMapper.getById(userId);
        String md5Password = DigestUtils.md5DigestAsHex(passwordDTO.getPassword().getBytes());
        if(!user.getPassword().equals(md5Password)){
            throw new PasswordErrorException(MessageConstant.ORIGINAL_PASSWORD_ERROR);
        }
        // 2. 原密碼校驗通過後，修改密碼
        user.setPassword(DigestUtils.md5DigestAsHex(passwordDTO.getNewPassword().getBytes()));
        userMapper.update(user);
    }
}

