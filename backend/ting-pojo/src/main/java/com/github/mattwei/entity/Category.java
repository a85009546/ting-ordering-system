package com.github.mattwei.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * Description:
 *  餐點分類
 * @Author Matt Wei
 * @Create 2025/1/12 下午 10:48
 */

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Category implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long id;

    private String name;

    // 分類狀態 0:禁用 1:啟用
    private Integer status;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;
}
