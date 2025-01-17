package com.github.mattwei.service;

import com.github.mattwei.dto.EmployeeDTO;
import com.github.mattwei.dto.UserPageQueryDTO;
import com.github.mattwei.result.PageResult;
import com.github.mattwei.vo.EmployeeVO;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/13 下午 09:05
 */
public interface EmployeeService {

    /**
     * 新增員工
     * @param employeeDTO
     */
    void save(EmployeeDTO employeeDTO);

    /**
     * 分頁查詢
     * @param userPageQueryDTO
     * @return
     */
    PageResult pageQuery(UserPageQueryDTO userPageQueryDTO);

    /**
     * 根據id查詢員工
     * @param id
     * @return
     */
    EmployeeVO getById(Long id);

    /**
     * 編輯員工
     * @param employeeDTO
     */
    void update(EmployeeDTO employeeDTO);

    /**
     * 根據id刪除員工
     * @param id
     */
    void deleteById(Long id);
}
