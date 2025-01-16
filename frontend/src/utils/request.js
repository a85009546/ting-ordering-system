import axios from 'axios'
import { ElMessage } from 'element-plus'


const instance = axios.create({
  baseURL: '/api',
  timeout: 500000
})

// // 請求攔截器
// instance.interceptors.request.use(
//   config => {
//     //在發送請求前做什麼
//     return config
//   },
//   err => {
//     //如果請求錯誤做什麼
//     return Promise.reject(err)
//   }
// )

import router from '@/router'
// 響應攔截器
instance.interceptors.response.use(
  response => { // 如果響應成功做什麼
    // 判斷狀態碼
    if(response.data.code === 1){
      return response.data
    }
    // 操作失敗
    return Promise.reject(err)
  },
  err => { // 如果響應錯誤做什麼
    ElMessage.error('伺服器異常')
    return Promise.reject(err)
  }
)

export default instance;