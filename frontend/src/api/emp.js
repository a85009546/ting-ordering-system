import request from '@/utils/request'


// 員工分頁查詢接口
export const pageQueryApi = (name, account, phene, sex, page, pageSize) => {
  return request.get('/admin/employee/page', { params: { name, account, phene, sex, page, pageSize } })
}

// 新增員工接口
export const addApi = (employee) => {
  return request.post('/admin/employee', employee)
}