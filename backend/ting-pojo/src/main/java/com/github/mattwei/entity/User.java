package com.github.mattwei.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * Description:
 *  用戶
 * @Author Matt Wei
 * @Create 2025/1/12 下午 10:40
 */

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class User implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long id;

    // 角色 - 1:customer，2:employee，3:admin
    private Integer role;

    private String name;

    private String account;

    private String password;

    // 餘額，只有customer才有此項
    private BigDecimal balance;

    private String phone;

    private String sex;

    private String avatar;

    // 註冊時間
    private LocalDateTime createTime;
    // 最後登入時間
    private LocalDateTime updateTime;
}
