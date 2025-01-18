import request from '@/utils/request'
import { useRoleStore } from '@/stores/role'



// 獲取選單接口
export const getMenuApi = () => {
  // 獲取身分
  const roleStore = useRoleStore()

  return request.get('/menu', { params: { role: roleStore.role } })
}
