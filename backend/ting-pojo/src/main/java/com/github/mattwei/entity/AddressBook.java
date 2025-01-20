package com.github.mattwei.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * Description:
 *  地址簿
 * @Author Matt Wei
 * @Create 2025/1/20 下午 09:08
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AddressBook implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long id;

    private Long userId;

    // 聯繫人
    private String consignee;

    private String phone;

    private String sex;

    // 市级编號
    private String cityCode;

    // 市级名稱
    private String cityName;

    // 區級编號
    private String districtCode;

    // 區级名稱
    private String districtName;

    // 詳細地址
    private String detail;

    // 標籤
    private String label;

    // 是否默認 0否 1是
    private Integer isDefault;
}
