package com.github.mattwei.mapper;

import com.github.mattwei.dto.UserPageQueryDTO;
import com.github.mattwei.entity.User;
import com.github.mattwei.vo.EmployeeVO;
import com.github.pagehelper.Page;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

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

    /**
     * 員工分頁查詢
     * @param userPageQueryDTO
     * @return
     */
    Page<EmployeeVO> pageQuery(UserPageQueryDTO userPageQueryDTO);

    /**
     * 根據id查詢員工
     * @param id
     * @return
     */
    @Select("select * from user where role = 2 and id = #{id}")
    EmployeeVO getById(Long id);
}
