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
 * @Create 2025/1/25 下午 07:33
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class TurnoverReportVO implements Serializable {

    // 日期列表，以逗號分隔，如: 2025-01-01,2025-01-02,2025-01-03
    private String dateList;

    // 營業額，以逗號分隔，如: 100,200,300
    private String turnoverList;
}
