package com.github.mattwei.service.impl;

import com.alibaba.fastjson2.JSON;
import com.github.mattwei.constant.MessageConstant;
import com.github.mattwei.context.BaseContext;
import com.github.mattwei.dto.*;
import com.github.mattwei.entity.*;
import com.github.mattwei.exception.AddressBookBusinessException;
import com.github.mattwei.exception.OrderBusinessException;
import com.github.mattwei.exception.ShoppingCartBusinessException;
import com.github.mattwei.exception.UserBusinessException;
import com.github.mattwei.mapper.*;
import com.github.mattwei.result.PageResult;
import com.github.mattwei.service.OrderService;
import com.github.mattwei.vo.OrderStatisticsVO;
import com.github.mattwei.vo.OrderSubmitVO;
import com.github.mattwei.vo.OrderVO;
import com.github.mattwei.websocket.WebSocketServer;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.*;
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
    @Autowired
    private WebSocketServer webSocketServer;
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
        // 1.2 檢查是否有地址
        AddressBook addressBook = addressBookMapper.getById(orderSumbitDTO.getAddressBookId());
        if(addressBook == null){
            throw new AddressBookBusinessException(MessageConstant.ADDRESS_BOOK_IS_NULL);
        }
        User user = userMapper.getById(userId);

        // 2. 需要向訂單表插入 1 條數據
        Orders orders = new Orders();
        BeanUtils.copyProperties(orderSumbitDTO, orders);
        orders.setNumber(String.valueOf(System.currentTimeMillis())); // 使用時間戳當訂單號
        orders.setStatus(Orders.PENDING_PAYMENT); // 待支付
        orders.setUserId(userId);
        orders.setOrderTime(LocalDateTime.now());
        orders.setPayStatus(Orders.UN_PAID); // 未支付
        orders.setPhone(addressBook.getPhone());
        String destrictName = addressBook.getDistrictName() == null ? "" : addressBook.getDistrictName();
        orders.setAddress(addressBook.getCityName() + destrictName + addressBook.getDetail());
        orders.setUserName(user.getName());
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
     * 顧客支付
     * @param id
     */
    @Override
    @Transactional
    public void payOrder(Long id) {
        // 1. 根據訂單id查詢訂單
        Orders orders = orderMapper.getById(id);
        // 1.1 檢查訂單狀態是否為 待支付
        if(orders.getStatus() != Orders.PENDING_PAYMENT){
            throw new OrderBusinessException(MessageConstant.ORDER_STATUS_ERROR);
        }
        // 2. 查詢用戶當前餘額
        Long userId = BaseContext.getCurrentId();
        User user = userMapper.getById(userId);
        // 2.1 餘額不足，拋出異常
        if(user.getBalance().compareTo(orders.getAmount()) < 0){
            throw new UserBusinessException(MessageConstant.USER_BALANCE_NOT_ENOUGH);
        }
        // 3. 根據訂單金額扣除用戶餘額
        user.setBalance(user.getBalance().subtract(orders.getAmount()));
        userMapper.update(user);

        // 4. 修改訂單狀態、結帳時間、支付狀態
        orders.setStatus(Orders.TO_BE_CONFIRMED); // 待接單
        orders.setCheckoutTime(LocalDateTime.now());
        orders.setPayStatus(Orders.PAYED); // 已支付
        orderMapper.update(orders);

        // 通過 websocket 向用戶端(管理端)瀏覽器發送消息 type orderId content
        Map map = new HashMap();
        map.put("type", 1); // 1來單提醒 2顧客催單
        map.put("orderId", orders.getId());
        map.put("content", "訂單號: " + orders.getNumber());
        // 轉成JSON字符串
        String json = JSON.toJSONString(map);
        webSocketServer.sendToAllClient(json);

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
     * 查詢訂單詳情
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

    /**
     * 管理端 - 接單
     * @param ordersConfirmDTO
     */
    @Override
    public void confirm(OrdersConfirmDTO ordersConfirmDTO) {
        Orders orders = Orders.builder()
                .id(ordersConfirmDTO.getId())
                .status(Orders.CONFIRMED)
                .build();
        orderMapper.update(orders);
    }

    /**
     * 管理端 - 拒單
     * @param ordersRejectionDTO
     */
    @Override
    @Transactional
    public void rejection(OrdersRejectionDTO ordersRejectionDTO) {
        // 根據id查詢訂單
        Orders ordersDB = orderMapper.getById(ordersRejectionDTO.getId());

        // 訂單狀態為 2(待接單) 才可以拒單
        if(ordersDB == null || !ordersDB.getStatus().equals(Orders.TO_BE_CONFIRMED)){
            throw new OrderBusinessException(MessageConstant.ORDER_STATUS_ERROR);
        }

        // 支付狀態
        Integer payStatus = ordersDB.getPayStatus();
        if(payStatus == Orders.PAYED){
            // 用戶已支付，需要退款
            // 根據用戶id查詢用戶資料
            User user = userMapper.getById(ordersDB.getUserId());
            user.setBalance(user.getBalance().add(ordersDB.getAmount()));
            userMapper.update(user);
        }
        // 根據訂單id更新訂單狀態、拒單原因、取消時間
        Orders orders = Orders.builder()
                .id(ordersRejectionDTO.getId())
                .status(Orders.CANCELLED)
                .rejectionReason(ordersRejectionDTO.getRejectionReason())
                .cancelTime(LocalDateTime.now())
                .build();

        orderMapper.update(orders);
    }

    /**
     * 管理端 - 取消訂單
     * 訂單狀態為 1待支付 2待接單 3已接單 4派送中 都可以取消訂單
     * @param ordersCancelDTO
     */
    @Override
    public void cancel(OrdersCancelDTO ordersCancelDTO) {
        // 根據id查詢訂單
        Orders ordersDB = orderMapper.getById(ordersCancelDTO.getId());

        // 支付狀態
        Integer payStatus = ordersDB.getPayStatus();
        if(payStatus == Orders.PAYED){
            // 用戶已支付，需要退款
            // 根據用戶id查詢用戶資料
            User user = userMapper.getById(ordersDB.getUserId());
            user.setBalance(user.getBalance().add(ordersDB.getAmount()));
            userMapper.update(user);
        }

        // 根據訂單id更新訂單狀態、取消原因、取消時間
        Orders orders = Orders.builder()
                .id(ordersCancelDTO.getId())
                .status(Orders.CANCELLED)
                .cancelReason(ordersCancelDTO.getCancelReason())
                .cancelTime(LocalDateTime.now())
                .build();

        orderMapper.update(orders);
    }

    /**
     * 管理端 - 派送訂單
     * @param id
     */
    @Override
    public void delivery(Long id) {
        // 根據id查詢訂單
        Orders ordersDB = orderMapper.getById(id);

        // 校驗訂單是否存在，且狀態為 3
        if(ordersDB == null || !ordersDB.getStatus().equals(Orders.CONFIRMED)){
            throw new OrderBusinessException(MessageConstant.ORDER_STATUS_ERROR);
        }

        Orders orders = Orders.builder()
                .id(id)
                .status(Orders.DELIVERY_IN_PROGRESS) // 狀態更新為派送中
                .build();
        orderMapper.update(orders);
    }

    /**
     * 管理端 - 完成訂單
     * @param id
     */
    @Override
    public void complete(Long id) {
        // 根據id查詢訂單
        Orders ordersDB = orderMapper.getById(id);

        // 校驗訂單是否存在，且狀態為 4
        if(ordersDB == null || !ordersDB.getStatus().equals(Orders.DELIVERY_IN_PROGRESS)){
            throw new OrderBusinessException(MessageConstant.ORDER_STATUS_ERROR);
        }

        Orders orders = Orders.builder()
                .id(id)
                .status(Orders.COMPLETED) // 狀態更新為完成
                .deliveryTime(LocalDateTime.now()) // 設置派送時間
                .build();
        orderMapper.update(orders);
    }

    /**
     * 顧客端 - 訂單分頁查詢
     * @param pageNum
     * @param pageSize
     * @param status
     * @return
     */
    @Override
    public PageResult pageQuery4Customer(int pageNum, int pageSize, Integer status) {
        PageHelper.startPage(pageNum, pageSize);

        OrdersPageQueryDTO ordersPageQueryDTO = new OrdersPageQueryDTO();
        ordersPageQueryDTO.setUserId(BaseContext.getCurrentId());
        ordersPageQueryDTO.setStatus(status);

        // 條件分頁查詢
        Page<Orders> page = orderMapper.pageQuery(ordersPageQueryDTO);

        List<OrderVO> list = new ArrayList<>();
        // 查詢訂單明細
        if(page != null && page.getTotal() > 0){
            for (Orders orders : page) {
                // 獲取訂單id
                Long orderId = orders.getId();
                // 根據訂單id查詢訂單明細
                List<OrderDetail> orderDetailList = orderDetailMapper.getByOrderId(orderId);

                OrderVO orderVO = new OrderVO();
                BeanUtils.copyProperties(orders, orderVO);
                orderVO.setOrderDetailList(orderDetailList);
                list.add(orderVO);
            }
        }
        return new PageResult(page.getTotal(), list);
    }

    /**
     * 顧客端 - 取消訂單
     * @param id
     */
    @Override
    @Transactional
    public void userCancelById(Long id) {
        // 根據訂單id查詢訂單
        Orders ordersDB = orderMapper.getById(id);
        if(ordersDB == null){
            throw new OrderBusinessException(MessageConstant.ORDER_NOT_FOUND);
        }

        // 訂單狀態 1待支付 2待接單 3已接單 4派送中 5已完成 6已取消
        // 只能取消狀態為 1待支付、2待接單
        if(ordersDB.getStatus() > 2){
            throw new OrderBusinessException(MessageConstant.ORDER_STATUS_ERROR);
        }

        Orders orders = new Orders();
        orders.setId(id);

        // 訂單已付款的話需要退款
        if(ordersDB.getStatus().equals(Orders.TO_BE_CONFIRMED)){
            // 獲取用戶資訊
            User user = userMapper.getById(ordersDB.getUserId());
            user.setBalance(user.getBalance().add(ordersDB.getAmount()));
            userMapper.update(user);
            // 修改支付狀態為退款
            orders.setPayStatus(Orders.REFUND);
        }
        // 更新訂單狀態、取消原因、取消時間
        orders.setStatus(Orders.CANCELLED);
        orders.setCancelReason("顧客取消");
        orders.setCancelTime(LocalDateTime.now());
        orderMapper.update(orders);
    }

    /**
     * 顧客端 - 再來一單
     * @param id
     */
    @Override
    public void repetition(Long id) {
        // 獲取當前用戶id
        Long userId = BaseContext.getCurrentId();
        // 根據訂單id查詢訂單詳情
        List<OrderDetail> orderDetailList = orderDetailMapper.getByOrderId(id);

        // 將訂單詳情轉換成購物車物件
        List<ShoppingCart> shoppingCartList = orderDetailList.stream().map(orderDetail -> {
            ShoppingCart shoppingCart = new ShoppingCart();
            // 第三個參數是指不要覆蓋的參數
            BeanUtils.copyProperties(orderDetail, shoppingCart, "id");
            shoppingCart.setUserId(userId);
            shoppingCart.setCreateTime(LocalDateTime.now());
            return shoppingCart;
        }).collect(Collectors.toList());

        // 將購物車對象批量添加到數據庫
        shoppingCartMapper.insertBatch(shoppingCartList);
    }

    /**
     * 顧客端 - 催單
     * @param id
     */
    @Override
    public void reminder(Long id) {
        // 根據id查詢訂單
        Orders ordersDB = orderMapper.getById(id);

        // 校驗訂單是否存在
        if(ordersDB == null){
            throw new OrderBusinessException(MessageConstant.ORDER_STATUS_ERROR);
        }
        // 通過 websocket 發送消息
        Map map = new HashMap();
        map.put("type", 2); // 客戶催單
        map.put("orderId", id);
        map.put("content", "訂單號: " + ordersDB.getNumber() + "，請注意接單!");
        webSocketServer.sendToAllClient(JSON.toJSONString(map));

    }
}


































