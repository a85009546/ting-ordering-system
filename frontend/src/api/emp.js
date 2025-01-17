import request from '@/utils/request'


// 員工分頁查詢接口
export const pageQueryApi = (empData) => {
  // 借助 UrlSearchParams 物件，將參數轉換為 query 字符串
  const params = new URLSearchParams()
  for(let key in empData){
    params.append(key, empData[key])
  }
  return request.get('/admin/employee/page', empData)
}
