package com.github.mattwei.controller.auth;

import com.github.mattwei.dto.RegisterRequestDTO;
import com.github.mattwei.entity.User;
import com.github.mattwei.result.Result;
import com.github.mattwei.service.AuthService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.constraints.Pattern;
import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * Description:
 *  登入與註冊的控制器
 * @Author Matt Wei
 * @Create 2025/1/13 上午 10:25
 */

@RestController
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private AuthService authService;

    /**
     * 註冊
     * @return
     */
    @PostMapping("/register")
    public Result register(@RequestBody @Validated RegisterRequestDTO registerRequestDTO) {
        User user = new User();
        BeanUtils.copyProperties(registerRequestDTO, user);
        // 皆為顧客註冊
        user.setRole(1);
        user.setBalance(new BigDecimal("5000.00")); // 默認5000元
        user.setCreateTime(LocalDateTime.now());
        user.setUpdateTime(LocalDateTime.now());
        // 查詢帳號是否存在
        User u = authService.findByAccount(user.getAccount());
        if(u == null){
            authService.register(user);
            return Result.success();
        }else{
            return Result.error("帳號已存在");
        }

    }
}
