import request from '@/utils/request'

// 顧客下單
export const orderSubmitApi = (orderSubmit) => {
  return request.post('/customer/order/submit', orderSubmit)
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
