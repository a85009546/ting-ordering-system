import request from '@/utils/request'

// 營業額統計
export const getTurnoverStatistics = (begin, end) => {
  return request.get('/admin/report/turnoverStatistics',
    { params: { begin, end} })
}