import request from '@/utils/request'

// 圖片上傳
export const uploadApi = (file) => {
  return request.post('/upload', file)
}