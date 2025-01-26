package com.github.mattwei.dto;

import lombok.Data;

import java.io.Serializable;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/26 下午 06:26
 */
@Data
public class PasswordDTO implements Serializable {

    private String password;

    private String newPassword;
}
