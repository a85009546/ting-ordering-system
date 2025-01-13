package com.github.mattwei.service;

import com.github.mattwei.dto.EmployeeDTO;

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
}
