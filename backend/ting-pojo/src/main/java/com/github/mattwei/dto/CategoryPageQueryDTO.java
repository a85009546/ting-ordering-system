package com.github.mattwei.dto;

import lombok.Data;

import java.io.Serializable;

/**
 * Description:
 *  封裝分類的查詢條件
 * @Author Matt Wei
 * @Create 2025/1/14 下午 02:51
 */
@Data
public class CategoryPageQueryDTO implements Serializable {

    private String name;

    private Integer status;

    private Integer page;

    private Integer pageSize;
}
