<script setup>
import { ref, onMounted } from 'vue'
import { pageQueryApi, addApi, queryInfoApi, updateApi, deleteApi } from '@/api/emp'
import { ElMessage, ElMessageBox } from 'element-plus'

// 性別列表數據
const sexes = ref([{ name: '女', value: '0'}, { name: '男', value: '1'}])

// 接收查詢結果的數據
const empList = ref([])
// 搜尋表單條件
const searchEmp = ref({name:'', account:'', phone:'', sex:''})
// 鉤子
onMounted(() => {
  search()
})
// 查詢
const search = async () => {
  const result = await pageQueryApi(searchEmp.value.name, searchEmp.value.account, searchEmp.value.phone, 
                                    searchEmp.value.sex,currentPage.value, pageSize.value)
  if(result.code === 1){
    empList.value = result.data.records
    total.value = result.data.total
  }
}
// 清空
const clear = () => {
  searchEmp.value = {name:'', account:'', phone:'', sex:''}
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
// 新增員工彈出對話框
const addEmp = () => {
  dialogVisible.value = true
  dialogTitle.value = '新增員工'
  employee.value = {
    account: '',
    name: '',
    phone: '',
    sex: ''
  }
  // 重置表單提示訊息
  if(empFormRef.value){
    empFormRef.value.resetFields()
  }
}

//新增/修改表单
const employee = ref({
  account: '',
  name: '',
  phone: '',
  sex: ''
})

// 控制彈窗
const dialogVisible = ref(false)
const dialogTitle = ref('新增員工')

// 表單引入
const empFormRef = ref()
// 保存員工
const save = async () => {
  // 表單校驗
  if(!empFormRef.value) return
  empFormRef.value.validate(async (valid) => { // valid = true 表示校驗通過
    if(valid){ // 校驗通過，新增員工 or 編輯員工
      let result
      if(employee.value.id){ // 編輯員工
        result = await updateApi(employee.value)
      }else{ // 新增員工
        result = await addApi(employee.value)
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
  { required: true, message: '請輸入姓名', trigger: 'blur' },
  { min: 2, max: 16, message: '長度為 2 到 16 位非空字符', trigger: 'blur' }
  ],
  account: [
    { required: true, message: '請輸入帳號', trigger: 'blur' },
    { min: 4, max: 16, message: '長度為 4 到 16 位非空字符', trigger: 'blur' }
  ],
  phone: [
    { required: true, message: '請輸入手機號碼', trigger: 'blur' },
    { pattern: /^09\d{8}$/, message: '手機號碼必須為09 開頭的 10 位數字', trigger: 'blur'}
  ],
  sex:  [
    { required: true, message: '請選擇性別', trigger: 'change' } // 性別校驗
  ]
}

// 編輯
const edit = async (id) => {
  const result = await queryInfoApi(id)
  if(result.code){
    dialogVisible.value = true
    dialogTitle.value = '編輯員工'
    employee.value = result.data
  }
} 
// 刪除
const deleteById = (id) => {
  // 彈出確認框
  ElMessageBox.confirm('確定刪除此員工嗎？', '提示', 
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
  <h1>員工管理</h1>
  <!-- 搜索欄 -->
  <div class="container">
    <el-form :inline="true" :model="searchEmp" class="demo-form-inline">
      <el-form-item label="姓名">
        <el-input v-model="searchEmp.name" placeholder="請輸入員工姓名" clearable width="100"/>
      </el-form-item>

      <el-form-item label="帳號">
        <el-input v-model="searchEmp.account" placeholder="請輸入員工帳號" clearable width="100"/>
      </el-form-item>

      <el-form-item label="手機">
        <el-input v-model="searchEmp.phone" placeholder="請輸入員工手機" clearable width="150"/>
      </el-form-item>

      <el-form-item label="性別">
        <el-select v-model="searchEmp.sex" placeholder="請選擇" width="50">
          <el-option label="男" value="1" />
          <el-option label="女" value="0" />
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
    <el-button type="primary" @click="addEmp"> + 新增員工</el-button>
  </div>

  <!-- 表格 -->
  <div class="container">
    <el-table :data="empList" border style="width: 100%">
      <el-table-column type="index" label="序號" width="100" align="center"/>
      <el-table-column prop="name" label="姓名" width="180" align="center"/>
      <el-table-column prop="account" label="帳號" width="200" align="center"/>
      <el-table-column prop="phone" label="手機" width="250" align="center"/>
      <el-table-column label="性別" width="100" align="center">
        <template #default="scope">
          {{ scope.row.sex === '1' ? '男' : '女' }}
        </template>
      </el-table-column>
      <el-table-column prop="updateTime" label="最後操作時間"  align="center"/>
      <el-table-column label="操作" align="center">
        <template #default="scope">
          <el-button type="primary" size="small" @click="edit(scope.row.id)"><el-icon><Edit /></el-icon>編輯</el-button>
          <el-button type="danger" size="small" @click="deleteById(scope.row.id)"><el-icon><Delete /></el-icon>刪除</el-button>
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

  <!-- 新增員工/編輯員工 彈出框 -->
  <el-dialog v-model="dialogVisible" :title="dialogTitle" width="30%">
      <el-form :model="employee" :rules="rules" ref="empFormRef" label-width="80px">
        <!-- 第一行 -->
        <el-row>
          <el-col :span="18">
            <el-form-item label="帳號" prop="account">
              <el-input v-model="employee.account" placeholder="請輸入員工帳號，4-16 位"></el-input>
            </el-form-item>
          </el-col>
        </el-row>
        <!-- 第二行 -->
        <el-row>
          <el-col :span="18">
            <el-form-item label="姓名" prop="name">
              <el-input v-model="employee.name" placeholder="請輸入員工姓名，2-10 位"></el-input>
            </el-form-item>
          </el-col>
        </el-row>
        <!-- 第三行 -->
        <el-row>
          <el-col :span="18">
            <el-form-item label="手機號" prop="phone">
              <el-input v-model="employee.phone" placeholder="請輸入員工手機號"></el-input>
            </el-form-item>
          </el-col>
        </el-row>
        <!-- 第四行 -->
        <el-row>
          <el-col :span="18">
            <el-form-item label="性别" prop="sex">
              <el-select v-model="employee.sex" placeholder="請選擇性别" style="width: 100%;">
                <el-option v-for="s in sexes" :key="s.value" :label="s.name" :value="s.value"></el-option>
              </el-select>
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