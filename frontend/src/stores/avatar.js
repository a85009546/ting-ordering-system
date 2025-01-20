import { defineStore } from 'pinia'
import { ref } from 'vue'

export const useAvatarStore = defineStore('avatar', () => {

  // 定義狀態的內容
  // 1. 響應式變量
  const avatar = ref('')
  // 2. 函數，修改token
  const setAvatar = (newAvatar) => {
    avatar.value = newAvatar
  }
  // 3. 函數，移除token
  const removeAvatar= () => {
    avatar.value = ''
  }

  return { avatar, setAvatar, removeAvatar }
},{
    persist: true
})