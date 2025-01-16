package com.github.mattwei.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * Description:
 *  封裝查詢員工後返回的數據
 * @Author Matt Wei
 * @Create 2025/1/14 上午 10:39
 */

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class EmployeeVO implements Serializable {

    private Long id;

    private String name;

    private String account;

    private String phone;

    private String sex;

    private LocalDateTime updateTime;
}
