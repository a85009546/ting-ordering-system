import { defineStore } from 'pinia'
import { ref } from 'vue'

export const useRoleStore = defineStore('role', () => {

  // 定義狀態的內容
  // 1. 響應式變量
  const role = ref('')
  // 2. 函數，修改token
  const setRole = (newRole) => {
    role.value = newRole
  }
  // 3. 函數，移除token
  const removeRole= () => {
    role.value = ''
  }

  return { role, setRole, removeRole }
},{
    persist: true
})