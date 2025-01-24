<script set>
import { ref } from 'vue'


// 訂單狀態列表
const orderStatusList = computed(() => [
  { label: "全部訂單", value: "", count: 0 },
  { label: "待接單", value: "2", count: statisticsData.value.toBeConfirmed },
  { label: "待派送", value: "3", count: statisticsData.value.confirmed },
  { label: "派送中", value: "4", count: statisticsData.value.deliveryInProgress },
  { label: "已完成", value: "5", count: 0 },
  { label: "已取消", value: "6", count: 0 }
])
</script>

<template>
  <h1>歷史訂單</h1>
  <div class="history-order">
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
  </div>
</template>

<style scoped>
</style>