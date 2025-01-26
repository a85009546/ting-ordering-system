<template>
  <div class="container">
    <h2 class="homeTitle">顧客統計</h2>
    <div class="charBox">
      <div id="customermain" style="width: 100%; height: 320px"></div>
      <ul class="orderListLine customer">
          <span class="colorDot" :style="{backgroundColor: customerTotalColor}"></span>用戶總量（個）
          <span class="colorDot" :style="{backgroundColor: newCustomerColor}"></span>新增用戶（個)
      </ul>
    </div>
  </div>
</template>

<script setup>
import { ref, watch, onMounted, onUnmounted } from 'vue'
import * as echarts from 'echarts'

// 接收父组件傳入的 props
const props = defineProps({
  customerdata: {
    type: Object,
    required: true,
  }
})

// 引用 ECharts 實例
const chartRef = ref(null);

// 提取圖表顏色
const customerTotalColor = ref('#FFD000'); // 默認顏色
const newCustomerColor = ref('#FD7F7F'); // 默認顏色
// 初始化图表
const initChart = () => {
  const chartDom = document.getElementById('customermain')
  if (!chartDom || !props.customerdata) return

  const myChart = echarts.init(chartDom)

  const option = {
    tooltip: {
      trigger: 'axis',
      backgroundColor: '#fff',
      borderRadius: 2,
      textStyle: {
        color: '#333',
        fontSize: 12,
        fontWeight: 300
      }
    },
    grid: {
      top: '5%',
      left: '20',
      right: '50',
      bottom: '12%',
      containLabel: true
    },
    xAxis: {
      type: 'category',
      boundaryGap: false,
      axisLabel: {
        textStyle: {
          color: '#666',
          fontSize: '12px'
        }
      },
      axisLine: {
        lineStyle: {
          color: '#E5E4E4',
          width: 1
        }
      },
      data: props.customerdata.dateList || []
    },
    yAxis: [
      {
        type: 'value',
        min: 0,
        axisLabel: {
          textStyle: {
            color: '#666',
            fontSize: '12px'
          }
        }
      }
    ],
    series: [
      {
        name: '用戶總量',
        type: 'line',
        smooth: false,
        showSymbol: true,
        symbolSize: 10,
        itemStyle: {
          normal: {
            color: '#1f8ba2',
            lineStyle: {
              color: '#1cb791'
            }
          },
          emphasis: {
            color: '#fff',
            borderWidth: 5,
            borderColor: '#1e7b9f'
          }
        },
        data: props.customerdata.totalCustomerList || []
      },
      {
        name: '新增用戶',
        type: 'line',
        smooth: false,
        showSymbol: false,
        symbolSize: 10,
        itemStyle: {
          normal: {
            color: '#FD7F7F',
            lineStyle: {
              color: '#FD7F7F'
            }
          },
          emphasis: {
            color: '#fff',
            borderWidth: 5,
            borderColor: '#FD7F7F'
          }
        },
        data: props.customerdata.newCustomerList || []
      }
    ]
  }

  myChart.setOption(option)

  // 提取系列顏色並更新
  customerTotalColor.value = option.series[0].itemStyle.normal.color;
  newCustomerColor.value = option.series[1].itemStyle.normal.color;

  chartRef.value = myChart
}

// 監聽 props.customerdata 的变化
watch(
  () => props.customerdata,
  () => {
    initChart();
  },
  { immediate: true }
);

// 鉤子
onMounted(() => {
  initChart();
})

// 銷毀元件時清理圖表
onUnmounted(() => {
  if (chartRef.value) {
    chartRef.value.dispose();
  }
})
</script>

<style scoped>
.colorDot {
  display: inline-block;
  width: 10px;
  height: 10px;
  border-radius: 50%; /* 使其成為圓形 */
  margin-right: 8px; /* 與文字之間的間距 */
}
.orderListLine.cutomer span {
  display: inline-block;
  width: 10px;
  height: 10px;
  border-radius: 50%;
  margin-right: 8px;
}

</style>
