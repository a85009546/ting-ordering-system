package com.github.mattwei.mapper;

import com.github.mattwei.entity.Orders;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.time.LocalDateTime;
import java.util.List;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/21 下午 09:28
 */
@Mapper
public interface OrderMapper {

    /**
     * 插入訂單數據
     * @param orders
     */
    void insert(Orders orders);

    /**
     * 根據訂單狀態和下單時間查詢訂單
     * @param status
     * @param orderTime
     * @return
     */
    @Select("select * from orders where status = #{status} and order_time < #{orderTime}")
    List<Orders> getByStatusAndOrderTimeLT(Integer status, LocalDateTime orderTime);

    /**
     * 動態更新訂單
     * @param orders
     */
    void update(Orders orders);
}
