package com.github.mattwei.controller.auth;

import com.github.mattwei.constant.MessageConstant;
import com.github.mattwei.dto.RegisterRequestDTO;
import com.github.mattwei.dto.UserLoginDTO;
import com.github.mattwei.entity.User;
import com.github.mattwei.exception.AccountAlreadyExistException;
import com.github.mattwei.exception.AccountNotFoundException;
import com.github.mattwei.exception.PasswordErrorException;
import com.github.mattwei.result.Result;
import com.github.mattwei.service.AuthService;
import com.github.mattwei.vo.UserLoginVO;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.DigestUtils;
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
     * 顧客註冊
     * @return
     */
    @PostMapping("/register")
    public Result register(@RequestBody @Validated RegisterRequestDTO registerRequestDTO) {
        User user = authService.findByAccount(registerRequestDTO.getAccount());
        // 判斷帳號是否存在
        if(user == null){
            // 這裡的 user 皆為 customer
            user = new User();
            BeanUtils.copyProperties(registerRequestDTO, user);
            user.setRole(1);
            user.setSex("0");
            user.setBalance(new BigDecimal("5000.00")); // 默認5000元
            authService.register(user);
            return Result.success();
        }else{
            throw new AccountAlreadyExistException(MessageConstant.ACCOUNT_ALREADY_EXIST);
        }
    }


    /**
     * 登入
     * @param userLoginDTO
     * @return
     */
    @PostMapping("/login")
    public Result<UserLoginVO> login(@RequestBody UserLoginDTO userLoginDTO){
        User user = authService.findByAccount(userLoginDTO.getAccount());
        // 判斷帳號是否存在
        if(user == null){
            throw new AccountNotFoundException(MessageConstant.ACCOUNT_NOT_FOUND);
        }else{
            // 密碼比對
            if(!user.getPassword().equals(DigestUtils.md5DigestAsHex(userLoginDTO.getPassword().getBytes()))){
                throw new PasswordErrorException(MessageConstant.PASSWORD_ERROR);
            }else{
                // 登入成功，獲取對應資源
                UserLoginVO userLoginVO = authService.login(user);

                System.out.println(userLoginVO);
                return Result.success(userLoginVO);
            }
        }
    }
}
