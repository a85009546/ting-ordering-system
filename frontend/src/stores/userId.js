import { defineStore } from 'pinia'
import { ref } from 'vue'

export const useUserIdStore = defineStore('userId', () => {

  // 定義狀態的內容
  // 1. 響應式變量
  const userId = ref('')
  // 2. 函數，修改token
  const setUserId = (newUserId) => {
    userId.value = newUserId
  }
  // 3. 函數，移除token
  const removeUserId= () => {
    userId.value = ''
  }

  return { userId, setUserId, removeUserId }
},{
    persist: true
})