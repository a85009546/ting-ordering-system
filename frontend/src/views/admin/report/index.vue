<script setup>
import { reactive, ref, onMounted } from 'vue';
import {
  get1stAndToday,
  past7Day,
  past30Day,
  pastWeek,
  pastMonth,
} from '@/utils/formValidate'
import { 
  getTurnoverStatistics,
  getCustomerStatistics,
  getOrderStatistics,
  getTop,
  exportReport
} from '@/api/report'
import TurnoverStatistics from './components/turnoverStatistics.vue'
import CustomerStatistics from './components/customerStatistics.vue'
import OrderStatistics from './components/orderStatistics.vue'
import Top10Statistics from './components/top10.vue'
import { ElMessage, ElMessageBox } from 'element-plus';


const timeButtons = ['昨日', '近7日', '近30日', '本周', '本月']

const state = reactive({
  flag: 2,
  intervalDate: [],
  turnoverData: {},
  customerData: {},
  orderData: {},
  top10Data: {},
})
// 初始化函數
const init = async (begin, end) => {
    
    getTurnoverStatisticsData(begin, end)
    getCustomerStatisticsData(begin, end)
    getOrderStatisticsData(begin, end)
    getTopData(begin, end)
}
// 獲取營業額數據
const getTurnoverStatisticsData = async (begin, end) => {
  console.log(begin, end)
  const res = await getTurnoverStatistics(begin, end)
  if(res.code){
    const turnoverData = res.data
    state.turnoverData = {
      dateList: turnoverData.dateList.split(','),
      turnoverList: turnoverData.turnoverList.split(',')
    }
  }
}
// 獲取顧客數據
const getCustomerStatisticsData = async (begin, end) => {
  console.log(begin, end)
  const res = await getCustomerStatistics(begin, end)
  if(res.code){
    const customerData = res.data
    state.customerData = {
      dateList: customerData.dateList.split(','),
      newCustomerList: customerData.newCustomerList.split(','),
      totalCustomerList: customerData.totalCustomerList.split(','),
    }
  }
}
// 獲取訂單數據
const getOrderStatisticsData = async (begin, end) => {
  console.log(begin, end)
  const res = await getOrderStatistics(begin, end)
  if(res.code){
    const orderData = res.data
    state.orderData = {
      dateList: orderData.dateList.split(','),
      orderCountList: orderData.orderCountList.split(','),
      validOrderCountList: orderData.validOrderCountList.split(','),
      totalOrderCount: orderData.totalOrderCount,
      validOrderCount: orderData.validOrderCount,
      orderCompletionRate: orderData.orderCompletionRate
    }
  }
}
// 獲取銷量數據
const getTopData = async (begin, end) => {
  console.log(begin, end)
  const res = await getTop(begin, end)
  if(res.code){
    const top10Data = res.data
    state.top10Data = {
      nameList: top10Data.nameList.split(',').reverse(),
      numberList: top10Data.numberList.split(',').reverse()
    }
  }
}
// 選擇日期區間
const getTitleNum = (data) => {
  switch (data) {
    case 0:
      state.intervalDate = get1stAndToday()
      break;
    case 1:
      state.intervalDate = past7Day()
      break;
    case 2:
      state.intervalDate = past30Day()
      break;
    case 3:
      state.intervalDate = pastWeek()
      break;
    case 4:
      state.intervalDate = pastMonth()
      break;
  }
  init(state.intervalDate[0], state.intervalDate[1])
}
// 數據導出邏輯
const exportData = () => {
  ElMessageBox.confirm('確定要導出報表嗎？', '提示', {
    confirmButtonText: '確定',
    cancelButtonText: '取消',
    type: 'warning'
  }).then(async () => {
    try {
      console.log('報表導出')
      const {data, headers} = await exportReport()
      const contentType = headers['content-type'];
      console.log('返回的 MIME 類型:', contentType);
      const url = window.URL.createObjectURL(data)
      const a = document.createElement('a')
      document.body.appendChild(a)
      a.href = url
      a.download = '運營數據統計報表.xlsx' // 指定下載文件的名稱
      a.click()
      window.URL.revokeObjectURL(url)
      document.body.removeChild(a)
    }catch(error){
      console.error('導出失敗', error)
    }
  })
}

onMounted(() => {
  getTitleNum(state.flag)
})
</script>

<template>
  <div class="statistics-page">
    <!-- 上部分 -->
    <div class="top-section">
      <!-- 左側部分 -->
      <div class="left-panel">
        <div class="button-group">
          <el-button v-for="(label, index) in timeButtons" :key="index" @click="getTitleNum(index)">{{ label }}</el-button>
        </div>
        <div class="selected-time">
          已選時間: {{ state.intervalDate[0] }} 至 {{ state.intervalDate[1] }}
        </div>
      </div>
      <!-- end 左側部分 -->
      <!-- 右側部分 -->
      <div class="right-panel">
        
        <el-button type="warning" @click="exportData">
          <img class="export-icon" src="@/assets/images/export.png">
          數據導出
        </el-button>
      </div>
      <!-- end 右側部分 -->
    </div>
    <!-- end 上部分 -->

    <!-- 圖表 -->
    <div class="charts-section">
      <div class="homeMain">
        <!-- 營業額统计 -->
        <div class="chart-wrapper">
          <TurnoverStatistics :turnoverdata="state.turnoverData" />
        </div>
        <!-- 顾客统计 -->
        <div class="chart-wrapper">
          <CustomerStatistics :customerdata="state.customerData" />
        </div>
      </div>
      <div class="homeMain down">
        <div class="chart-wrapper">
          <OrderStatistics :orderdata="state.orderData" />
        </div>
        <div class="chart-wrapper">
          <Top10Statistics :top10data="state.top10Data" />
        </div>
      </div>
    </div>
    <!-- end 圖表 -->
      
  </div>
</template>

<style scoped>
.statistics-page {
  padding: 20px;
  display: flex;
  flex-direction: column;
  gap: 20px;
}
.top-section {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.left-panel {
  margin-left: 60px;
  display: flex;
  gap: 10px;
}
.right-panel {
  margin-right: 100px;
}
.button-group {
  display: flex;
  gap: 0px;
}
.selected-time {
  margin-top: 5px;
  margin-left: 20px;
  font-size: 15px;
}
.export-icon{
  color: #e5e4e4;
  width: 16px;
  height: 16px;
  margin-right:10px;
}
.charts-section {
  padding: 20px;
  margin-right: 10px;
}
.homeMain {
  display: flex; /* 使用 flex 布局 */
  justify-content: space-between; /* 在同一行內平分 */
  gap: 20px; /* 圖表間的間距 */
  margin-bottom: 20px;
}

.chart-wrapper {
  flex: 1; /* 每個圖表平分剩餘空間 */
  max-width: 48%; /* 控制圖表最大寬度為容器的一半（略小於 50% 以留空隙） */
  height: 400px; /* 固定高度，確保一致 */
  background-color: #fff; /* 可選：設置背景顏色 */
  border: 1px solid #e5e4e4; /* 可選：設置邊框 */
  border-radius: 8px; /* 可選：設置圓角 */
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* 可選：設置陰影 */
  padding: 10px; /* 可選：內部留白 */
  width: 100%;

}
</style>