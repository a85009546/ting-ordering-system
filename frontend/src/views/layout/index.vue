<script setup>
import { ref, onMounted, computed, provide, inject, reactive } from 'vue'
import { getMenuApi } from '@/api/menu'
import { updateStatusApi, queryStatusApi } from '@/api/shop'
import { useRoleStore } from '@/stores/role'
import { useAccountStore } from '@/stores/account'
import { useBalanceStore } from '@/stores/balance'
import { useAvatarStore } from '@/stores/avatar'
import { getCartApi, clearCartApi } from '@/api/shoppingCart'
import { getAddressListApi, setDefaultAddressApi, deleteAddressApi } from '@/api/addressBook'
import { ElMessage } from 'element-plus'


const isOpen = ref(true) // 營業狀態 (true: 營業中, false: 休息中)
const isShopDialogVisible = ref(false) // 控制選框的顯示
const isCartDialogVisible = ref(false) // 控制購物車彈框的顯示
const menuList = ref([])
const activeMenuItem = ref('/meal')
const shoppingCartItems = reactive([]) // 購物車內容
const roleStore = useRoleStore()
const accountStore = useAccountStore()
const balanceStore = useBalanceStore()
const avatarStore = useAvatarStore()

const selectedAddress = ref('尚未選擇地址') // 當前選擇的地址
const isAddressDialogVisible = ref(false) // 控制地址彈窗顯示
const addressList = reactive([]) // 地址列表

// 提供購物車數據和操作方法
provide('shoppingCartItems', shoppingCartItems);
// 提供營業狀態數據和操作方法
provide('isOpen', isOpen);

