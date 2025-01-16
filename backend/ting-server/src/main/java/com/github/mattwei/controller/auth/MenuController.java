package com.github.mattwei.controller.auth;

import com.github.mattwei.entity.MenuItem;
import com.github.mattwei.mapper.AuthMapper;
import com.github.mattwei.result.Result;
import com.github.mattwei.service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/16 下午 08:35
 */

@RestController
@RequestMapping(("/menu"))
public class MenuController {

    @Autowired
    private AuthMapper authMapper;


    @GetMapping
    public Result<List<MenuItem>> getMenu(@RequestParam Integer role) {
        List<MenuItem> menuList = authMapper.getMenuItemsByRole(role);
        return Result.success(menuList);
    }
}
