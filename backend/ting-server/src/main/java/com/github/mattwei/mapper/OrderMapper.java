package com.github.mattwei.mapper;

import com.github.mattwei.entity.Orders;
import org.apache.ibatis.annotations.Mapper;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/21 下午 09:28
 */
@Mapper
public interface OrderMapper {

    /**
     * 插入訂單數拒
     * @param orders
     */
    void insert(Orders orders);
}
