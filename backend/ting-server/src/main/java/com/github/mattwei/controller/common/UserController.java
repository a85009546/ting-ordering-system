package com.github.mattwei.controller.common;

import com.github.mattwei.dto.PasswordDTO;
import com.github.mattwei.entity.User;
import com.github.mattwei.result.Result;
import com.github.mattwei.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/21 下午 10:50
 */

@RestController
@RequestMapping("/user")
@Slf4j
public class UserController {

    @Autowired
    private UserService userService;


    /**
     * 根據id查詢用戶
     * @param id
     * @return
     */
    @GetMapping("/{id}")
    public Result<User> getById(@PathVariable Long id) {
        log.info("根據id查詢用戶: {}", id);
        User user = userService.getById(id);
        return Result.success(user);
    }


    /**
     * 更新用戶資訊
     * @param user
     * @return
     */
    @PutMapping
    public Result update(@RequestBody User user) {
        log.info("更新用戶: {}", user);
        userService.update(user);
        return Result.success();
    }

    /**
     * 修改用戶密碼
     * @param passwordDTO
     * @return
     */
    @PutMapping("/changePassword")
    public Result changePassword(@RequestBody PasswordDTO passwordDTO) {
        userService.changePassword(passwordDTO);
        return Result.success();
    }

    /**
     * 用戶登出
     * @return
     */
    @PostMapping("/logout")
    public Result logout() {
        userService.logout();
        return Result.success();
    }
}
