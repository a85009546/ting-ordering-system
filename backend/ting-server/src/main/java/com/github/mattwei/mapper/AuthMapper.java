package com.github.mattwei.mapper;

import com.github.mattwei.annotation.AutoFill;
import com.github.mattwei.entity.MenuItem;
import com.github.mattwei.entity.User;
import com.github.mattwei.enumeration.OperationType;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/13 上午 10:49
 */

@Mapper
public interface AuthMapper {

    /**
     * 根據用戶名查詢用戶
     * @param account
     * @return
     */
    @Select("select * from user where account = #{account}")
    User findByAccount(String account);


    /**
     * 註冊用戶，插入用戶數據
     * @param user
     */
    @Insert("insert into user(account, password, name, sex, phone, avatar, balance, role, " +
            "create_time, update_time) values(#{account}, #{password}, #{name}, #{sex}, #{phone}, " +
            "#{avatar}, #{balance}, #{role}, #{createTime}, #{updateTime})")
    @AutoFill(value = OperationType.INSERT)
    void insert(User user);

    /**
     * 根據角色查詢菜單項目
     * @param role
     * @return
     */
    @Select("select * from menu_item where level <= #{role}")
    List<MenuItem> getMenuItemsByRole(Integer role);

    /**
     * 更新用戶數據
     * @param user
     */
    void update(User user);
}
