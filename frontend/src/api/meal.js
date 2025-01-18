import request from '@/utils/request'

// 餐點條件分頁查詢
export const pageQueryApi = (name, categoryId, status, page, pageSize) => {
  return request.get('/admin/meal/page', { params: { name, categoryId, status, page, pageSize } })
}