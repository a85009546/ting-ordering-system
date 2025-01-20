import request from '@/utils/request'

// 添加餐點至購物車
export const addToCartApi = (cart) => {
  return request.post('/customer/shoppingCart/add', cart)
}

// 查看購物車
export const getCartApi = () => {
  return request.get('/customer/shoppingCart/list')
}

// 清空購物車
export const clearCartApi = () => {
  return request.delete('/customer/shoppingCart/clean')
}