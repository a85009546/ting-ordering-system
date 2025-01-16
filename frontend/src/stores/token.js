// 定義 store
import { defineStore } from 'pinia'
import { ref } from 'vue'

/*
    第一個參數 : 名字，唯一性
    第二個參數 : 函數，函數的內部可以定義狀態的所有內容
    第三個參數 : 持久化存儲

    返回值 : 函數
*/
export const useTokenStore = defineStore('token', () => {

  // 定義狀態的內容
  // 1. 響應式變量
  const token = ref('')
  // 2. 函數，修改token
  const setToken = (newToken) => {
    token.value = newToken
  }
  // 3. 函數，移除token
  const removeToken = () => {
    token.value = ''
  }

  return { token, setToken, removeToken }
},{
   persist: true  // 持久化存儲
})

