package com.github.mattwei.controller.admin;

import com.github.mattwei.dto.EmployeeDTO;
import com.github.mattwei.result.Result;
import com.github.mattwei.service.EmployeeService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/13 下午 09:02
 */

@RestController
@RequestMapping("/admin/employee")
@Slf4j
public class EmployeeController {

    @Autowired
    private EmployeeService employeeService;

    /**
     * 新增員工
     * @param employeeDTO
     * @return
     */
    @PostMapping
    public Result save(@RequestBody EmployeeDTO employeeDTO){
        log.info("新增員工: {}", employeeDTO);
        employeeService.save(employeeDTO);
        return Result.success();
    }
}
