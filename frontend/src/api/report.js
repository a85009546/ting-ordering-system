import request from '@/utils/request'

// 營業額統計
export const getTurnoverStatistics = (begin, end) => {
  return request.get('/admin/report/turnoverStatistics',
    { params: { begin, end} })
}

// 顧客統計
export const getCustomerStatistics = (begin, end) => {
  return request.get('/admin/report/customerStatistics',
    { params: { begin, end} })
}

// 訂單統計
export const getOrderStatistics = (begin, end) => {
  return request.get('/admin/report/ordersStatistics',
    { params: { begin, end} })
}

// 銷量排名統計
export const getTop= (begin, end) => {
  return request.get('/admin/report/top10',
    { params: { begin, end} })
}

// 導出運營報表
export const exportReport = () => {
  return request.get('/admin/report/export', { responseType: 'blob' })
}