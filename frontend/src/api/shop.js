import request from '@/utils/request'


// 設置營業狀態
export const updateStatusApi = (status) => {
  return request.put(`/admin/shop/${status}`)
}

// 查詢營業狀態
export const queryStatusApi = () => {
  return request.get('/shop/status')
}