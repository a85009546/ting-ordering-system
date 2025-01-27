<template>
  <div class="container">
    <h2 class="homeTitle">訂單统计</h2>
    <div class="charBox">
      <!-- 訂單比例 -->
      <div class="orderProportion">
          <span>訂單總數 : {{ orderdata.totalOrderCount }}</span>
          <span>有效訂單 : {{ orderdata.validOrderCount }}</span>
          <span>訂單完成率 : {{ (orderdata.orderCompletionRate * 100).toFixed(1) }}%</span>
      </div>
      <!-- end 訂單比例 -->
      <div id="ordermain" style="width: 100%; height: 300px"></div> 
      <ul class="orderListLine order">
        <span class="colorDot" :style="{backgroundColor: totalOrderCountColor}"></span>訂單總數（個）
        <span class="colorDot" :style="{backgroundColor: validOrderCountColor}"></span>有效訂單（個）
      </ul>
    </div>
  </div>
</template>

<script setup>
import { onMounted, watch, ref } from 'vue';
import * as echarts from 'echarts';

// 接收父组件傳入的 props
const props = defineProps({
  orderdata: {
    type: Object,
    required: true,
  }
})
// 提取圖表顏色
const totalOrderCountColor = ref('#FFD000'); // 默認顏色
const validOrderCountColor = ref('#FD7F7F'); // 默認顏色


const initChart = () => {
  const chartDom = document.getElementById('ordermain');
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
        fontWeight: 300,
      },
    },
    grid: {
      top: '5%',
      left: '20',
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
      data: props.orderdata.dateList || [],
    },
    yAxis: [
      {
        type: 'value',
        min: 0,
        interval: 50,
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
        name: '訂單總數',
        type: 'line',
        smooth: false,
        showSymbol: true,
        symbolSize: 8,
        itemStyle: {
          normal: {
            color: '#219d57',
            lineStyle: {
              color: '#219d57',
            },
          },
          emphasis: {
            color: '#fff',
            borderWidth: 5,
            borderColor: '#219d57',
          },
        },
        data: props.orderdata.orderCountList || [],
      },
      {
        name: '有效訂單',
        type: 'line',
        smooth: false,
        showSymbol: true,
        symbolSize: 5,
        itemStyle: {
          normal: {
            color: '#d23914',
            lineStyle: {
              color: '#d23914',
            },
          },
          emphasis: {
            color: '#fff',
            borderWidth: 5,
            borderColor: '#d23914',
          },
        },
        data: props.orderdata.validOrderCountList || [],
      },
    ],
  };

  myChart.setOption(option);
  // 監聽窗口大小變化，重新調整圖表大小
  window.addEventListener('resize', () => {
    myChart.resize()
  })

    // 提取系列顏色並更新
    totalOrderCountColor.value = option.series[0].itemStyle.normal.color;
    validOrderCountColor.value = option.series[1].itemStyle.normal.color;
};

watch(
  () => props.orderdata,
  () => {
    initChart()
  },
  { immediate: true }
)

onMounted(() => {
  initChart()
})

</script>

<style scoped>
.orderProportion{
  margin-top: 20px;
  margin-left: 20px;
  display: flex;
  gap: 20px;
}
.colorDot {
  display: inline-block;
  width: 10px;
  height: 10px;
  border-radius: 50%; /* 使其成為圓形 */
  margin-right: 8px; /* 與文字之間的間距 */
}
.orderListLine.order span {
  display: inline-block;
  width: 10px;
  height: 10px;
  border-radius: 50%;
  margin-right: 8px;
}
</style>