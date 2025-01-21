package com.github.mattwei.mapper;

import com.github.mattwei.entity.OrderDetail;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/21 下午 09:29
 */
@Mapper
public interface OrderDetailMapper {
    /**
     * 批量插入訂單明細數據
     * @param orderDetailList
     */
    void insertBatch(List<OrderDetail> orderDetailList);
}
