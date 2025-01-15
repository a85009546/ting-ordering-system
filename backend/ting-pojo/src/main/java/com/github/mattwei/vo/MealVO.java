package com.github.mattwei.vo;

import com.github.mattwei.entity.MealFlavor;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * Description:
 *  封裝餐點分頁查詢後返回的數據
 * @Author Matt Wei
 * @Create 2025/1/15 上午 09:46
 */

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MealVO implements Serializable {

    private Long id;

    private String name;

    private Long categoryId;

    private BigDecimal price;

    private String image;

    private String description;

    private Integer status;

    private LocalDateTime updateTime;

    private String categoryName;

    private List<MealFlavor> flavors = new ArrayList<>();
}
