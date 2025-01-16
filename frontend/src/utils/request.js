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
  response => { //如果響應成功做什麼
    return response.data
  },
  err => { //如果請求錯誤做什麼
    ElMessage.error('伺服器異常')
    return Promise.reject(err)
  }
)

export default instance;