package com.github.mattwei.mapper;

import com.github.mattwei.dto.OrdersPageQueryDTO;
import com.github.mattwei.entity.Orders;
import com.github.pagehelper.Page;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

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


    /**
     * 管理端 - 訂單條件分頁查詢
     * @param ordersPageQueryDTO
     * @return
     */
    Page<Orders> pageQuery(OrdersPageQueryDTO ordersPageQueryDTO);

    /**
     * 根據訂單狀態統計訂單數量
     * @param toBeConfirmed
     * @return
     */
    @Select("select count(id) from orders where status = #{status}")
    Integer countByStatus(Integer toBeConfirmed);

    /**
     * 根據訂單id查詢訂單
     * @param id
     * @return
     */
    @Select("select * from orders where id = #{id}")
    Orders getById(Long id);

    /**
     * 根據動態條件統計營業額數據
     * @param map
     * @return
     */
    Double sumByMap(Map map);
}
