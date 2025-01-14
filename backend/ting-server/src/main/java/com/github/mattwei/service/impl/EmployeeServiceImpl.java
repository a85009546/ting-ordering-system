package com.github.mattwei.service.impl;

import com.github.mattwei.constant.MessageConstant;
import com.github.mattwei.constant.PasswordConstant;
import com.github.mattwei.context.BaseContext;
import com.github.mattwei.dto.EmployeeDTO;
import com.github.mattwei.dto.UserPageQueryDTO;
import com.github.mattwei.entity.User;
import com.github.mattwei.exception.AccountAlreadyExistException;
import com.github.mattwei.mapper.AuthMapper;
import com.github.mattwei.mapper.EmployeeMapper;
import com.github.mattwei.result.PageResult;
import com.github.mattwei.service.EmployeeService;
import com.github.mattwei.vo.EmployeeVO;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.DigestUtils;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/13 下午 09:05
 */

@Service
public class EmployeeServiceImpl implements EmployeeService {

    @Autowired
    private EmployeeMapper employeeMapper;
    @Autowired
    private AuthMapper authMapper;

    /**
     * 新增員工
     * @param employeeDTO
     */
    @Override
    public void save(EmployeeDTO employeeDTO) {
        // 查詢帳號是否存在
        User user = authMapper.findByAccount(employeeDTO.getAccount());
        if(user == null){
            // 新增員工
            user = new User();
            BeanUtils.copyProperties(employeeDTO, user);
            user.setRole(2);
            // 默認密碼 123456
            user.setPassword(DigestUtils.md5DigestAsHex(PasswordConstant.DEFAULT_PASSWORD.getBytes()));
            user.setCreateTime(LocalDateTime.now());
            employeeMapper.insert(user);
        }else{
            // 帳號已存在
            throw new AccountAlreadyExistException(MessageConstant.ACCOUNT_ALREADY_EXIST);
        }

    }

    /**
     * 員工分頁查詢
     * @param userPageQueryDTO
     * @return
     */
    @Override
    public PageResult pageQuery(UserPageQueryDTO userPageQueryDTO) {

        PageHelper.startPage(userPageQueryDTO.getPage(), userPageQueryDTO.getPageSize());
        Page<EmployeeVO> page = employeeMapper.pageQuery(userPageQueryDTO);

        Long total = page.getTotal();
        List<EmployeeVO> records = page.getResult();

        return new PageResult(total, records);
    }
}
