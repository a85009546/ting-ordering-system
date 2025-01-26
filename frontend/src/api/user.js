import request from '@/utils/request'



// 根據id查詢用戶
export const getUserByIdApi = (id) => {
  return request.get(`/user/${id}`)
}

// 更新用戶資訊
export const updateUserApi = (user) => {
  return request.put('/user', user)
}

// 修改用戶密碼
export const updateUserPasswordApi = (password, newPassword) => {
  return request.put('/user/changePassword',{ password, newPassword })
}