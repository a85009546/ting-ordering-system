package com.github.mattwei.vo;

import lombok.Data;

import java.io.Serializable;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/23 上午 11:06
 */
@Data
public class OrderStatisticsVO implements Serializable {

    // 待派送數量
    private Integer confirmed;

    // 派送中數量
    private Integer deliveryInProgress;

    // 待接單數量
    private Integer toBeConfirmed;
}
