import request from '@/utils/request'
import { useRoleStore } from '@/stores/role'



// 獲取選單接口
export const getMenuApi = () => {
  const roleStore = useRoleStore()
  console.log(roleStore.role);

  return request.get('/menu', { params: { role: roleStore.role } })
}
