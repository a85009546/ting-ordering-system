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
  getTurnoverStatistics
} from '@/api/report'
import TurnoverStatistics from './components/turnoverStatistics.vue'

const timeButtons = ['昨日', '近7日', '近30日', '本周', '本月']
const selectedTimeRange = ref({ begin: '', end: ''})

const state = reactive({
  flag: 2,
  intervalDate: [],
  turnoverData: {}
})
const init = async (begin, end) => {
    
    getTurnoverStatisticsData(begin, end)
    // getUserStatisticsData(begin, end)
    // getOrderStatisticsData(begin, end)
    // getTopData(begin, end)
}
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
  console.log(state.turnoverData)
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
// 更新時間範圍邏輯
const handleTimeSelect = (index) => {
  console.log(`Selected time: ${index}`)
}
// 數據導出邏輯
const exportData = () => {
  console.log('數據導出');
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
        <el-button type="primary" @click="exportData">數據導出</el-button>
      </div>
      <!-- end 右側部分 -->
    </div>
    <!-- end 上部分 -->

    <!-- 圖表 -->
    <div class="charts-section">
      <div class="charts-top">
        <TurnoverStatistics :turnoverdata="state.turnoverData" />
        <div class="chart-container" id="chart2"></div>
      </div>
      <div class="charts-bottom">
        <div class="chart-container" id="chart3"></div>
        <div class="chart-container" id="chart4"></div>
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
  display: flex;
  gap: 10px;
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

</style>