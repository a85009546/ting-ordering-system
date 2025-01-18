import request from '@/utils/request'

// 餐點條件分頁查詢
export const pageQueryApi = (name, categoryId, status, page, pageSize) => {
  return request.get('/admin/meal/page', { params: { name, categoryId, status, page, pageSize } })
}



// 修改餐點狀態
export const updateStatusApi = (id, status) => {
  return request.post(`/admin/meal/status/${status}?id=${id}`)
}