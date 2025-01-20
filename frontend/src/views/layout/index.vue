<script setup>
import { ref, onMounted, computed } from 'vue'
import { getMenuApi } from '@/api/menu'
import { updateStatusApi, queryStatusApi } from '@/api/shop'
import { useRoleStore } from '@/stores/role'
import { getCartApi } from '@/api/shoppingCart'


const isOpen = ref(true) // 營業狀態 (true: 營業中, false: 休息中)
const isShopDialogVisible = ref(false) // 控制選框的顯示
const isCartDialogVisible = ref(false) // 控制購物車彈框的顯示
const menuList = ref([])
const activeMenuItem = ref('/meal')
const shoppingCartItems = ref([]) // 購物車內容
const roleStore = useRoleStore()

// 計算總金額
const totalAmount = computed(() =>
  shoppingCartItems.value.reduce((sum, item) => sum + item.amount * item.number, 0)
)
// 鉤子
onMounted(async () => {
  getMenu() // 獲取選單數據
  getShopStatus() // 獲取營業狀態
  getCartItems() // 獲取購物車內容
})
// 獲得選單列表數據
const getMenu = async () => {
  const response = await getMenuApi()
  menuList.value = response.data
}
// 獲取營業狀態
const getShopStatus = async () => {
  const statusResponse = await queryStatusApi()
  isOpen.value = statusResponse.data
}
// 獲取購物車內容 (假設有對應的 API)
const getCartItems = async () => {
  const result = await getCartApi()
  console.log(result)
  shoppingCartItems.value = result.data
}
// 打開營業狀態彈框
const openStatusDialog = () => {
  if (roleStore.role >= 2) {
    isShopDialogVisible.value = true
  }
}
// 提交更新營業狀態
const confirmStatusChange = async () => {
  isShopDialogVisible.value = false // 關閉選框
  const response = await updateStatusApi(Number(isOpen.value))
  console.log(`營業狀態已更新: ${isOpen.value ? '營業中' : '休息中'}`)
}
// 打開購物車彈框
const openCartDialog = () => {
  console.log("購物車", {shoppingCartItems})
  isCartDialogVisible.value = true
}
// 去結算邏輯
const proceedToCheckout = () => {
  console.log('去結算:', shoppingCartItems.value)
  isCartDialogVisible.value = false
}
</script>

