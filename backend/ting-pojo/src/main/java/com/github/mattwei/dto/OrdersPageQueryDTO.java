package com.github.mattwei.dto;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/23 上午 10:24
 */

@Data
public class OrdersPageQueryDTO implements Serializable {

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime beginTime;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime endTime;

    // 訂單號
    private String number;

    private String phone;

    // 訂單狀態
    private Integer status;

    private Integer page;

    private Integer pageSize;

    private Long userId;
}
