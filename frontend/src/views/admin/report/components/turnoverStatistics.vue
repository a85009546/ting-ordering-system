<template>
  <div class="container">
    <h2 class="homeTitle">營業額統計</h2>
    <div class="charBox">
      <div id="main" style="width: 100%; height: 320px"></div>
      <ul class="orderListLine turnover">
        <li>營業額(元)</li>
      </ul>

    </div>
  </div>
</template>

<script setup>
import { onMounted, ref, watch } from 'vue'
import * as echarts from 'echarts'

// 接收父組件傳遞的數據
const props = defineProps({
  turnoverdata: {
    type: Object,
    required: true,
  }
})

const chartRef = ref(null);
// 初始化圖表
const initChart = () => {
  console.log(props.turnoverdata)
  const chartDom = document.getElementById('main');
  if (!chartDom) return;

  const myChart = echarts.init(chartDom);

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
      left: '10',
      right: '50',
      bottom: '12%',
      containLabel: true,
    },
    xAxis: {
      type: 'category',
      boundaryGap: false,
      axisLabel: {
        textStyle: {
          color: '#666',
          fontSize: '12px',
        },
      },
      axisLine: {
        lineStyle: {
          color: '#E5E4E4',
          width: 1,
        },
      },
      data: props.turnoverdata.dateList || [], // 後端傳來的日期數據
    },
    yAxis: [
      {
        type: 'value',
        min: 0,
        axisLabel: {
          textStyle: {
            color: '#666',
            fontSize: '12px',
          },
        },
      },
    ],
    series: [
      {
        name: '營業額',
        type: 'line',
        smooth: false,
        showSymbol: true,
        symbolSize: 5,
        itemStyle: {
          normal: {
            color: '#F29C1B',
            lineStyle: {
              color: '#FFD000',
            },
          },
          emphasis: {
            color: '#fff',
            borderWidth: 5,
            borderColor: '#FFC100',
          },
        },
        data: props.turnoverdata.turnoverList || [], // 後端傳來的營業額數據
      },
    ],
  };

  myChart.setOption(option)
  // 監聽窗口大小變化，重新調整圖表大小
  window.addEventListener('resize', () => {
    myChart.resize()
  })
};
// 監聽 turnoverdata 變化，重新初始化圖表
watch(
  () => props.turnoverdata,
  () => {
    initChart();
  },
  { deep: true }
);

// 在組件掛載時初始化圖表
onMounted(() => {
  initChart()
})
</script>

<style scoped>
.charBox {
  margin-top: 10px;
}
.orderListLine{
  margin-bottom: 20px;
}

</style>
