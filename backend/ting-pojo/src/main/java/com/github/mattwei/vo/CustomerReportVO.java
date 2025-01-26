package com.github.mattwei.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/26 上午 10:08
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CustomerReportVO implements Serializable {

    private String dateList;

    // 新增顧客數列表
    private String newCustomerList;

    // 總顧客數列表
    private String totalCustomerList;

}
