package com.github.mattwei.dto;

import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import java.io.Serializable;

/**
 * Description:
 *  用來封裝註冊請求的參數
 * @Author Matt Wei
 * @Create 2025/1/13 上午 10:29
 */

@Data
public class RegisterRequestDTO implements Serializable {

    @Pattern(regexp = "^\\S{1,16}$")
    private String name;

    @Pattern(regexp = "^\\S{4,16}$")
    private String account;

    @Pattern(regexp = "^\\S{4,16}$")
    private String password;

    private String phone;

    private String sex;
}
