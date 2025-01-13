package com.github.mattwei.mapper;

import com.github.mattwei.entity.User;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/13 下午 09:07
 */

@Mapper
public interface EmployeeMapper {

    /**
     * 插入員工數據
     * @param user
     */
    @Insert("insert into user (role, name, account, password, balance, phone, sex, " +
            "avatar, create_time, update_time) values (#{role}, #{name}, #{account}, " +
            "#{password}, #{balance}, #{phone}, #{sex}, #{avatar}, #{createTime}, #{updateTime})")
    void insert(User user);
}
