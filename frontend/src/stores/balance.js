import { defineStore } from 'pinia'
import { ref } from 'vue'

export const useBalanceStore = defineStore('balance', () => {

  // 定義狀態的內容
  // 1. 響應式變量
  const balance = ref('')
  // 2. 函數，修改token
  const setBalance = (newBalance) => {
    balance.value = newBalance
  }
  // 3. 函數，移除token
  const removeBalance= () => {
    balance.value = ''
  }

  return { balance, setBalance, removeBalance }
},{
    persist: true
})