package com.github.mattwei.service;

import com.github.mattwei.entity.User;
import com.github.mattwei.result.Result;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/21 下午 11:00
 */
public interface UserService {
    /**
     * 根據id查詢用戶
     * @param id
     * @return
     */
    User getById(Long id);

    /**
     * 更新用戶資訊
     * @param user
     */
    void update(User user);
}