<template>
  <div class="common-layout">
    <el-container>
      <!-- Header 區域 -->
      <el-header class="header">
        <span class="title">Ting 點餐系統</span>

        <!-- 營業狀態按鈕 -->
        <el-button
          :type="isOpen ? 'success' : 'info'"
          :plain="!isOpen"
          :disabled="roleStore.role < 2"
          class="status-button"
          @click="openStatusDialog"
        >
          {{ isOpen ? '營業中' : '休息中' }}
        </el-button>

        <!-- Header 右側區域 -->
        <span class="right_tool">
          <!-- 購物車圖標 -->
          <template v-if="roleStore.role === 3">
            <el-badge :value="shoppingCartItems.length" class="cart-icon" :offset="[2, 10]">
              <img
                src="@/assets/images/shopping-cart.png"
                alt="Shopping Cart"
                class="cart-icon-image"
                @click="openCartDialog"
              />
            </el-badge>
          </template>
          <a href="">
            <el-icon><EditPen /></el-icon> 修改密碼 &nbsp;&nbsp;&nbsp; |  &nbsp;&nbsp;&nbsp;
          </a>
          <a href="">
            <el-icon><SwitchButton /></el-icon> 退出登入
          </a>
        </span>
      </el-header>
      
      <el-container>
        <!-- 左側選單 -->
        <el-aside width="200px" class="aside">
          <!-- 左側選單欄 -->
          <el-menu v-if="menuList.length > 0" router="true" :default-active="activeMenuItem">

            <el-menu-item
              v-for="menu in menuList"
              :key="menu.path"
              :index="menu.path"
              @click="navigate(menu.path)"
            >
              <!-- <el-icon :name="menu.icon"/> -->
              {{ menu.name }}
            </el-menu-item>

          </el-menu>
        </el-aside>
        <!-- 右側主區域 -->
        <el-main>
          <router-view></router-view>
        </el-main>
      </el-container>
    </el-container>

    <!-- 購物車彈框 -->
    <el-dialog
      v-model="isCartDialogVisible"
      title="購物車"
      width="500px"
    >
      <div v-if="shoppingCartItems.length > 0">
        <div v-for="item in shoppingCartItems" :key="item.id" class="cart-item">
          <img :src="item.image" alt="meal image" class="cart-item-image" />
          <div class="cart-item-details">
            <p class="cart-item-name">{{ item.name }}</p>
            <p class="cart-item-price">單價：{{ item.amount }} 元</p>
            <p class="cart-item-quantity">數量：{{ item.number }}</p>
          </div>
        </div>
        <div class="cart-footer">
          <span>總金額：{{ totalAmount }} 元</span>
          <el-button type="primary" @click="proceedToCheckout">去結算</el-button>
        </div>
      </div>
      <div v-else>
        <p>購物車目前是空的。</p>
      </div>
    </el-dialog>

    <!-- 營業狀態彈框 -->
    <el-dialog
      v-model="isShopDialogVisible"
      title="切換營業狀態"
      width="500px"
    >
      <div class="status-cards">
        <!-- 營業中 -->
        <el-card
          :class="{'selected-card': isOpen, 'unselected-card': !isOpen}"
          class="status-card"
          @click="isOpen = true"
        >
          <strong>營業中</strong>
          <br>
          <p>顧客可以點餐，店家處於正常營業狀態。</p>
        </el-card>
        
        <!-- 休息中 -->
        <el-card
          :class="{'selected-card': !isOpen, 'unselected-card': isOpen}"
          class="status-card"
          @click="isOpen = false"
        >
          <strong>休息中</strong>
          <br>
          <p>店家處於休息狀態，顧客目前無法點餐。</p>
        </el-card>
      </div>
      
      <div style="text-align: right; margin-top: 20px;">
        <el-button @click="isShopDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="confirmStatusChange">確認</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<style scoped>
  .header {
    background-image: linear-gradient(to right, #00547d, #007fa4, #00aaa0, #00d072, #a8eb12);
  }
  .title {
    color: white;
    font-size: 40px;
    font-family: 楷体;
    line-height: 60px;
    font-weight: bolder;
  }
  .right_tool{
    float: right;
    line-height: 60px;
  }
  .status-button {
  margin-left: 50px;
  margin-bottom: 20px;
  font-weight: bold;
}
.status-cards {
  display: flex;
  justify-content: space-between;
  gap: 20px;
  margin-top: 20px;
}
.status-card:hover {
  transform: scale(1.05);
}
.selected-card {
  border-color: #67c23a; /* 綠色邊框，表示選中 */
  background-color: #f0f9eb; /* 綠色背景 */
}
.unselected-card {
  border-color: #d9d9d9; /* 灰色邊框，表示未選中 */
  background-color: #ffffff; /* 白色背景 */
}
  a {
    color: white;
    text-decoration: none;
  }
  .aside {
    width: 220px;
    border-right: 1px solid #ccc;
    height: 730px;
  }
  /*  */
  .cart-icon {
  font-size: 20px;
  cursor: pointer;
  margin-top: 12px;
  margin-right: 40px;
  }
  .cart-item {
  display: flex;
  align-items: center;
  margin-bottom: 15px;
}
.cart-item-image {
  width: 80px;
  height: 80px;
  border-radius: 8px;
  margin-right: 10px;
}
.cart-item-details {
  flex: 1;
}
.cart-item-name {
  font-weight: bold;
}
.cart-footer {
  display: flex;
  justify-content: space-between;
  margin-top: 20px;
}
/* 購物車圖標 */
.cart-icon-image {
  width: 24px; /* 根據需要調整圖標大小 */
  height: 24px;
  cursor: pointer;
}
</style>
