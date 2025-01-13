package com.github.mattwei.dto;

import lombok.Data;

import java.io.Serializable;

/**
 * Description:
 *  用來封裝註冊請求的參數
 * @Author Matt Wei
 * @Create 2025/1/13 上午 10:29
 */

@Data
public class RegisterRequestDTO implements Serializable {

    private String name;

    private String account;

    private String password;

    private String phone;

    private String sex;
}
