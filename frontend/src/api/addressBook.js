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
  return request.delete(`/customer/addressBook?id=${id}`)
}

// 根據id查詢地址
export const getAddressByIdApi = (id) => {
  return request.get(`/customer/addressBook/${id}`)
}

// 新增地址
export const addAddressApi = (address) => {
  return request.post('/customer/addressBook', address)
}

// 修改地址
export const updateAddressApi = (address) => {
  return request.put('/customer/addressBook', address)
}