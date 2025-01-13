package com.github.mattwei.dto;

import lombok.Data;

import java.io.Serializable;

/**
 * Description:
 *  封裝新增員工時傳遞的數據
 * @Author Matt Wei
 * @Create 2025/1/13 下午 09:00
 */
@Data
public class EmployeeDTO implements Serializable {

    private String account;

    private String name;

    private String phone;

    private String sex;
}
