<script setup>
import { ref, onMounted, computed, provide, inject, reactive, watch, onBeforeUnmount} from 'vue'
import { getMenuApi } from '@/api/menu'
import { updateStatusApi, queryStatusApi } from '@/api/shop'
import { useRoleStore } from '@/stores/role'
import { useAccountStore } from '@/stores/account'
import { useBalanceStore } from '@/stores/balance'
import { useAvatarStore } from '@/stores/avatar'
import { getCartApi, clearCartApi } from '@/api/shoppingCart'
import { getAddressListApi, setDefaultAddressApi, deleteAddressApi, getAddressByIdApi, addAddressApi, updateAddressApi } from '@/api/addressBook'
import { ElMessage, ElMessageBox, ElNotification } from 'element-plus'
import defaultIcon from '@/assets/images/default-location-icon.png';
import locationIcon from '@/assets/images/location-icon.png';
import defaultAvatarIcon from '@/assets/images/default-avatar.png'
import remind from '@/assets/sounds/remind.mp3'
import expediting from '@/assets/sounds/expediting.mp3'
import { useRouter } from 'vue-router'
import { updateUserApi, logoutApi } from '@/api/user'
import { useUserIdStore } from '@/stores/userId'
import { useTokenStore } from '@/stores/token'

const router = useRouter()
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
const userIdStore = useUserIdStore()
const tokenStore = useTokenStore()

const defaultAddress = ref(
  {cityName:'', destrictName:'', detail:''}
)
const selectedAddress = ref('尚未選擇地址') // 當前選擇的地址
const isAddressDialogVisible = ref(false) // 控制地址彈窗顯示
const isEditAddressDialogVisible = ref(false)
const isAvatarDialogVisible = ref(false) // 控制頭像彈窗顯示
const addressDialogTitle = ref('新增地址')
const addressList = reactive([]) // 地址列表
const AddressFormRef = ref() // 地址表單物件
const remindSound = new Audio(remind) // 提醒音效
const expeditingSound = new Audio(expediting)
const avatar = ref(avatarStore.avatar)
const citys = ref([
  { name: '基隆', value: 1 },
  { name: '宜蘭', value: 2 },
  { name: '台北', value: 3 },
  { name: '新北', value: 4 },
  { name: '新竹', value: 5 }, 
  { name: '桃園', value: 6 }, 
  { name: '彰化', value: 7 }, 
  { name: '南投', value: 8 }, 
  { name: '台中', value: 9 },
  { name: '雲林', value: 10 },
  { name: '嘉義', value: 11 },
  { name: '台南', value: 12 },
  { name: '高雄', value: 13 },
  { name: '屏東', value: 14 },
])
const districts = ref([
  { name: '北區', value: 1 },
  { name: '東區', value: 2 },
  { name: '西區', value: 3 },
  { name: '南區', value: 4 }
])
const AddressForm = reactive({
  id: null,
  consignee: '',
  phone: '',
  sex: '',
  cityCode: '',
  cityName: '',
  districtCode: '',
  districtName: '',
  detail: '',
  label: '',
  isDefault: ''
})
// 提供購物車數據和操作方法
provide('shoppingCartItems', shoppingCartItems);
// 提供營業狀態數據和操作方法
provide('isOpen', isOpen);
// 提供地址列表數據
provide('addressList', addressList);

