<script setup>
import { ref, reactive, onMounted, watch } from 'vue'
import { ElMessage } from "element-plus"
import { orderConditionPageApi } from '@/api/order'
import { useUserIdStore } from '@/stores/userId'
import dayjs from 'dayjs'
import { orderConfirmApi, orderRejectionApi } from '@/api/order'

const userIdStore = useUserIdStore()
const orderList = reactive([]) // 訂單列表
const selectedStatus = ref('') // 當前選中的訂單狀態
const isRejectDialogVisible = ref(false); // 控制彈窗的顯示
const rejectionReason = ref(''); // 拒單原因輸入框的綁定數據
const rejectOrderId = ref(null)
const searchOrder = ref({
  number:'', phone:'', date:[], beginTime:'', endTime:''
})
// 監聽searchOrder的date屬性
watch(() => searchOrder.value.date, (newVal, oldVal) => {
  if(newVal.length === 2){
    searchOrder.value.beginTime = dayjs(newVal[0]).format('YYYY-MM-DD HH:mm:ss')
    searchOrder.value.endTime = dayjs(newVal[1]).format('YYYY-MM-DD HH:mm:ss')
  }else{
    searchOrder.value.beginTime = ''
    searchOrder.value.endTime = ''
  }
})
// 訂單狀態列表
const orderStatusList = [
  { label: "全部訂單", value: "", count: 0 },
  { label: "待接單", value: "2", count: 0 },
  { label: "待派送", value: "3", count: 0 },
  { label: "派送中", value: "4", count: 0 },
  { label: "已完成", value: "5", count: 0 },
  { label: "已取消", value: "6", count: 0 }
]

// 分頁相關
const currentPage = ref(1) 
const pageSize = ref(5) 
const background = ref(true)
const total = ref(0)
// 鉤子
onMounted(() => {
  search()
})
// 查詢訂單列表
const search = async () => {
  console.log(`查詢訂單列表: status:${selectedStatus.value}, currentPage:${currentPage.value}, pageSize:${pageSize.value}`)
  const res = await orderConditionPageApi(
    searchOrder.value.number, searchOrder.value.phone, selectedStatus.value, 
    searchOrder.value.beginTime, searchOrder.value.endTime, userIdStore.userId, currentPage.value, pageSize.value)
  if(res.code){
    orderList.splice(0, orderList.length, ...res.data.records)
    total.value = res.data.total
  }
}
// 切換訂單狀態
const setStatus = (status) => {
  selectedStatus.value = status
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
// 接單
const confirmOrder = async (id) => {
  const res = await orderConfirmApi(id)
  if(res.code){
    ElMessage.success(`成功接單`)
    search()
  }
}
// 打開拒單彈窗
const openRejectDialog = (id) => {
  isRejectDialogVisible.value = true
  rejectOrderId.value = id
}
// 提交拒單原因並拒單
const submitRejection = async () => {
  if (rejectionReason.value.trim() === '') {
    // 如果拒單原因為空，提醒用戶
    ElMessage.error('請輸入拒單原因')
    return;
  }
  console.log('提交拒單原因:', rejectionReason.value)
  // 調用拒單API
  const res = await orderRejectionApi(rejectOrderId.value, rejectionReason.value)
  if(res.code){
    ElMessage.success('拒單成功！')
    // 關閉彈窗
    isRejectDialogVisible.value = false
    // 刷新
    search()
  }else{
    ElMessage.error(res.msg)
  }
}
// 關閉彈窗的處理函數
const handleClose = () => {
  rejectionReason.value = '' // 清空拒單原因
}
</script>

<template>
  <h1>訂單管理</h1>
  <div class="order-management">
    <!-- 訂單狀態欄 -->
    <div class="order-status-bar">
      <el-button 
        class="status-button"  
        v-for="status in orderStatusList"
        :type="selectedStatus === status.value ? 'primary' : 'default'"
        size="large"
        @click="setStatus(status.value)"
        :key="status.value"
      >
        {{ status.label }}
      </el-button>
    </div>

    <!-- 搜索欄 -->
    {{ searchOrder }}
    <el-form :inline="true" class="search-bar">
      <el-form-item label="訂單號">
        <el-input v-model="searchOrder.number" placeholder="請輸入訂單號" />
      </el-form-item>
      <el-form-item label="手機號碼">
        <el-input v-model="searchOrder.phone" placeholder="請輸入手機號" />
      </el-form-item>
      <el-form-item label="下單時間">
        <el-date-picker
          v-model="searchOrder.date"
          type="daterange"
          range-separator="至"
          start-placeholder="開始日期"
          end-placeholder="結束日期"
          style="width: 250px"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="search">查詢</el-button>
      </el-form-item>
    </el-form>

    <!-- 訂單表格 -->
    <el-table
      :data="orderList"
      border
      style="width: 100%; margin-top: 20px"
      :header-cell-style="{ backgroundColor: '#f5f7fa' }"
    >
      <el-table-column prop="number" label="訂單號" width="150" align="center"/>
      <el-table-column prop="status" label="訂單狀態" width="100" align="center"/>
      <el-table-column prop="userName" label="顧客姓名" width="120" align="center"/>
      <el-table-column prop="phone" label="手機號碼" width="120" align="center"/>
      <el-table-column prop="address" label="地址" align="center"/>
      <el-table-column prop="orderTime" label="下單時間" width="180" align="center"/>
      <el-table-column prop="amount" label="實收金額" width="120" align="center"/>
      <el-table-column label="操作" align="center" width="300">
        <template #default="scope">
              <el-button
                v-if="scope.row.status === 2"
                size="small" 
                type="primary"
                @click="confirmOrder(scope.row.id)"
              >接單</el-button>
              <el-button
                v-else-if="scope.row.status === 3"
                size="small" 
                type="primary"
              >派送</el-button>
              <el-button
                v-else-if="scope.row.status === 4"
                size="small" 
                type="success"
              >完成</el-button>
              <el-button 
                v-if="scope.row.status === 2"
                size="small" 
                type="danger"
                @click="openRejectDialog(scope.row.id)"
              >拒單</el-button>
              <el-button 
                v-else-if="scope.row.status <= 4 "
                size="small" 
                type="danger"
              >取消</el-button>  
              <el-button size="small" type="default" @click="viewOrderDetails(scope.row)">查看</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 分頁條 -->
    <div class="pagination">
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

    <!-- 拒單彈窗 -->
    <el-dialog
      v-model="isRejectDialogVisible"
      title="拒單原因"
      :close-on-click-modal="false"
      :before-close="handleClose"
    >
      <el-form>
        <!-- 拒單原因輸入框 -->
        <el-form-item label="拒單原因">
          <el-input
            type="textarea"
            v-model="rejectionReason"
            placeholder="請輸入拒單原因"
            rows="4"
          ></el-input>
        </el-form-item>
      </el-form>

      <!-- 按鈕區域 -->
      <div class="dialog-footer">
        <el-button @click="isRejectDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="submitRejection">提交原因並拒單</el-button>
      </div>
    </el-dialog>

  </div>
</template>

<style scoped>
.order-management {
  margin-top: 20px;
  padding: 20px;
}
.order-status-bar {
  display: flex;
  gap: 10px; /* 控制按鈕之間的間距 */
  margin-bottom: 20px;
}
.status-button {
  border-radius: 5px; 
}
.pagination{
  margin-top: 20px;
}
.dialog-footer{
  text-align: center;
}
.dialog-footer button{
  margin-left: 30px;
}
</style>