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
import * as echarts from 'echarts';
import { onMounted, ref, watch } from 'vue';

// 接收父組件傳遞的數據
const data = defineProps({
  turnoverdata: {
    type: Object,
    required: true,
  }
})

const chartInstance = ref(null);
// 初始化圖表
const initChart = () => {
  console.log(data.turnoverdata)
  const chartDom = document.getElementById('main');
  if (!chartDom) return;

  if (!chartInstance.value) {
    chartInstance.value = echarts.init(chartDom);
  }

  const option = {
    tooltip: {
      trigger: 'axis',
      formatter: function (params) {
        // 自定義提示框的內容
        let tooltipContent = `<strong>${params[0].name}</strong><br/>`; // 顯示 X 軸的名稱（日期）
        params.forEach(param => {
          tooltipContent += `${param.seriesName}: ${param.value}<br/>`; // 顯示 Y 軸的數值
        });
        return tooltipContent;
      },
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
      data: data.turnoverdata.dateList || [], // 後端傳來的日期數據
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
        symbolSize: 10,
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
        data: data.turnoverdata.turnoverList || [], // 後端傳來的營業額數據
      },
    ],
  };

  chartInstance.value.setOption(option);
};
// 監聽 turnoverdata 變化，重新初始化圖表
watch(
  () => data.turnoverdata,
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
.container {
  padding: 20px;
}
.homeTitle {
  font-size: 20px;
  margin-bottom: 10px;
}
.charBox {
  margin-top: 10px;
}
#main {
  border: 1px solid #e5e4e4;
  border-radius: 8px;
}
.orderListLine {
  margin-top: 10px;
  list-style: none;
  padding: 0;
  font-size: 14px;
  color: #333;
}
</style>