// 計算總金額
const totalAmount = computed(() =>
  shoppingCartItems.reduce((sum, item) => sum + item.amount * item.number, 0)
)
// 鉤子
onMounted(async () => {
  getMenu() // 獲取選單數據
  getShopStatus() // 獲取營業狀態
  getCartItems() // 獲取購物車內容
  fetchAddresses() // 獲取地址列表
  connectToWebSocket() // 建立 WebSocket 連接 
})
// 在組件卸載時關閉 WebSocket
onBeforeUnmount(() => {
  if (ws.value) {
    ws.value.close();
  }
})
// WebSocket 實例及狀態
const ws = ref(null)
const isConnected = ref(false)
const message = ref('')
const receivedMessages = ref([])
// WebSocket 連接函數
const connectToWebSocket = () => {
  // 假設伺服端 WebSocket URL，根據需要修改
  // type、orderId、content
  ws.value = new WebSocket(`ws://localhost:8080/ws/${userIdStore.userId}`)

  ws.value.onopen = () => {
    isConnected.value = true;
    console.log('WebSocket 已連接')
  }

  ws.value.onmessage = (event) => {
    console.log('收到伺服端訊息:', event.data)
    receivedMessages.value.push(event.data) // 儲存伺服端返回的訊息
    if(roleStore.role > 1){ // 管理端才接收
      try{
        const msg = JSON.parse(event.data)
        // 判斷是來單提醒還是客戶催單
        if(msg.type === 1){ // 來單提醒
          // 播放提醒音效
          remindSound.play().catch((error) => {
            console.error('播放音效失敗:', error)
          })
          // 顯示通知
          ElNotification({
              title: '待接單',
              message: `來了一筆訂單，${msg.content}`,
              position: 'top-right',  // 右上角顯示
              duration: 8000,  // 5秒後自動消失
          });
        }else{ // 顧客催單
          // 播放催單音效expediting
          expeditingSound.play().catch((error) => {
            console.error('播放音效失敗:', error)
          })
          // 顯示通知
          ElNotification({
              title: '催單',
              message: `${msg.content}`,
              position: 'top-right',  // 右上角顯示
              duration: 8000,  // 5秒後自動消失
          });
        }
      }catch(error){
        console.error('解析伺服端訊息時出現錯誤:', error)
      }
    }
  }
  ws.value.onerror = (error) => {
    console.error('WebSocket 錯誤:', error)
  }
  ws.value.onclose = () => {
    console.log('WebSocket 已關閉')
    isConnected.value = false
  }
}
// 發送訊息
const sendMessage = () => {
  if (ws.value && ws.value.readyState === WebSocket.OPEN) {
    ws.value.send(JSON.stringify({ type: 'message', content: message.value }));
    message.value = ''; // 清空輸入框
  } else {
    ElMessage.error('WebSocket 未連接，請重新登入！')
  }
}
// 關閉連接
const disconnect = () => {
  if (ws.value) {
    ws.value.close();
    ws.value = null;
    isConnected.value = false;
  }
}
// 退出登入
const logout = () => {
  ElMessageBox.confirm('確定要退出登入嗎？', '退出登入', {
    confirmButtonText: '確定',cancelButtonText: '取消',type: 'warning',
  }).then(async () => {
    // 登出，調用 logoutApi
    const res = await logoutApi()
    console.log(res)
    if(res.code){
      // 斷開WebSocket連接
      disconnect()
      // 清除token和角色等資訊
      userIdStore.removeUserId()
      tokenStore.removeToken()
      roleStore.removeRole()
      accountStore.removeAccount()
      avatarStore.removeAvatar()
      balanceStore.removeBalance()
      ElMessage.success('退出成功')
      // 登出後跳轉到登入頁面
      router.push('/login')
    }
  }).catch(() => { // 取消登出
    ElMessage.info('已取消退出登入')
  })
}
const navigate = (path) => router.push(path);
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
}
// 獲取地址列表
const fetchAddresses = async () => {
  const response = await getAddressListApi()
  addressList.splice(0, addressList.length, ...response.data)
  // 綁定 defaultAddress
  const defaultAddr = addressList.find((address) => address.isDefault)
  // 確保defaultAddress不會設成 undefined
  defaultAddress.value = defaultAddr || { cityName: '', destrictName: '', detail: '尚未設置默認地址' };
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
  const res = await updateStatusApi(Number(isOpen.value))
  if(res.code){
    ElMessage.success('營業狀態已更新！')
    console.log(`營業狀態已更新: ${isOpen.value ? '營業中' : '休息中'}`)
  }else{
    ElMessage.error(res.msg)
  }
}
// 監聽營業狀態變化
watch(isOpen, (newValue) => {
})
// 打開購物車彈框
const openCartDialog = () => {
  console.log("購物車", {shoppingCartItems})
  isCartDialogVisible.value = true
}
// 打開地址彈窗
const openAddressDialog = () => {
  fetchAddresses()
  isAddressDialogVisible.value = true
  // 設置當前選中地址為預設地址，這樣打開彈框，設置預設地址單選框就會聯動
  console.log('selectedAddress', selectedAddress.value)
  console.log('defaultAddress', defaultAddress.value)

  selectedAddress.value = defaultAddress.value.id
}
const rules = {
  consignee: [
    { required: true, message: '請輸入收貨人姓名', trigger: 'blur' },
    { min: 2, max: 16, message: '姓名長度在 2 到 16 個字符之間', trigger: 'blur' },
  ],
  sex: [
    { required: true, message: '請選擇性別', trigger: 'blur' },
  ],
  phone: [
    { required: true, message: '請輸入手機號碼', trigger: 'blur' },
    { pattern: /^09\d{8}$/, message: '手機號碼必須為09 開頭的 10 位數字', trigger: 'blur'}
  ],
  cityName: [
    { required: true, message: '請選擇城市', trigger: 'blur' },
  ],
  detail: [
    { required: true, message: '請輸入詳細地址', trigger: 'blur' },
    { min: 5, max: 100, message: '地址長度在 5 到 100 個字符之間', trigger: 'blur' },
  ]
}
// 設置默認地址
const setDefaultAddress = async (id, detail) => {
  selectedAddress.value = id // 這一步會讓設為預設地址單選框與當前默認地址聯動
  const result = await setDefaultAddressApi(id)
  if(result.code){
    ElMessage.success(`成功設置默認地址`)
    defaultAddress.value = detail
    // 更新地址列表
    fetchAddresses()
  }
}
// 打開新增地址彈窗
const addAddress = () => {
  isEditAddressDialogVisible.value = true;
  addressDialogTitle.value = '新增地址';
  
  // 逐一重置 AddressForm 的屬性
  AddressForm.id = null;
  AddressForm.consignee = '';
  AddressForm.phone = '';
  AddressForm.sex = '';
  AddressForm.cityCode = '';
  AddressForm.cityName = '';
  AddressForm.districtCode = '';
  AddressForm.districtName = '';
  AddressForm.detail = '';
  AddressForm.label = '';
  AddressForm.isDefault = '';

  // 重置表單提示訊息
  if (AddressFormRef.value) {
    AddressFormRef.value.resetFields();
  }
}
// 編輯地址
const editAddress = async (id) => {
  const result = await getAddressByIdApi(id)
  if(result.code){
    isEditAddressDialogVisible.value = true
    addressDialogTitle.value = '編輯地址'
    Object.assign(AddressForm, result.data)
  }
}
// 保存地址
const saveAddress = async () => {
  // 表單校驗
  AddressFormRef.value.validate(async (valid) => {
    if(valid){
      let result
      if(AddressForm.id){ // 編輯地址
        result = await updateAddressApi(AddressForm)
      }else{ // 新增地址
        result = await addAddressApi(AddressForm)
      }
      if(result.code){
        ElMessage.success('保存成功')
        // 關閉彈框
        isEditAddressDialogVisible.value = false
        // 再次獲得地址列表
        fetchAddresses()
      }else{
        ElMessage.error(result.msg)
      }
    }else{
      ElMessage.error('表單校驗不通過')
    }
  })
}
// 刪除地址
const deleteAddress = async (id) => {
  ElMessageBox.confirm('確定刪除此地址嗎？', '提示',
    { confirmButtonText: '確定', cancelButtonText: '取消', type: 'warning',}
  ).then(async () => { // 確定
    const result = await deleteAddressApi(id)
    if (result.code) {
      ElMessage.success('刪除成功')
      // 獲得地址列表
      fetchAddresses()
    }
  })
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
  console.log('去結算:', shoppingCartItems)
  // 關閉購物車彈窗
  isCartDialogVisible.value = false
  // 跳轉訂單結算頁面
  router.push({
    name: 'checkout',
    params: {
      cartItems: shoppingCartItems,
    },
  })
}
// 文件上傳成功後觸發，更新頭像
const handleAvatarSuccess = async (res) => {
  avatar.value = res.data
  // 將頭像存到pinia
  avatarStore.setAvatar(res.data)
  const user = {avatar: res.data, id: userIdStore.userId}
  // 調用後端更新頭像API
  const ressult = await updateUserApi(user)
  if(ressult.code){
    ElMessage.success('頭像更新成功')
  }
}
// 文件上傳之前觸發
const beforeAvatarUpload = (rawFile) => {
  // 先判斷文件類型是否是圖片
  if (rawFile.type !== 'image/jpeg' && rawFile.type !== 'image/png') {
    ElMessage.error('只支持上傳圖片')
    return false
  } else if (rawFile.size / 1024 / 1024 > 10) {
    ElMessage.error('只能上傳10M以内圖片')
    return false
  }
  return true
}
// 跳轉修改密碼頁面
const openChangePassword = () => {
  router.push({
    name: 'password'
  })
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
          <span v-if="roleStore.role != 2" class="address-display" @click="openAddressDialog">
            <img
                  src="@/assets/images/marker.png"
                  alt="Location"
                  class="marker-icon-image"
                  @click="openAddressDialog"
            />
            <span v-if="defaultAddress && defaultAddress.detail">
              {{ defaultAddress.detail }}
            </span>
            <span v-else>
              尚未設置默認地址
            </span>
          </span>
        </span>
        <!-- end Header 左側區域 -->
        
        <!-- Header 右側區域 -->
        <span class="header-right-content">
          <!-- 頭像顯示 -->
          <span class="avatar-info">
            <img
              :src="avatarStore.avatar || defaultAvatarIcon"
              alt="User Avatar"
              class="user-avatar"
              @click="isAvatarDialogVisible = true"
            />
          </span>
          <!-- 帳號和身份顯示 -->
          <span class="account-info">
            帳號：<strong>{{ accountStore.account }}</strong>
          </span>
          <span class="role-info">
            &nbsp;&nbsp; | &nbsp;&nbsp;
            身份：<strong>{{ roleStore.role === 1 ? '顧客' : roleStore.role === 2 ? '員工' : '管理員' }}</strong>
          </span>
          
          <span v-if="roleStore.role != 2 ? true : false" class="balance-info">
            &nbsp;&nbsp; | &nbsp;&nbsp;
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
          <a @click="openChangePassword" class="clickable-link">
            <el-icon><EditPen /></el-icon> 修改密碼 
          </a>
          &nbsp;&nbsp; |  &nbsp;&nbsp;
          <a @click="logout" class="clickable-link">
            <el-icon><SwitchButton /></el-icon> 退出登入
          </a>
        </span>
        <!-- end Header 右側區域 -->
      </el-header>
      
      <el-container>
        <!-- 左側選單 -->
        <el-aside width="200px" class="aside">
          <!-- 左側選單欄 -->
          <el-menu v-if="menuList.length > 0" :default-active="activeMenuItem" >
            <el-menu-item
              v-for="menu in menuList"
              :key="menu.path"
              :index="menu.path"
              @click="navigate(menu.path)"
              class="menu-item"
            >
              <!-- 使用 img 標籤來顯示圖標 -->
              <!-- <img v-if="menu.icon" :src="menu.icon" alt="icon" class="menu-icon"/> -->
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
          <div class="cart-item-flavor">
            <p v-if="item.mealFlavor">口味 : {{ item.mealFlavor }}</p>
          </div>
        </div>
        <div class="cart-footer">
          <span class="cart-total-amount">總金額：{{ totalAmount }} 元</span>
          <el-button v-if="isOpen" type="primary" @click="proceedToCheckout">去結算</el-button>
        </div>
      </div>
      <div v-else>
        <p>購物車目前是空的。</p>
      </div>
    </el-dialog>
    <!-- end 購物車彈框 -->

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
    <!-- end 營業狀態彈框 -->

    <!-- 地址選擇彈窗 -->
    <el-dialog v-model="isAddressDialogVisible" width="350px">
      <template #header>
        <span class="custom-dialog-title">地址管理</span>
      </template>
      <!-- 新增地址按鈕 -->
      <div class="add-address-button">
          <el-button type="primary" @click="addAddress">新增地址</el-button>
      </div>
      <div v-for="address in addressList" :key="address.id" class="address-card">
        <!-- 上半部分 -->
        <div class="address-card-top">
          <!-- 左邊：圖標 -->
          <div class="address-icon">
            <img
              :src="address.isDefault ? defaultIcon : locationIcon"
              alt="Location Icon"
              class="location-icon"
              @click="setDefaultAddress(address.id, address.detail)"
            />
          </div>

          <!-- 中間：詳細地址與市名區名 -->
          <div class="address-info">
            <strong class="detail-address">{{ address.detail }}</strong>
            <p class="city-area">{{ address.cityName }} {{ address.districtName }}</p>
          </div>

          <!-- 右邊：編輯與刪除按鈕 -->
          <div class="address-buttons">
            <el-button type="text" @click="editAddress(address.id)">編輯</el-button>
            <el-button type="text" @click="deleteAddress(address.id)">刪除</el-button>
          </div>
        </div>

        <!-- 下半部分 -->
        <div class="address-card-bottom">
          <el-radio
            v-model="selectedAddress"
            :label="address.id"
            @change="setDefaultAddress(address.id, address.detail)"
          >
            設為預設地址
          </el-radio>
        </div>
      </div>
    </el-dialog>
    <!-- end 地址選擇彈窗 -->

    <!-- 新增與編輯地址彈窗 -->
    <el-dialog
      v-model="isEditAddressDialogVisible"
      :title="addressDialogTitle"
      width="400px"
    >
      <el-form :model="AddressForm" :rules="rules" ref="AddressFormRef" label-width="80px">
        <el-form-item label="聯絡人" prop="consignee">
          <el-input v-model="AddressForm.consignee" placeholder="請輸入聯絡人"></el-input>
        </el-form-item>
        <el-form-item label="性別" prop="sex">
          <el-radio-group v-model="AddressForm.sex">
            <el-radio label="1">男</el-radio>
            <el-radio label="0">女</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="手機號碼" prop="phone">
          <el-input v-model="AddressForm.phone" placeholder="請輸入手機號碼"></el-input>
        </el-form-item>
        <el-form-item label="城市" prop="cityName">
          <el-select v-model="AddressForm.cityName" placeholder="請選擇">
            <el-option v-for="c in citys" :key="c.value" :label="c.name" :value="c.name"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="區域">
          <el-select v-model="AddressForm.districtName" placeholder="請選擇">
            <el-option v-for="d in districts" :key="d.value" :label="d.name" :value="d.name"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="詳細地址" prop="detail">
          <el-input v-model="AddressForm.detail" placeholder="請輸入詳細地址"></el-input>
        </el-form-item>
        <el-form-item label="標籤">
          <el-radio-group v-model="AddressForm.label">
            <el-radio label="0">家</el-radio>
            <el-radio label="1">公司</el-radio>
            <el-radio label="2">學校</el-radio>
          </el-radio-group>
        </el-form-item>
      </el-form>
      <div style="text-align: right; margin-top: 20px;">
        <el-button @click="isEditAddressDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="saveAddress">保存</el-button>
      </div>
    </el-dialog>
    <!-- end 新增與編輯地址彈窗 -->

    <!-- 更換頭像的彈框 -->
    <el-dialog v-model="isAvatarDialogVisible" title="更換頭像" width="250px">
      <el-row>
        <el-col :span="20">
          <el-form-item>
            <el-upload
              class="avatar-uploader"
              action="/api/upload"
              :headers="{'token': tokenStore.token}"
              :show-file-list="false"
              :on-success="handleAvatarSuccess"
              :before-upload="beforeAvatarUpload"
              >
              <img v-if="avatar" :src="avatar" class="iamge"
              style="width: 100px; height: 80px; object-fit: cover;"/>
              <el-icon v-else class="avatar-uploader-icon"><Plus /></el-icon>
            </el-upload>
          </el-form-item>
        </el-col>
      </el-row>
      <template #footer>
        <div class="dialog-footer">
          <el-button @click="isAvatarDialogVisible = false">關閉</el-button>
        </div>
      </template>
    </el-dialog>
    <!-- end 更換頭像的彈框 -->
  </div>
</template>

<style scoped>
.add-address-button{
  margin-bottom: 20px;
}
.address-card{
  border: 1px solid #dcdfe6;
  border-radius: 8px;
  padding: 15px;
  margin-bottom: 15px;
  display: flex;
  flex-direction: column;
  gap: 10px;
}
.address-card-top {
  display: flex;
  align-items: center;
  justify-content: space-between;
}
.address-icon {
  flex-shrink: 0;
  margin-top: 10px;
  width: 40px;
  height: 40px;
}
.location-icon {
  width: 50%;
  height: 50%;
}
.address-info {
  flex-grow: 1;
  margin-left: 0px;
}
.detail-address {
  font-size: 16px;
  font-weight: bold;
}
.city-area {
  font-size: 14px;
  color: #909399;
}
.address-button {
  display: flex;
  gap: 10px;
}
.address-card-bottom {
  display: flex;
  align-items: center;
  justify-content: flex-start;
}
.address-card-bottom .el-radio {
  margin: 0;
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
/* 左側選單 */
.aside {
  width: 220px;
  border-right: 1px solid #ccc;
  height: 730px;
}
/* 設定選單的樣式 */
.menu {
  width: 100%;  /* 讓選單寬度自適應 */
  display: flex;
  flex-direction: column;
  align-items: center;  /* 讓選單項目水平居中 */
  padding: 20px 0;
}
/* 選單項目 */
.menu-item {
  display: flex;
  justify-content: center; /* 使圖標和文字水平居中 */
  align-items: center;  /* 使圖標和文字垂直居中 */
  text-align: center;  /* 確保文字垂直居中 */
  width: 100%;
  padding: 10px 0;
}
/* 選中樣式 */
.el-menu-item.is-active {
  background-color: #409eff;  /* 選中項目背景色 */
  color: #fff;  /* 選中項目文字顏色 */
}
/* 非選中狀態下的樣式 */
.el-menu-item {
  transition: background-color 0.3s, color 0.3s;  /* 加入過渡效果 */
}
/* 預設選中項目的顏色 */
.el-menu-item.is-active .menu-icon {
  filter: brightness(0) saturate(100%) invert(38%) sepia(99%) saturate(2673%) hue-rotate(180deg) brightness(96%) contrast(94%); /* 自定義選中圖標顏色 */
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
.cart-total-amount{
  font-size: 20px;
}
.cart-item-flavor{
  margin-top: 40px;
  margin-right: 120px;
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
/* Marker圖標 */
.marker-icon-image {
  width: 20px; 
  height: 20px;
  margin-right: 5px;
  cursor: pointer;
}
.default-location-icon,
.location-icon {
  width: 24px; 
  height: 24px; 
  margin-right: 10px; /* 與地址文字間距 */
  object-fit: contain; /* 確保圖片不會變形 */
  cursor: pointer; /* 鼠標懸停顯示指針 */
}
/* 修改密碼與退出登入的樣式 */
.clickable-link {
  cursor: pointer; /* 手掌樣式 */
  text-decoration: none; /* 移除超連結的預設下劃線 */
  color: inherit; /* 保持文字顏色一致 */
}
.clickable-link:hover {
  color: #409EFF; /* 可選：當滑鼠移上去時改變文字顏色 */
}
.image-preview {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block; /* 保證圖片作為塊級元素存在 */
}
.placeholder {
  display: flex;
  justify-content: center;
  align-items: center;
  color: #c0c4cc;
  font-size: 24px;
  width: 100%; /* 保證占位元素充滿容器 */
  height: 100%;
}
.dialog-footer {
  display: flex;
  justify-content: center;
  gap: 20px; /* 按鈕之間的間距 */
}
.avatar-uploader {
  width: 100px;
  height: 100px;
  display: flex;
  margin-left: 50px;
}
.avatar-uploader .el-upload {
  border: 1px dashed var(--el-border-color);
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  transition: var(--el-transition-duration-fast);
}
.el-icon.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 100px;
  height: 100px;
  text-align: center;
  border-radius: 10px;
  /* 添加灰色的虛線邊框 */
  border: 1px dashed var(--el-border-color);
}
.menu-icon{
  width: 20px;
  height: 20px;
  margin-right: 15px;
}
</style>