// 計算總金額
const totalAmount = computed(() =>
  shoppingCartItems.reduce((sum, item) => sum + item.amount * item.number, 0)
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
// 獲取購物車內容
const getCartItems = async () => {
  const result = await getCartApi();
  console.log(result);
  shoppingCartItems.splice(0, shoppingCartItems.length, ...result.data); // 清空原數據並插入新數據
};
// 獲取地址列表
const fetchAddresses = async () => {
  const response = await getAddressListApi()
  addressList.splice(0, addressList.length, ...response.data)
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
// 打開地址彈窗
const openAddressDialog = () => {
  fetchAddresses()
  isAddressDialogVisible.value = true
}
// 設置默認地址
const setDefaultAddress = async (address) => {
  const result = await setDefaultAddressApi(selectedAddress.value.id)
  if(result.code){
    ElMessage.success(`當前地址已設置為: ${address.detail}`)
  }
  
}
// 編輯地址
const editAddress = (address) => {
  console.log('編輯地址:', address)
  // 在這裡可以開啟一個編輯地址的彈框或頁面
}
// 刪除地址
const deleteAddress = async (id) => {
  const response = await deleteAddressApi(id)
  if (response.code === 200) {
    ElMessage.success('地址已刪除')
    fetchAddresses()
  }
}
// 清空購物車
const clearCart = async () => {
  shoppingCartItems.length = 0;
  // 調用後端清空API
  const result = await clearCartApi()
  console.log('清空購物車', result)
  if (result.code) {
    ElMessage.success('購物車已清空')
  }
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
        <!-- Header 左側區域 -->
        <span class="header-left-content">
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

          <!-- 地址顯示框 -->
          <span class="address-display" @click="openAddressDialog">
            <img
                  src="@/assets/images/location.png"
                  alt="Location"
                  class="location-icon-image"
                  @click="openCartDialog"
            />
            <span>{{ selectedAddress }}</span>
          </span>
        </span>
        

        <!-- Header 右側區域 -->
        <span class="header-right-content">
          <!-- 帳號和身份顯示 -->
          <span class="avatar-info">
            <img
              :src="avatarStore.avatar || '@/assets/images/default-avatar.png'"
              alt="User Avatar"
              class="user-avatar"
            />
          </span>
          <span class="account-info">
            帳號：<strong>{{ accountStore.account }}</strong>
          </span>
          &nbsp;&nbsp; | &nbsp;&nbsp;
          <span class="role-info">
            身份：<strong>{{ roleStore.role === 1 ? '顧客' : roleStore.role === 2 ? '員工' : '管理員' }}</strong>
          </span>
          &nbsp;&nbsp; | &nbsp;&nbsp;
          <span v-if="roleStore.role === 3 ? true : false" class="balance-info">
            餘額：<strong>{{ balanceStore.balance }}</strong>
          </span>
          &nbsp;&nbsp; | &nbsp;&nbsp;
          <!-- 購物車圖標 -->
          <template v-if="roleStore.role <= 3">
            <el-badge :value="shoppingCartItems.length" class="cart-icon" :offset="[2, 10]">
              <img
                src="@/assets/images/shopping-cart.png"
                alt="Shopping Cart"
                class="cart-icon-image"
                @click="openCartDialog"
              />
            </el-badge>
          </template>
          |  &nbsp;&nbsp;
          <a href="">
            <el-icon><EditPen /></el-icon> 修改密碼 
          </a>
          &nbsp;&nbsp; |  &nbsp;&nbsp;
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
        <!-- 清空購物車按鈕 -->
        <div class="clear-cart" @click="clearCart">
          <el-icon class="clear-cart-icon">
            <Delete />
          </el-icon>
          <span class="clear-cart-text">清空</span>
        </div>
        
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
          <el-button v-if="isOpen" type="primary" @click="proceedToCheckout">去結算</el-button>
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

    <!-- 地址選擇彈窗 -->
    <el-dialog v-model="isAddressDialogVisible" title="地址" width="600px">
      <div v-for="address in addressList" :key="address.id" class="address-card">
        <el-icon :class="address.isDefault ? 'default-location-icon' : 'location-icon'">
          <Location />
        </el-icon>
        <div class="address-content">
          <p class="address-detail">{{ address.detail }}</p>
          <p class="address-region">{{ address.city }} · {{ address.district }}</p>
        </div>
        <div class="address-actions">
          <el-button type="primary" size="small" @click="editAddress(address)">編輯</el-button>
          <el-button type="danger" size="small" @click="deleteAddress(address.id)">刪除</el-button>
        </div>
      </div>
    </el-dialog>
  </div>
</template>

<style scoped>
.header {
  background-image: linear-gradient(to right, #00547d, #007fa4, #00aaa0, #00d072, #a8eb12);
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0 20px;
  height: 60px;
}
.header-left-content {
  display: flex; /* 根據需求，控制左側內容的排列 */
  align-items: center;
}
.header-right-content {
  display: flex; /* 右側按鈕或圖標的排列 */
  align-items: center;
  gap: 0; /* 元素間距 */
}
.title {
  color: white;
  font-size: 40px;
  font-family: 楷體;
  line-height: 60px;
  font-weight: bolder;
}
.status-button {
  margin-top: 15px;
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
.user-avatar {
  width: 40px; 
  height: 40px; 
  border-radius: 50%; /* 使圖片成為圓形 */
  margin-right: 12px; 
  border: 2px solid white; /* 添加白色邊框 */
  object-fit: cover; /* 確保圖片不會變形 */
  cursor: pointer; /* 鼠標懸停時顯示指針 */
}
.cart-icon {
font-size: 20px;
cursor: pointer;
margin-left: 5px;
margin-top: 12px;
margin-right: 28px;
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
  width: 24px;
  height: 24px;
  cursor: pointer;
}
/* 清空購物車圖標 */
.clear-cart {
  display: flex;
  align-items: center;
  justify-content: flex-end; /* 向右對齊 */
  cursor: pointer;
  color: #f56c6c; /* 紅色 */
  margin-bottom: 10px;
  user-select: none; /* 禁止選中文字 */
}
.clear-cart-icon {
  font-size: 20px;
}
.clear-cart:hover {
  color: #ff7875; /* 淺紅色 */
}
.clear-cart-text {
  margin-left: 5px;
  font-size: 16px;
}
.account-info,
.role-info,
.balance-info {
  color: white;
  margin-right: 10px;
  font-weight: bold;
}
/* Location圖標 */
.location-icon-image {
  width: 20px; 
  height: 20px;
  margin-right: 5px;
  cursor: pointer;
}
.address-display {
  display: flex;
  align-items: center;
  cursor: pointer;
  color: #fff;
  margin-left: 20px;
  font-weight: bold;
}
.address-display:hover {
  text-decoration: underline;
}

</style>
