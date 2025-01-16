package com.github.mattwei.vo;

import com.github.mattwei.entity.MenuItem;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * Description:
 *  封裝用戶登入返回的數據
 * @Author Matt Wei
 * @Create 2025/1/13 下午 02:30
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserLoginVO implements Serializable {

    private Long id;

    private Integer role;

    private String name;

    private String account;

    private String token;

    private List<MenuItem> menuItems = new ArrayList<>();

}
