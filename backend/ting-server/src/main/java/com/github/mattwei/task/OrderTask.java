package com.github.mattwei.task;

import com.github.mattwei.entity.Orders;
import com.github.mattwei.mapper.OrderMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.util.List;

/**
 * Description:
 *  定時處理訂單
 * @Author Matt Wei
 * @Create 2025/1/22 下午 07:31
 */
@Component
@Slf4j
public class OrderTask {

    @Autowired
    private OrderMapper orderMapper;
    /**
     * 處理超時訂單
     */
    @Scheduled(cron = "0 * * * * ? ") // 每分鐘觸發一次
    public void processTimeoutOrder(){
        log.info("定時處理超時訂單: {}", LocalDateTime.now());

        // select * from orders where status = 1 and order_time < (當前時間 - 15分鐘)
        List<Orders> ordersList = orderMapper.getByStatusAndOrderTimeLT(Orders.PENDING_PAYMENT, LocalDateTime.now().minusMinutes(1500));

        if(ordersList != null && ordersList.size() > 0){
            for (Orders orders : ordersList) {
                orders.setStatus(Orders.CANCELLED);
                orders.setCancelReason("訂單超時，自訂取消");
                orders.setCancelTime(LocalDateTime.now());
                orderMapper.update(orders);
            }
        }
    }

    /**
     * 處裡一直處於派送中的訂單
     */
    @Scheduled(cron = "0 0 1 * * ? ") // 每天凌晨一點觸發
    public void processDeliveryOrder(){
        log.info("定時處理處於派送中的訂單: {}", LocalDateTime.now());

        // 處理前一天的訂單 : select * from orders where status = 1 and order_time < (當前時間 - 60分鐘)
        List<Orders> ordersList = orderMapper.getByStatusAndOrderTimeLT(Orders.DELIVERY_IN_PROGRESS, LocalDateTime.now().minusMinutes(60));

        if(ordersList != null && ordersList.size() > 0){
            for (Orders orders : ordersList) {
                orders.setStatus(Orders.COMPLETED);
                orders.setCancelTime(LocalDateTime.now());
                orderMapper.update(orders);
            }
        }
    }
}
