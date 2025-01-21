package com.github.mattwei.service.impl;

import com.github.mattwei.constant.MessageConstant;
import com.github.mattwei.context.BaseContext;
import com.github.mattwei.dto.OrderSumbitDTO;
import com.github.mattwei.entity.AddressBook;
import com.github.mattwei.entity.OrderDetail;
import com.github.mattwei.entity.Orders;
import com.github.mattwei.entity.ShoppingCart;
import com.github.mattwei.exception.AddressBookBusinessException;
import com.github.mattwei.exception.ShoppingCartBusinessException;
import com.github.mattwei.mapper.AddressBookMapper;
import com.github.mattwei.mapper.OrderDetailMapper;
import com.github.mattwei.mapper.OrderMapper;
import com.github.mattwei.mapper.ShoppingCartMapper;
import com.github.mattwei.service.OrderService;
import com.github.mattwei.vo.OrderSubmitVO;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/21 下午 09:26
 */
@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderMapper orderMapper;
    @Autowired
    private OrderDetailMapper orderDetailMapper;
    @Autowired
    private AddressBookMapper addressBookMapper;
    @Autowired
    private ShoppingCartMapper shoppingCartMapper;

    /**
     * 顧客下單
     * @param orderSumbitDTO
     * @return
     */
    @Override
    @Transactional
    public OrderSubmitVO submitOrder(OrderSumbitDTO orderSumbitDTO) {
        // 1. 處理各種業務異常 (地址簿為空、購物車為空)
        // 1.1 查詢當前用戶的購物車是否為空
        ShoppingCart shoppingCart = new ShoppingCart();
        Long userId = BaseContext.getCurrentId();
        shoppingCart.setUserId(userId);
        List<ShoppingCart> shoppingCartList = shoppingCartMapper.list(shoppingCart);
        if(shoppingCartList == null || shoppingCartList.size() == 0){
            throw new ShoppingCartBusinessException(MessageConstant.SHOPPING_CART_IS_NULL);
        }
        // 1.2 購物車不為空，查詢餘額是否足夠


        AddressBook addressBook = addressBookMapper.getById(orderSumbitDTO.getAddressBookId());
        if(addressBook == null){
            throw new AddressBookBusinessException(MessageConstant.ADDRESS_BOOK_IS_NULL);
        }


        // 2. 需要向訂單表插入 1 條數據
        Orders orders = new Orders();
        BeanUtils.copyProperties(orderSumbitDTO, orders);
        orders.setNumber(String.valueOf(System.currentTimeMillis())); // 使用時間戳當訂單號
        orders.setStatus(Orders.TO_BE_CONFIRMED); // 待接單
        orders.setUserId(userId);
        orders.setOrderTime(LocalDateTime.now());
        orders.setPayStatus(Orders.PAYED); // 已支付
        orders.setPhone(addressBook.getPhone());
        orders.setPhone(addressBook.getDetail());
        orders.setConsignee(addressBook.getConsignee());

        orderMapper.insert(orders);
        // 3. 需要向訂單明細表插入 n 條數據
        List<OrderDetail> orderDetailList = shoppingCartList.stream()
                .map(cart -> {
                    OrderDetail orderDetail = new OrderDetail();
                    BeanUtils.copyProperties(cart, orderDetail);
                    orderDetail.setOrderId(orders.getId()); // 設置當前訂單id
                    return orderDetail;
                })
                .collect(Collectors.toList());
        orderDetailMapper.insertBatch(orderDetailList);
        // 4. 清空當前顧客的購物車
        shoppingCartMapper.deleteByUserId(userId);
        // 5. 返回結果
        OrderSubmitVO orderSubmitVO = OrderSubmitVO.builder()
                .id(orders.getId())
                .orderNumber(orders.getNumber())
                .orderAmount(orders.getAmount())
                .orderTime(orders.getOrderTime())
                .build();
        return orderSubmitVO;
    }
}
