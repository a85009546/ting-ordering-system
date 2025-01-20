import { defineStore } from 'pinia'
import { ref } from 'vue'

export const useAccountStore = defineStore('account', () => {

  // 定義狀態的內容
  // 1. 響應式變量
  const account = ref('')
  // 2. 函數，修改token
  const setAccount = (newAccount) => {
    account.value = newAccount
  }
  // 3. 函數，移除token
  const removeAccount= () => {
    account.value = ''
  }

  return { account, setAccount, removeAccount }
},{
    persist: true
})