package com.github.mattwei.dto;

import lombok.Data;

import java.io.Serializable;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/23 下午 02:34
 */
@Data
public class OrdersCancelDTO implements Serializable {

    private Long id;

    private String cancelReason;
}
