<script setup>
import { ref, onMounted, reactive, computed, inject } from 'vue'
import { orderHistoryPageApi, orderDetail4CustomerApi,
    orderPayApi, orderRepetitionApi, orderReminderApi } from '@/api/order'
import { ElMessage, ElMessageBox } from 'element-plus'
import { getCartApi } from '@/api/shoppingCart'
import { useBalanceStore } from '@/stores/balance'


const balanceStore = useBalanceStore()
const amount = ref(null)
const selectedStatus = ref('') // 當前被選中的訂單狀態
const orderList = reactive([]) // 訂單列表
const selectedOrderId = ref(null) // 當前被選中的訂單的id
const orderDetail = ref({}) // 訂單詳情
const isDetaildialogVisible = ref(false) // 控制訂單詳情彈窗的顯示
const isPayDialogVisible = ref(false) // 控制支付確認彈窗的顯示
const payOrderId = ref(null) // 支付的訂單id
const shoppingCartItems = inject('shoppingCartItems')
// 分頁相關
const currentPage = ref(1) 
const pageSize = ref(5) 
const background = ref(true)
const total = ref(0)
// 訂單狀態列表
const orderStatusList = ref([
  { label: "全部訂單", value: ""},
  { label: "待付款", value: "1"},
  { label: "已取消", value: "6"}
])
// 餘額計算
const newBalance = computed(() => {
  return balanceStore.balance - amount.value
})
// 鉤子
onMounted(() => {
  search()
})
// 查詢訂單列表
const search = async () => {
  console.log(`查詢訂單列表: status:${selectedStatus.value}, currentPage:${currentPage.value}, pageSize:${pageSize.value}`)
  const res = await orderHistoryPageApi(selectedStatus.value, currentPage.value, pageSize.value)
  if(res.code){
    orderList.splice(0, orderList.length, ...res.data.records)
    total.value = res.data.total
  }
  console.log(orderList)
}
// 獲取購物車內容
const getCartItems = async () => {
  const result = await getCartApi();
  console.log(result);
  shoppingCartItems.splice(0, shoppingCartItems.length, ...result.data); // 清空原數據並插入新數據
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
// 切換訂單狀態
const setStatus = (status) => {
  selectedStatus.value = status
  search()
}
// 打開查看訂單詳情彈窗
const openDetailDialog = async (id, status) => {
  isDetaildialogVisible.value = true
  selectedOrderId.value = id
  selectedStatus.value = status
  const res = await orderDetail4CustomerApi(id)
  if(res.code){
    orderDetail.value = res.data
    console.log(orderDetail.value)
  }
}
// 打開確認支付彈窗
const openPayDialog = (id, time, price) => {
  isPayDialogVisible.value = true
  payOrderId.value = id
  amount.value = price
}
// 立即支付按鈕操作
const payNow = async () => {
  // 調用支付接口
  console.log('payOrderId:' + payOrderId.value)
  const res = await orderPayApi(payOrderId.value)
  if(res.code){
    ElMessage.success('支付成功！')
    // 更新餘額顯示
    balanceStore.setBalance(newBalance.value)
    // 關閉支付彈窗
    isPayDialogVisible.value = false
    // 刷新頁面
    search()
  }else{
    ElMessage.error(result.msg)
  }
}
// 再來一單
const repetition = (id) => {
  ElMessageBox.confirm('您確定要再來一單嗎？', '提示', {
    confirmButtonText: '確定', cancelButtonText: '取消', type: 'warning'}
  ).then(async () => { // 確定
    const res = await orderRepetitionApi(id)
    if(res.code){
      ElMessage.success('已成功再來一單!')
      // 要更新購物車
      getCartItems()
      // 刷新訂單列表
      search()
    }else{
      ElMessage.error(res.msg)
    }
  })
}
// 催單
const expediting = (id) => {
  ElMessageBox.confirm('您確定要催單嗎？', '提示', {
    confirmButtonText: '確定', cancelButtonText: '取消', type: 'warning'}
  ).then(async () => {
    const res = await orderReminderApi(id)
    if(res.code){
      ElMessage.success('已向店家催單!')
    }
  })
}
</script>

<template>
  <h1>歷史訂單</h1>
  <div class="history-order">
    <!-- 訂單狀態欄 -->
    <div class="order-status-bar">
      <el-button 
        v-for="status in orderStatusList" :key="status.value"
        class="status-button"   
        :type="selectedStatus === status.value ? 'primary' : 'default'"
        size="large"
        @click="setStatus(status.value)"
      >
        {{ status.label }}
      </el-button>
    </div>

    <!-- 訂單表格 -->
    <el-table
      :data="orderList"
      border
      style="width: 100%; margin-top: 20px"
      :header-cell-style="{ backgroundColor: '#f5f7fa' }"
    >
      <el-table-column prop="orderTime" label="下單時間"  align="center"/>
      <el-table-column prop="status" label="訂單狀態" align="center">
        <template #default="scope">
          <span v-if="scope.row.status === 1">待付款</span>
          <span v-else-if="scope.row.status === 2">待接單</span>
          <span v-else-if="scope.row.status === 3">待派送</span>
          <span v-else-if="scope.row.status === 4">派送中</span>
          <span v-else-if="scope.row.status === 5">已完成</span>
          <span v-else-if="scope.row.status === 6">已取消</span>
        </template>
      </el-table-column>
      <el-table-column prop="amount" label="訂單金額" align="center"/>
      <el-table-column 
        prop="orderDetailList" 
        label="訂單明細" 
        width="450" 
        align="left"
        header-align="center"
      >
        <template #default="scope">
          <div class="order-detail-list">
            <div
              class="order-detail-item"
              v-for="orderDetail in scope.row.orderDetailList"
              :key="orderDetail.id"
            >
              <img 
                :src="orderDetail.image" 
                alt="餐點圖片" 
                class="order-detail-image"
              />
              <div class="order-detail-name">{{ orderDetail.name }}</div>
            </div>
          </div>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" >
        <template #default="scope">
              <el-button
                v-if="scope.row.status === 1"
                size="small" 
                type="success"
                @click="openPayDialog(scope.row.id, scope.row.orderTime, scope.row.amount)"
              >去支付</el-button>
              <el-button
                v-else-if="scope.row.status === 2"
                size="small" 
                type="danger"
                @click="expediting(scope.row.id)"
              >催單</el-button>
              <el-button
                size="small" 
                type="warning"
                @click="repetition(scope.row.id)"
              >再來一單</el-button>  
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

    <!-- 訂單明細彈窗 -->
    <el-dialog 
      v-model="isDetaildialogVisible"
      title="訂單詳細資訊" 
      :close-on-click-modal="true"
      width="600px"
    >
      <div>
        <hr />
        <!-- 第一部分: 餐點 -->
        <el-table 
          :data="orderDetail.orderDetailList" 
          class="dialog-order-detail-table"
          stripe 
          style="width: 520px">
          <el-table-column width="150" align="left">
            <template #default="scope">
              <img 
                :src="scope.row.image" 
                alt="餐點圖片" 
                class="dialog-order-detail-image"
              />
            </template>
          </el-table-column>
          <el-table-column width="250" align="left">
            <template #default="scope">
              <div class="dialog-order-detail-name">
                <p>{{scope.row.name}}</p>
                <p>{{ scope.row.mealFlavor }}</p>
                <p> x {{ scope.row.number }}</p>
              </div>
              
            </template>
          </el-table-column>
          <el-table-column prop="amount" width="100" align="right">
            <template #default="scope">
              <div class="dialog-order-detail-price">         
                <p>NT &nbsp;{{scope.row.amount}}</p>
              </div>
            </template>
          </el-table-column>
        </el-table>
        <br>
        <hr/>
        <!-- 外送費和合計 -->
        <el-row class="dialog-order-count-row" gutter="150px">
          <el-col :span="10" style="text-align: left;">外送費</el-col>
          <el-col :span="10" style="text-align: right;">NT &nbsp;30</el-col>
        </el-row>
        <el-row class="dialog-order-count-row" gutter="150px">
          <el-col :span="10" style="text-align: left;">合計</el-col>
          <el-col :span="10" style="text-align: right;">NT &nbsp;{{orderDetail.amount}}</el-col>
        </el-row>
        <br>
        <hr/>
        <!-- 配送時間 與 配送地址 -->
        <div class="row">
          <p><strong>配送時間：</strong>{{ orderDetail.deliveryStatus === 1 ? '立即配送' : '選擇其他時間' }}</p>
          <p><strong>地址：</strong>{{ orderDetail.address }}</p>
        </div>
        <hr/>
        <!-- 訂單編號與下單時間 -->
        <div class="row">
          <p><strong>訂單編號：</strong>{{ orderDetail.number }}</p>
          <p><strong>下單時間：</strong>{{ orderDetail.orderTime }}</p>
        </div>
        <!-- 備註 -->
        <div class="row">
          <p><strong>備註：</strong>{{ orderDetail.remark || "無" }}</p>
          <p></p>
        </div>
      </div>
      <div class="dialog-back-button" >
        <el-button @click="isDetaildialogVisible = false">返回</el-button>
      </div>
    </el-dialog>

    <!-- 支付確認彈窗 -->
    <el-dialog
      v-model="isPayDialogVisible"
      title="要立即支付費用嗎?" 
      :close-on-click-modal="true"
      width="400px">
      <!-- 剩餘支付時間 -->
      <!-- <p style="margin-bottom: 20px; color: rgb(127, 67, 74); font-weight: bold;">
        剩餘支付時間：{{ remainingTimeText }}
      </p> -->

      <span>扣除費用 {{ amount }} 元，餘額為 {{ newBalance }} 元</span>

      <template #footer>
        <el-button @click="isPayDialogVisible = false">稍後支付</el-button>
        <el-button type="primary" @click="payNow">立即支付</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<style scoped>
.history-order {
  margin-top: 20px;
  padding: 20px;
}
/* 訂單狀態欄 */
.order-status-bar {
  display: flex;
  gap: 10px; /* 控制按鈕之間的間距 */
  margin-bottom: 20px;
}
.status-button {
  border-radius: 5px; 
}
/* 表格裡的訂單明細 */
.order-detail-list {
  display: flex;
  flex-wrap: wrap; /* 如果有多個餐點，讓它們換行排列 */
  gap: 0px; /* 餐點之間的間距 */
  justify-content: left; /* 內容居中 */
}
.order-detail-item {
  display: flex;
  flex-direction: column; /* 讓圖片和名稱垂直排列 */
  align-items: center; /* 水平居中 */
  margin: 0; /* 清除外邊距 */
  padding: 4px; /* 控制內邊距 */
  border-radius: 4px; /* 可選：圓角效果 */
  text-align: center;
  width: 85px; /* 每個餐點的寬度 */
}
.order-detail-image {
  width: 40px; /* 圖片的寬度 */
  height: 40px; /* 圖片的高度 */
  object-fit: cover; /* 圖片適應容器 */
  border-radius: 5px; /* 圖片圓角 */
}
.order-detail-name {
  margin-top: 5px; /* 圖片和名稱之間的間距 */
  font-size: 14px; /* 名稱字體大小 */
  white-space: nowrap; /* 可選：防止文字換行 */
  overflow: hidden; /* 可選：超出部分隱藏 */
  text-overflow: ellipsis; /* 可選：加省略號 */
  color: #333; /* 名稱顏色 */
}
/* 分頁條 */
.pagination{
  margin-top: 20px;
}
/* 訂單詳情彈窗 */
.dialog-order-detail-table{
  margin-left: 20px
}
.dialog-order-detail-image{
  width: 40px;
  height: 40px;
  object-fit: cover; /* 圖片適應容器 */
  border-radius: 5px; /* 圖片圓角 */
}
.dialog-order-detail-name{
  text-align: left; /* 確保文字靠左對齊 */
  display: flex;
  flex-direction: column; /* 垂直排列每一行 */
  gap: 4px; /* 行間距 */
}
.dialog-order-detail-price{
  text-align: right; 
}
.dialog-order-count-row{
  margin-top: 10px;
  padding-left: 40px;
  padding-right: 0px;
}
.dialog-footer{
  text-align: center;
}

.row {
  margin-top: 20px;
  margin-bottom: 20px;
  padding: 0px 40px;
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
.row p:last-child {
  margin-left: 80px;
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
.dialog-back-button{
  margin-top: 50px;
  margin-right: 20px;
  text-align: right;
}

</style>