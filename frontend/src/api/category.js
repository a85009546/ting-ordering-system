import request from '@/utils/request'


// 分類分頁查詢接口
export const pageQueryApi = (name, status, page, pageSize) => {
  return request.get('/admin/category/page', { params: { name, status, page, pageSize }})
}

// 新增分類接口
export const addApi = (category) => {
  return request.post('/admin/category', category)
}