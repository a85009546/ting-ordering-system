<template>
  <div class="container top10">
    <h2 class="homeTitle">销量排名TOP10</h2>
    <div class="charBox">
      <div id="top" style="width: 100%; height: 380px"></div>
    </div>
  </div>
</template>

<script setup>
import { onMounted, watch, ref } from 'vue'
import * as echarts from 'echarts'

// 接收外部傳入的 top10data 屬性
const props = defineProps({
  top10data: {
    type: Object,
    required: true
  }
})


const initChart = () => {
  const chartDom = document.getElementById('top')
  if(!chartDom) return;
  const myChart = echarts.init(chartDom)
  const option = {
    tooltip: {
      trigger: 'axis',
      backgroundColor: '#fff',
      borderRadius: 2,
      textStyle: {
        color: '#333',
        fontSize: 12,
        fontWeight: 300,
      },
    },
    grid: {
      top: '-10px',
      left: '0',
      right: '0',
      bottom: '0',
      containLabel: true,
    },
    xAxis: {
      show: false,
    },
    yAxis: {
      axisLine: { show: false },
      axisTick: { show: false, alignWithLabel: true },
      type: 'category',
      axisLabel: {
        textStyle: {
          color: '#666',
          fontSize: '12px',
        },
      },
      data: props.top10data.nameList || []
    },
    series: [
      {
        data: props.top10data.numberList || [],
        type: 'bar',
        showBackground: true,
        backgroundStyle: {
          color: '#F3F4F7',
        },
        barWidth: 20,
        barGap: '80%',
        barCategoryGap: '80%',
        itemStyle: {
          emphasis: {
            barBorderRadius: 30,
          },
          normal: {
            barBorderRadius: [0, 10, 10, 0],
            color: new echarts.graphic.LinearGradient(
              1,
              0,
              0,
              0,
              [
                { offset: 0, color: '#FFBD00' },
                { offset: 1, color: '#FFD000' },
              ]
            ),
            label: {
              show: true,
              formatter: '{@score}',
              color: '#333',
              position: ['8', '5'],
            },
          },
        },
      },
    ],
  }
  myChart.setOption(option)

  // 監聽窗口大小變化，重新調整圖表大小
  window.addEventListener('resize', () => {
    myChart.resize()
  })
}

onMounted(() => {
  watch(() => props.top10data, () => {
      initChart()
  })
  initChart()
})
</script>

<style scoped>
.charBox{
  margin-top: 10px;
  width: 100%;
  height: 100%;
}
</style>