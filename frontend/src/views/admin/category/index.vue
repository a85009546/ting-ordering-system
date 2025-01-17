<script setup>
import { ref, onMounted } from 'vue'
import { pageQueryApi, addApi, queryInfoApi, updateApi, deleteApi } from '@/api/category'
import { ElMessage, ElMessageBox } from 'element-plus'

// 接收查詢結果的數據
const categoryList = ref([])
// 搜尋表單條件
const searchCategory = ref({name:'', status:''})
// 鉤子
onMounted(() => {
  search()
})
// 查詢
const search = async () => {
  const result = await pageQueryApi(searchCategory.value.name, searchCategory.value.status,
                                    currentPage.value, pageSize.value)
  if(result.code === 1){
    categoryList.value = result.data.records
    total.value = result.data.total
  }
}
// 清空
const clear = () => {
  searchCategory.value = {name:'', status:''}
  search()
}
// 分頁相關
const currentPage = ref(1) 
const pageSize = ref(5) 
const background = ref(true)
const total = ref(0)
// 每頁展示紀錄數變化
const handleSizeChange = (val) => {
  console.log(`每頁展示 ${val} 項紀錄`)
  search()
}
// 頁碼變化時觸發
const handleCurrentChange = (val) => {
  console.log(`當前頁碼: ${val}`)
  search()
}

//新增/修改表单
const category = ref({
  name: '',
  status: '' 
})
// 新增分類彈出對話框
const addCategory = () => {
  dialogVisible.value = true
  dialogTitle.value = '新增分類'
  category.value = {
    name: '',
    status: ''
  }
  // 重置表單提示訊息
  if(categoryFormRef.value){
    categoryFormRef.value.resetFields()
  }
}
// 控制彈窗
const dialogVisible = ref(false)
const dialogTitle = ref('新增分類')
// 表單引入
const categoryFormRef = ref()
// 保存分類
const save = async () => {
  // 表單校驗
  if(!categoryFormRef.value) return
  categoryFormRef.value.validate(async (valid) => { // valid = true 表示校驗通過
    if(valid){ // 校驗通過，新增分類 or 編輯分類
      let result
      if(category.value.id){ // 編輯分類
        result = await updateApi(category.value)
      }else{ // 新增分類
        result = await addApi(category.value)
      }
      if(result.code){
        ElMessage.success('保存成功')
        // 關閉彈框
        dialogVisible.value = false
        search()
      }else{
        ElMessage.error(result.msg)
      }
    }else{
      ElMessage.error('表單校驗不通過')
    }
  })
}

// 校驗規則
const rules = {
  name: [
  { required: true, message: '請輸入分類名稱', trigger: 'blur' },
  { min: 1, max: 16, message: '長度為 1 到 16 位非空字符', trigger: 'blur' }
  ]
}
// 編輯
const edit = async (id) => {
  const result = await queryInfoApi(id)
  if(result.code){
    console.log(result.data)
    dialogVisible.value = true
    dialogTitle.value = '編輯分類'
    category.value= result.data
  }
} 
// 刪除
const deleteById = (id) => {
  // 彈出確認框
  ElMessageBox.confirm('確定刪除此分類嗎？', '提示', 
    { confirmButtonText: '確定', cancelButtonText: '取消', type: 'warning' }
  ).then(async () => { // 確定
    const result = await deleteApi(id)
    if(result.code){
      ElMessage.success('刪除成功')
      search()
    }else{
      ElMessage.error(result.msg)
    }
  }).catch(() => { // 取消
    ElMessage.info('取消刪除')
  })
}

</script>

<template>
  <h1>分類管理</h1>
  <!-- 搜索欄 -->
  <div class="container">
    <el-form :inline="true" :model="searchCategory" class="demo-form-inline">
      <el-form-item label="分類名稱">
        <el-input v-model="searchCategory.name" placeholder="請輸入分類名稱" clearable width="100"/>
      </el-form-item>

      <el-form-item label="狀態">
        <el-select v-model="searchCategory.status" placeholder="請選擇" clearable width="50">
          <el-option label="禁用" value=0 />
          <el-option label="啟用" value=1 />
        </el-select>
      </el-form-item>
      
      <el-form-item>
        <el-button type="primary" @click="search">查詢</el-button>
        <el-button type="info" @click="clear">清空</el-button>
      </el-form-item>
    </el-form>
  </div>
  <!-- 功能按鈕 -->
  <div class="container">
    <el-button type="primary" @click="addCategory"> + 新增分類</el-button>
  </div>

  <!-- 表格 -->
  <div class="container">
    <el-table :data="categoryList" border style="width: 100%">
      <el-table-column type="index" label="序號" width="100" align="center"/>
      <el-table-column prop="name" label="分類名稱" width="180" align="center"/>
      <el-table-column label="狀態" width="100" align="center">
        <template #default="scope">
          {{ scope.row.status === 1 ? '啟用' : '禁用' }}
        </template>
      </el-table-column>
      <el-table-column prop="updateTime" label="最後操作時間"  align="center"/>
      <el-table-column label="操作" align="center">
        <template #default="scope">
          <el-button type="primary" size="small" @click="edit(scope.row.id)"><el-icon><Edit /></el-icon>編輯</el-button>
          <el-button type="danger" size="small" @click="deleteById(scope.row.id)"><el-icon><Delete /></el-icon>刪除</el-button>
          <el-button type="danger" size="small" @click="changeStatus(scope.row.id)"><el-icon><Delete /></el-icon>禁用</el-button>
        </template>
      </el-table-column>
    </el-table>
  </div>

  <!-- 分頁條 -->
  <div class="container">
    <el-pagination
      v-model:current-page="currentPage"
      v-model:page-size="pageSize"
      :page-sizes="[5, 10, 20, 30, 40]"
      :background="background"
      layout="total, sizes, prev, pager, next, jumper"
      :total="total"
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
    />
  </div>

  <!-- 新增分類/編輯分類 彈出框 -->
  <el-dialog v-model="dialogVisible" :title="dialogTitle" width="30%">
      <el-form :model="category" :rules="rules" ref="categoryFormRef" label-width="80px">

        <el-row>
          <el-col :span="18">
            <el-form-item label="分類名稱" prop="name">
              <el-input v-model="category.name" placeholder="請輸入分類名稱，1-16 位"></el-input>
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      
      <!-- 底部按钮 -->
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="dialogVisible = false">取消</el-button>
          <el-button type="primary" @click="save">保存</el-button>
        </span>
      </template>
  </el-dialog>
</template>

<style scoped>
.container {
  margin: 15px 0px;
}
</style>