package com.github.mattwei.controller.admin;

import com.github.mattwei.dto.EmployeeDTO;
import com.github.mattwei.dto.UserPageQueryDTO;
import com.github.mattwei.result.PageResult;
import com.github.mattwei.result.Result;
import com.github.mattwei.service.EmployeeService;
import com.github.mattwei.vo.EmployeeVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

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

    /**
     * 員工的條件分頁查詢
     * @param userPageQueryDTO
     * @return
     */
    @GetMapping("/page")
    public Result<PageResult> page(UserPageQueryDTO userPageQueryDTO){
        log.info("員工分頁查詢，參數為: {}", userPageQueryDTO);
        PageResult pageResult = employeeService.pageQuery(userPageQueryDTO);
        return Result.success(pageResult);
    }

    /**
     * 根據id查詢員工
     * @param id
     * @return
     */
    @GetMapping("/{id}")
    public Result<EmployeeVO> getById(@PathVariable Long id){
        log.info("根據id查詢員工: {}", id);
        EmployeeVO employeeVO = employeeService.getById(id);
        return Result.success(employeeVO);
    }

    /**
     * 編輯員工
     * @param employeeDTO
     * @return
     */
    @PutMapping
    public Result update(@RequestBody EmployeeDTO employeeDTO){
        log.info("編輯員工數據: {}", employeeDTO);
        employeeService.update(employeeDTO);
        return Result.success();
    }

    /**
     * 刪除員工
     * @param id
     * @return
     */
    @DeleteMapping
    public Result delete(Long id){
        log.info("刪除員工: {}", id);
        employeeService.deleteById(id);
        return Result.success();
    }


}
