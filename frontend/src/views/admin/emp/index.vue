<script setup>
import { ref } from 'vue'
import { pageQueryApi } from '@/api/emp'

const empList = ref([
  {
      "name": "湯姆12",
      "account": "Tom12",
      "phone": "0937492741",
      "sex": "1",
      "updateTime": "2025-01-14 11:24"
  }
])

// 搜尋表單條件
const searchEmp = ref({name:'', account:'', phone:'', sex:''})

// 查詢
const search = () => {
  console.log(searchEmp.value)
}

// 清空
const clear = () => {
  searchEmp.value = {name:'', account:'', phone:'', sex:''}
  search()
}

// 分頁相關
const currentPage = ref(4) 
const pageSize = ref(100) 
const background = ref(true)
const total = ref(0)

// 每頁展示紀錄數變化
const handleSizeChange = (val) => {
  console.log(`每頁展示 ${val} 項紀錄`)
}
// 頁碼變化時觸發
const handleCurrentChange = (val) => {
  console.log(`當前頁碼: ${val}`)
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
    <el-button type="primary" > + 新增員工</el-button>
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
          {{ scope.row.sex === 1 ? '男' : '女' }}
        </template>
      </el-table-column>
      <el-table-column prop="updateTime" label="最後操作時間"  align="center"/>
      <el-table-column label="操作" align="center">
        <template #default="scope">
          <el-button type="primary" size="small" @click="handleEdit(scope.row)"><el-icon><Edit /></el-icon>編輯</el-button>
          <el-button type="danger" size="small" @click="handleDelete(scope.row)"><el-icon><Delete /></el-icon>刪除</el-button>
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