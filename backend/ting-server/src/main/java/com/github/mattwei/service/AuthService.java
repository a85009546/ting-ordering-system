package com.github.mattwei.service;

import com.github.mattwei.dto.UserLoginDTO;
import com.github.mattwei.entity.User;
import com.github.mattwei.vo.UserLoginVO;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/13 上午 10:33
 */
public interface AuthService {

    /**
     * 根據帳號查詢用戶
     * @param account
     * @return
     */
    User findByAccount(String account);

    /**
     * 註冊
     * @param user
     */
    void register(User user);

    /**
     * 登入
     * @param user
     * @return
     */
    UserLoginVO login(User user);
}
