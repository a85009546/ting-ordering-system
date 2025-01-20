import request from '@/utils/request'

// 獲取當前用戶地址列表
export const getAddressListApi = () => {
  return request.get('/customer/addressBook/list')
}

// 設置默認地址
export const setDefaultAddressApi = (id) => {
  return request.put('/customer/addressBook/default', id)
}

// 刪除地址
export const deleteAddressApi = (id) => {
  return request.delete(`/customer/addressBook/delete?id=${id}`)
}