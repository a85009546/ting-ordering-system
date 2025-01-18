<script setup>
import { ref, onMounted } from 'vue'
import { queryListApi as queryCategoryListApi } from '@/api/category'
import { pageQueryApi, updateStatusApi } from '@/api/meal'
import { ElMessage, ElMessageBox } from 'element-plus'

// 分類列表數據
const categorys = ref([])
// 搜索餐點條件
const searchMeal = ref({name:'', categoryId:'', status:''})
// 接收查詢餐點列表數據
const mealList = ref([])
// 分頁相關
const currentPage = ref(1) 
const pageSize = ref(5) 
const background = ref(true)
const total = ref(0)
// 鉤子
onMounted(() => {
  search()
  // 查詢分類數據
  queryCategorys()
})

// 查詢
const search = async () => {
  const result = await pageQueryApi(searchMeal.value.name, searchMeal.value.categoryId, searchMeal.value.status, 
                                    currentPage.value, pageSize.value)
  if(result.code === 1){
    mealList.value = result.data.records
    total.value = result.data.total
  }
}
// 清空
const clear = () => {
  searchMeal.value = {name:'', categoryId:'', status:''}
  search()
}
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
// 查詢啟用中的分類數據
const queryCategorys = async () => {
  const result = await queryCategoryListApi()
  if(result.code){
    categorys.value = result.data
  }
}

// 修改狀態
const changeStatusById = (id, currentStatus) => {
  const newStatus = currentStatus === 1 ? 0 : 1; // 根據當前狀態切換
  updateStatusApi(id, newStatus).then(result => {
    if(result.code){
      ElMessage.success('修改狀態成功')
      search() // 重新查詢並刷新表格
    } else {
      ElMessage.error(result.msg)
    }
  })
}
</script>

<template>
  <h1>餐點管理</h1>
  <!-- 搜索欄 -->
  <div class="container">
    <el-form :inline="true" :model="searchMeal" class="demo-form-inline">
      <el-form-item label="餐點名稱" :style="{width: '20%', marginRight: '10px'}">
        <el-input v-model="searchMeal.name" placeholder="請輸入餐點名稱" clearable/>
      </el-form-item>

      <el-form-item label="分類" :style="{width: '20%', marginRight: '10px'}">
        <el-select v-model="searchMeal.categoryId" placeholder="請選擇">
          <el-option v-for="c in categorys" :key="c.id" :label="c.name" :value="c.id" />
        </el-select>
      </el-form-item>

      <el-form-item label="狀態" :style="{width: '20%'}"> 
        <el-select v-model="searchMeal.status" placeholder="請選擇" clearable>
          <el-option label="已下架" value=0 />
          <el-option label="上架中" value=1 />
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
    <el-button type="primary" @click="addEmp"> + 新增餐點</el-button>
    <el-button type="danger" @click="deleteBatch"> - 批次刪除</el-button>
  </div>

  <!-- 表格 -->
  <div class="container">
    <el-table :data="mealList" border style="width: 100%">
      <el-table-column type="selection" width="55" align="center"/>
      <el-table-column type="index" label="序號" width="55" align="center"/>
      <el-table-column prop="name" label="餐點名稱" width="150" align="center"/>
      <el-table-column prop="image" label="圖片" width="150" align="center"/>
      <el-table-column prop="categoryName" label="分類" width="150" align="center"/>
      <el-table-column prop="price" label="價格 (元)" width="150" align="center"/>
      <el-table-column prop="status" label="狀態" width="150" align="center">
        <template #default="scope">
            <span :style="{
              color: scope.row.status === 1 ? '#67C23A' : '#F56C6C',
              fontWeight: 'bold'
            }">
              {{ scope.row.status === 1 ? '上架中' : '已下架' }}
            </span>
        </template>
      </el-table-column>
      <el-table-column prop="updateTime" label="最後修改時間"  align="center"/>
      <el-table-column label="操作" align="center">
        <template #default="scope">
          <el-button type="primary" size="small" ><el-icon><Edit /></el-icon>編輯</el-button>
          <el-button type="danger" size="small" ><el-icon><Delete /></el-icon>刪除</el-button>
          <el-button 
            :type="scope.row.status === 1 ? 'danger' : 'success'"
            size="small"
            @click="changeStatusById(scope.row.id, scope.row.status)"
          >
            {{ scope.row.status === 1 ? '下架' : '上架' }}
          </el-button>
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

</template>

<style scoped>
.container {
  margin: 15px 0px;
}
</style>