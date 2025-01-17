package com.github.mattwei.dto;

import lombok.Data;

import java.io.Serializable;

/**
 * Description:
 *  封裝分頁請求的數據
 * @Author Matt Wei
 * @Create 2025/1/14 上午 09:48
 */

@Data
public class UserPageQueryDTO implements Serializable {


    private String account;

    private String name;

    private String phone;

    private String sex;

    private Integer page;

    private Integer pageSize;
}
