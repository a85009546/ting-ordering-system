package com.github.mattwei.dto;

import lombok.Data;

import java.io.Serializable;

/**
 * Description:
 *  封裝用戶登入時傳遞的數據
 * @Author Matt Wei
 * @Create 2025/1/13 下午 02:45
 */
@Data
public class UserLoginDTO implements Serializable {

    private String account;

    private String password;
}
