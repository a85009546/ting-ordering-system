import request from '@/utils/request'

// 顧客端 - 顧客下單
export const orderSubmitApi = (orderSubmit) => {
  return request.post('/customer/order/submit', orderSubmit)
}

// 顧客端 - 顧客支付
export const orderPayApi = (id) => {
  return request.put(`/customer/order/pay/${id}`)
}

// 顧客端 - 歷史訂單分頁查詢
export const orderHistoryPageApi = (status, page, pageSize) => {
  return request.get('/customer/order/historyOrders',
    { params: { status, page, pageSize }})
}

// 顧客端 - 查詢訂單詳情
export const orderDetail4CustomerApi = (id) => {
  return request.get(`/customer/order/orderDetail/${id}`)
}

// 顧客端 - 再來一單
export const orderRepetitionApi = (id) => {
  return request.post(`/customer/order/repetition/${id}`)
}

// 管理端 - 訂單條件分頁查詢
export const orderConditionPageApi = (number, phone, status, beginTime, endTime, userId, page, pageSize) => {
  return request.get('/admin/order/conditionSearch',
    { params: { number, phone, status, beginTime, endTime, userId, page, pageSize } })
}

// 管理端 - 接單
export const orderConfirmApi = (id) => {
  return request.put('/admin/order/confirm', {id})
}

// 管理端 - 拒單
export const orderRejectionApi = (id, rejectionReason) => {
  return request.put('/admin/order/rejection', {id, rejectionReason})
}

// 管理端 - 取消訂單
export const orderCancelApi = (id, cancelReason) => {
  return request.put('/admin/order/cancel', {id, cancelReason})
}

// 管理端 - 派送訂單
export const orderDeliveryApi = (id) => {
  return request.put(`/admin/order/delivery/${id}`)
}

// 管理端 - 完成訂單
export const orderCompleteApi = (id) => {
  return request.put(`/admin/order/complete/${id}`)
}

// 管理端 - 各個狀態的訂單數量統計
export const orderStatisticsApi = () => {
  return request.get('/admin/order/statistics')
}

// 管理端 - 查詢訂單詳情
export const orderDetailApi = (id) => {
  return request.get(`/admin/order/details/${id}`)
}

