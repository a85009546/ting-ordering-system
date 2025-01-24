<script set>

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