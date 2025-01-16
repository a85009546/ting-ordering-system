import request from '@/utils/request'

// 註冊接口
export const registerApi = (registerData) => {
  return request.post('/auth/register', registerData)
}