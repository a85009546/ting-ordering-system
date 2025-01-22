import request from '@/utils/request'

// 顧客下單
export const orderSubmitApi = (orderSubmit) => {
  return request.post('/customer/order/submit', orderSubmit)
}