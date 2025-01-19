import request from '@/utils/request'

// 餐點條件分頁查詢
export const pageQueryApi = (name, categoryId, status, page, pageSize) => {
  return request.get('/admin/meal/page', { params: { name, categoryId, status, page, pageSize } })
}

// 新增餐點
export const addApi = (meal) => {
  return request.post('/admin/meal', meal)
}
// 根據id查詢
export const queryInfoApi = (id) => {
  return request.get(`/admin/meal/${id}`)
}

// 修改餐點
export const updateApi = (meal) => {
  return request.put('/admin/meal', meal)
}

// 批次刪除餐點
export const deleteApi = (ids) => {
  return request.delete(`/admin/meal?ids=${ids}`)
}
// 修改餐點狀態
export const updateStatusApi = (id, status) => {
  return request.post(`/admin/meal/status/${status}?id=${id}`)
}

// 顧客端 - 根據分類id查詢上架中的餐點
export const pageMealListByCategoryIdApi = (categoryId) => {
  return request.get(`/customer/meal/list`, { params: {categoryId} })
}
// export const pageQueryByCategoryIdApi = (categoryId, page, pageSize) => {
//   return request.get(`/customer/meal/page`, { params: {categoryId, page, pageSize } })
// }