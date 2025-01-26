package com.github.mattwei.mapper;

import com.github.mattwei.entity.User;
import com.github.mattwei.result.Result;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.Map;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/21 下午 11:03
 */
@Mapper
public interface UserMapper {

    /**
     * 根據id查詢用戶
     * @param id
     * @return
     */
    @Select("select * from user where id = #{id}")
    User getById(Long id);

    /**
     * 更新用戶
     * @param user
     */
    void update(User user);

    /**
     * 根據動態條件統計顧客數量
     * @param map
     * @return
     */
    Integer countByMap(Map map);
}
