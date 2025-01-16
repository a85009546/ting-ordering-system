package com.github.mattwei.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * Description:
 *  選單
 * @Author Matt Wei
 * @Create 2025/1/12 下午 10:55
 */

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MenuItem implements Serializable {

    private static final long serialVersionUID = 1L;

    private Integer id;

    // 選單名稱
    private String name;

    // 前端路徑
    private String path;

    // 選單等級 1:表示customer可調用，2:表示employee可調用，3:表示admin可調用
    private String level;
}
