package com.github.mattwei.service.impl;

import com.github.mattwei.constant.MessageConstant;
import com.github.mattwei.context.BaseContext;
import com.github.mattwei.dto.OrderSumbitDTO;
import com.github.mattwei.dto.OrdersPageQueryDTO;
import com.github.mattwei.entity.*;
import com.github.mattwei.exception.AddressBookBusinessException;
import com.github.mattwei.exception.ShoppingCartBusinessException;
import com.github.mattwei.exception.UserBusinessException;
import com.github.mattwei.mapper.*;
import com.github.mattwei.result.PageResult;
import com.github.mattwei.service.OrderService;
import com.github.mattwei.vo.OrderStatisticsVO;
import com.github.mattwei.vo.OrderSubmitVO;
import com.github.mattwei.vo.OrderVO;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
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
    @Autowired
    private UserMapper userMapper;

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
        User user = userMapper.getById(userId);
        if(user.getBalance().compareTo(orderSumbitDTO.getAmount()) < 0){
            throw new UserBusinessException(MessageConstant.USER_BALANCE_NOT_ENOUGH);
        }
        // 1.3 檢查是否有地址
        AddressBook addressBook = addressBookMapper.getById(orderSumbitDTO.getAddressBookId());
        if(addressBook == null){
            throw new AddressBookBusinessException(MessageConstant.ADDRESS_BOOK_IS_NULL);
        }

//        // 2. 根據訂單金額扣除用戶餘額
//        user.setBalance(user.getBalance().subtract(orderSumbitDTO.getAmount()));
//        userMapper.update(user);

        // 2. 需要向訂單表插入 1 條數據
        Orders orders = new Orders();
        BeanUtils.copyProperties(orderSumbitDTO, orders);
        orders.setNumber(String.valueOf(System.currentTimeMillis())); // 使用時間戳當訂單號
        orders.setStatus(Orders.PENDING_PAYMENT); // 待支付
        orders.setUserId(userId);
        orders.setOrderTime(LocalDateTime.now());
        orders.setPayStatus(Orders.UN_PAID); // 未支付
        orders.setPhone(addressBook.getPhone());
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

    /**
     * 管理端 - 訂單條件分頁查詢
     * @param ordersPageQueryDTO
     * @return
     */
    @Override
    public PageResult conditionSearch(OrdersPageQueryDTO ordersPageQueryDTO) {
        PageHelper.startPage(ordersPageQueryDTO.getPage(), ordersPageQueryDTO.getPageSize());

        Page<Orders> page = orderMapper.pageQuery(ordersPageQueryDTO);

        return new PageResult(page.getTotal(), page.getResult());
    }

    /**
     * 管理端 - 各個狀態的訂單數量統計
     * @return
     */
    @Override
    public OrderStatisticsVO statistics() {
        // 根據狀態查詢訂單數量
        Integer toBeConfirmed = orderMapper.countByStatus(Orders.TO_BE_CONFIRMED);
        Integer confirmed = orderMapper.countByStatus(Orders.CONFIRMED);
        Integer deliveryInProgress = orderMapper.countByStatus(Orders.DELIVERY_IN_PROGRESS);

        // 封裝結果
        OrderStatisticsVO orderStatisticsVO = new OrderStatisticsVO();
        orderStatisticsVO.setToBeConfirmed(toBeConfirmed);
        orderStatisticsVO.setConfirmed(confirmed);
        orderStatisticsVO.setDeliveryInProgress(deliveryInProgress);
        return orderStatisticsVO;
    }

    /**
     * 管理端 - 查詢訂單詳情
     * @param id
     * @return
     */
    @Override
    public OrderVO details(Long id) {
        // 1. 根據訂單id查詢訂單
        Orders orders = orderMapper.getById(id);

        // 2. 根據訂單id查詢訂單明細
        List<OrderDetail> orderDetailList = orderDetailMapper.getByOrderId(id);

        // 3. 封裝結果
        OrderVO orderVO = new OrderVO();
        BeanUtils.copyProperties(orders, orderVO);
//        orderVO.setOrderMeals(orderDetailList.stream()
//                .map(orderDetail -> orderDetail.getName() + "*" + orderDetail.getNumber())
//                .collect(Collectors.joining(",")));
        orderVO.setOrderDetailList(orderDetailList);

        return orderVO;
    }
}


































