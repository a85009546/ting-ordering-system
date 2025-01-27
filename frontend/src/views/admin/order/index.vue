<script setup>
import { ref, reactive, onMounted, watch, computed } from 'vue'
import { ElMessage } from "element-plus"
import { orderConditionPageApi } from '@/api/order'
import { useUserIdStore } from '@/stores/userId'
import dayjs from 'dayjs'
import { orderConfirmApi, orderRejectionApi, orderCancelApi, 
  orderDeliveryApi, orderCompleteApi, orderStatisticsApi, orderDetailApi } from '@/api/order'

const userIdStore = useUserIdStore()
const orderList = reactive([]) // 訂單列表
const selectedStatus = ref('') // 當前選中的訂單狀態
const isDialogVisible = ref(false) // 控制彈窗的顯示
const isDetaildialogVisible = ref(false) // 控制訂單詳情彈窗的顯示
const isRejection = ref(false)
const DialogTitle = ref('拒單原因')
const labelText = ref('拒單原因'); // 動態改變的label
const placeholderText = ref('請輸入拒單原因'); // 動態改變的placeholder
const reason = ref(''); // 拒單原因輸入框的綁定數據
const orderDetail = ref({}) // 訂單詳情
// 分頁相關
const currentPage = ref(1) 
const pageSize = ref(5) 
const background = ref(true)
const total = ref(0)
const selectedOrderId = ref(null)
const searchOrder = ref({
  number:'', phone:'', date:[], beginTime:'', endTime:''
})
const statisticsData = ref({
  toBeConfirmed:null, confirmed:null, deliveryInProgress:null,
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
const orderStatusList = computed(() => [
  { label: "全部訂單", value: "", count: 0 },
  { label: "待接單", value: "2", count: statisticsData.value.toBeConfirmed },
  { label: "待派送", value: "3", count: statisticsData.value.confirmed },
  { label: "派送中", value: "4", count: statisticsData.value.deliveryInProgress },
  { label: "已完成", value: "5", count: 0 },
  { label: "已取消", value: "6", count: 0 }
])

// 獲得訂單的數量統計
const fetchOrderCount = async () => {
  const res = await orderStatisticsApi()
  if(res.code){
    statisticsData.value = {
      toBeConfirmed: res.data.toBeConfirmed || 0,
      confirmed: res.data.confirmed || 0,
      deliveryInProgress: res.data.deliveryInProgress || 0,
    }
    console.log(statisticsData.value)
  }
}
// 鉤子
onMounted(() => {
  search()
  fetchOrderCount()
})
// 查詢訂單列表
const search = async () => {
  console.log(`查詢訂單列表: status:${selectedStatus.value}, currentPage:${currentPage.value}, pageSize:${pageSize.value}`)
  const res = await orderConditionPageApi(
    searchOrder.value.number, searchOrder.value.phone, selectedStatus.value, 
    searchOrder.value.beginTime, searchOrder.value.endTime, currentPage.value, pageSize.value)
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
    fetchOrderCount()
  }
}
// 打開拒單彈窗
const openRejectDialog = (id) => {
  isRejection.value = true
  isDialogVisible.value = true
  DialogTitle.value = '拒單'
  labelText.value = '拒單原因'
  placeholderText.value = '請輸入拒單原因'
  selectedOrderId.value = id
}
// 打開取消訂單彈窗
const openCancelDialog = (id) => {
  isRejection.value = false
  isDialogVisible.value = true
  DialogTitle.value = '取消訂單'
  labelText.value = '取消原因'
  placeholderText.value = '請輸入取消原因'
  selectedOrderId.value = id
}
// 打開查看訂單詳情彈窗
const openDetailDialog = async (id, status) => {
  isDetaildialogVisible.value = true
  selectedOrderId.value = id
  selectedStatus.value = status
  const res = await orderDetailApi(id)
  if(res.code){
    orderDetail.value = res.data
    console.log(orderDetail.value)
  }
}
// 提交拒單/取消 原因並 拒單/取消訂單
const submitReason = async () => {
  if (reason.value.trim() === '') {
    // 如果原因為空，提醒用戶
    ElMessage.error(`請輸入${labelText.value}`)
    return;
  }
  let res
  console.log(`提交${labelText.value}:`, reason.value)
  // 判斷是拒單還是取消並調用API
  if(isRejection.value){ // 拒單
    res = await orderRejectionApi(selectedOrderId.value, reason.value)
  }else{ // 取消
    res = await orderCancelApi(selectedOrderId.value, reason.value)
  }
  if(res.code){
    ElMessage.success('操作成功！')
    // 關閉彈窗
    isDialogVisible.value = false
    // 刷新
    search()
  }else{
    ElMessage.error(res.msg)
  }
}
// 派送訂單
const deliveryOrder = async (id) => {
  const res = await orderDeliveryApi(id)
  if(res.code){
    ElMessage.success('已派送訂單！')
    // 刷新
    search()
    fetchOrderCount()
  }
}
// 完成訂單
const completeOrder = async (id) => {
  const res = await orderCompleteApi(id)
  if(res.code){
    ElMessage.success('訂單已完成！')
    // 刷新
    search()
  }
}
// 關閉彈窗的處理函數
const handleClose = () => {
  reason.value = '' // 清空拒單原因
  selectedOrderId.value = null; // 清空訂單 ID
}
</script>

<template>
  <h1>訂單管理</h1>
  <div class="order-management">
    <!-- 訂單狀態欄 -->
    <div class="order-status-bar">
      <el-badge 
          v-for="status in orderStatusList" :key="status.value"
          :value="status.count > 0 ? status.count : null"
          class="status-badge"
          :hidden="status.count === 0"
      >
        <el-button 
          class="status-button"   
          :type="selectedStatus === status.value ? 'primary' : 'default'"
          size="large"
          @click="setStatus(status.value)"
        >
          {{ status.label }}
        </el-button>
      </el-badge>
    </div>

    <!-- 搜索欄 -->
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
      <el-table-column prop="number" label="訂單編號" width="150" align="center"/>
      <el-table-column prop="status" label="訂單狀態" width="100" align="center">
        <template #default="scope">
          <span v-if="scope.row.status === 1">待付款</span>
          <span v-else-if="scope.row.status === 2">待接單</span>
          <span v-else-if="scope.row.status === 3">待派送</span>
          <span v-else-if="scope.row.status === 4">派送中</span>
          <span v-else-if="scope.row.status === 5">已完成</span>
          <span v-else-if="scope.row.status === 6">已取消</span>
        </template>
      </el-table-column>  
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
                @click="deliveryOrder(scope.row.id)"
              >派送</el-button>
              <el-button
                v-else-if="scope.row.status === 4"
                size="small" 
                type="success"
                @click="completeOrder(scope.row.id)"
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
                @click="openCancelDialog(scope.row.id)"
              >取消</el-button>  
              <el-button 
                size="small" 
                type="default" 
                @click="openDetailDialog(scope.row.id, scope.row.status)"
              >查看</el-button>
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

    <!-- 拒單/取消彈窗 -->
    <el-dialog
      v-model="isDialogVisible"
      :title="DialogTitle"
      @close="handleClose"
    >
      <el-form>
        <!-- 原因輸入框 -->
        <el-form-item :label="labelText">
          <el-input
            type="textarea"
            v-model="reason"
            :placeholder="placeholderText"
            rows="4"
          ></el-input>
        </el-form-item>
      </el-form>

      <!-- 按鈕區域 -->
      <div class="dialog-footer">
        <el-button @click="isDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="submitReason">提交</el-button>
      </div>
    </el-dialog>

    <!-- 訂單明細彈窗 -->
    <el-dialog 
      v-model="isDetaildialogVisible"
      title="訂單詳細資訊" 
      :close-on-click-modal="true"
      width="600px"
    >
      <div>
        <hr />
        <!-- 第一行：訂單號及下單時間 -->
        <div class="row">
          <p><strong>訂單號：</strong>{{ orderDetail.number }}</p>
          <p><strong>下單時間：</strong>{{ orderDetail.orderTime }}</p>
        </div>
        <!-- 第二行：訂單狀態及訂單金額 -->
        <div class="row">
          <p><strong>訂單狀態：</strong>{{ orderDetail.status }}</p>
          <p><strong>訂單金額：</strong>{{ orderDetail.amount }}</p>
        </div>
        <!-- 第三行：用戶名及手機號碼 -->
        <div class="row">
          <p><strong>用戶名：</strong>{{ orderDetail.userName }}</p>
          <p><strong>手機號碼：</strong>{{ orderDetail.phone }}</p>
        </div>
        <!-- 第四行：地址 -->
        <div class="row">
          <p><strong>地址：</strong>{{ orderDetail.address }}</p>
        </div>
        <!-- 第五行：備註 -->
        <div class="row">
          <p><strong>備註：</strong>{{ orderDetail.remark || "無" }}</p>
        </div>
        <el-table 
          :data="orderDetail.orderDetailList" 
          class="order-detail-table"
          stripe 
          style="width: 520px">
          <el-table-column prop="name" label="餐點" width="120" align="left"/>
          <el-table-column prop="flavor" label="口味" width="100" align="center"/>
          <el-table-column prop="number" label="數量" width="120" align="center"/>
          <el-table-column prop="amount" label="價格" width="100" align="right"/>
        </el-table>
        <br>
        <hr/>
        <!-- 外送費和合計 -->
        <el-row class="order-count-row" gutter="150px">
          <el-col :span="10" style="text-align: left;">外送費</el-col>
          <el-col :span="10" style="text-align: right;">30</el-col>
        </el-row>
        <el-row class="order-count-row" gutter="150px">
          <el-col :span="10" style="text-align: left;">合計</el-col>
          <el-col :span="10" style="text-align: right;">{{orderDetail.amount}}</el-col>
        </el-row>
        
      </div>
      <!-- 底部按鈕 -->
      <template #footer>
        <el-button
          v-if="selectedStatus === 2"
          type="danger" 
          @click="openRejectDialog(selectedOrderId)"
          >拒單</el-button>
        <el-button
          v-else-if="selectedStatus <= 4"
          type="danger" 
          @click="openCancelDialog(selectedOrderId)"
          >取消訂單</el-button>
        <el-button @click="isDetaildialogVisible = false">返回</el-button>
      </template>
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
.status-badge{
  margin-bottom: 10px;
  margin-left: 20px;
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
.row {
  margin-top: 20px;
  margin-bottom: 10px;
  padding: 0px 45px;
  display: flex;
  justify-content: space-between; /* 讓左右欄位分佈到兩端 */
  align-items: center; /* 確保垂直對齊 */
}
.row p {
  margin: 0; /* 移除段落預設的外邊距 */
  flex: 1; /* 讓每個欄位占用均等空間 */
}
.row p:first-child, :last-child {
  text-align: left; /* 左側欄位靠左對齊 */
}
.order-detail-table{
  margin-left: 35px;
  margin-right: 20px;
}
.order-count-row{
  margin-top: 10px;
  padding-left: 48px;
  padding-right: 15px;
}

</style>