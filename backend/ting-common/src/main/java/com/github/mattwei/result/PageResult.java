package com.github.mattwei.result;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.List;

/**
 * Description:
 *  封裝分頁查詢的結果
 * @Author Matt Wei
 * @Create 2025/1/14 上午 09:53
 */

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PageResult implements Serializable {

    private Long total;

    private List records;
}
