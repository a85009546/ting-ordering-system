import request from '@/utils/request'

// 註冊接口
export const registerApi = (registerData) => {
  return request.post('/auth/register', registerData)
}

// 登入接口
export const loginApi = (loginData) => {
  return request.post('/auth/login', loginData)
}