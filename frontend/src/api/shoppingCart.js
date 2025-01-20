import request from '@/utils/request'

// 添加餐點至購物車
export const addToCartApi = (cart) => {
  return request.post('/customer/shoppingCart/add', cart)
}