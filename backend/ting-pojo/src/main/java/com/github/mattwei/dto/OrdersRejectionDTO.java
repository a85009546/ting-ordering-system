package com.github.mattwei.dto;

import lombok.Data;

import java.io.Serializable;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/23 下午 02:10
 */
@Data
public class OrdersRejectionDTO implements Serializable {

    private Long id;

    private String rejectionReason;
}
