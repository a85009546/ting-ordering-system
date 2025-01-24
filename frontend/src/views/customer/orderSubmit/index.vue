<script setup>
import { ref, computed, inject, watch, reactive, onMounted, onBeforeUnmount} from 'vue'
import { orderSubmitApi, orderPayApi } from '@/api/order'
import { useBalanceStore } from '@/stores/balance'
import { ElMessage } from 'element-plus'
import useAddress from '@/composables/useAddress'
import { useRouter } from 'vue-router'

const router = useRouter()
const balanceStore = useBalanceStore()
const addressList = inject('addressList', reactive([])) // 地址列表，從父組件傳入
const shoppingCartItems = inject('shoppingCartItems', reactive([])) // 購物車列表，從父組件傳入
const isPayDialogVisible = ref(false) // 控制確定支付彈窗
const orderFormRef = ref()
const { fetchAddressList } = useAddress()
const payOrderId = ref(null)
const remainingTime = ref(15 * 60) // 倒數時間，單位：秒 (15 分鐘)
let timer = null;


onMounted(() => {
  fetchAddressList()
})
// 組件卸載前清理計時器
onBeforeUnmount(() => {
  clearCountdown();
})
// 計算屬性 - 格式化剩餘時間為 mm:ss
const remainingTimeText = computed(() => {
  const minutes = Math.floor(remainingTime.value / 60)
    .toString()
    .padStart(2, "0");
  const seconds = (remainingTime.value % 60)
    .toString()
    .padStart(2, "0");
  return `${minutes}:${seconds}`
})
// 開始倒數計時
const startCountdown = () => {
  clearCountdown() // 確保不會有多個計時器
  timer = setInterval(() => {
    if (remainingTime.value > 0) {
      remainingTime.value--;
    } else {
      timeUp()
    }
  }, 1000)
}
// 倒數時間結束處理
const timeUp = () => {
  clearCountdown()
  isPayDialogVisible.value = false;
  ElMessage.error("支付時間已結束，訂單已取消！")
}
// 清除倒數計時器
const clearCountdown = () => {
  if (timer) {
    clearInterval(timer);
    timer = null;
  }
  console.log('已清除倒數計時器')
}
// 外送費與總金額計算
const deliveryFee = 30
const amount = computed(() => {
  // 直接使用 shoppingCartItems，因為它已經是 reactive
  if(shoppingCartItems.length === 0) return 0
  const itemsTotal = shoppingCartItems.reduce((sum, item) => {
    return sum + item.amount * item.number
  }, 0);
  return itemsTotal + deliveryFee
})
// 訂單數據模型
const order = ref({
  addressBookId:'',
  amount, 
  remark:'',
  estimatedDeliveryTime:'',
  deliveryStatus:''
}) 
// 清空訂單數據
const clearOrder = () => {
  order.value = {
    addressBookId:'',
    amount: 0, // 初始為 0，但會被 computed 覆蓋
    remark:'',
    estimatedDeliveryTime:'',
    deliveryStatus:''
  }
}
// 餘額計算
const newBalance = computed(() => {
  return balanceStore.balance - amount.value
})
// 格式化時間為 yyyy-MM-dd HH:mm:ss
function formatDate(date) {
  const yyyy = date.getFullYear();
  const mm = (date.getMonth() + 1).toString().padStart(2, '0'); // 月份從 0 開始，需要 +1 並格式化
  const dd = date.getDate().toString().padStart(2, '0');
  const hh = date.getHours().toString().padStart(2, '0');
  const min = date.getMinutes().toString().padStart(2, '0');
  const ss = date.getSeconds().toString().padStart(2, '0');
  return `${yyyy}-${mm}-${dd} ${hh}:${min}:${ss}`;
}
// 監聽 deliveryStatus 改變，計算預計送達時間
watch(() => order.value.deliveryStatus, (newStatus) => {
  if (newStatus === '1') { // 如果選擇立即送出
    const currentTime = new Date();
    order.value.estimatedDeliveryTime = formatDate(new Date(currentTime.getTime() + 60 * 60 * 1000)); // 預計60分鐘後送達
  } else {
    order.value.estimatedDeliveryTime = ''; // 如果不是立即送出，則清空預計送達時間
  }
});
// 定義註冊表單校驗規則
const rules = {
  addressBookId: [
  { required: true, message: '請選擇收貨地址', trigger: 'change' },
  ],
  deliveryStatus: [
    { required: true, message: '請選擇下單方式', trigger: 'change' },
  ]
}
// 提交訂單按鈕操作
const submitOrder = () => {
  // 表單校驗
  if(!orderFormRef.value) return
  orderFormRef.value.validate(async (valid) => {
    if(valid){ // 校驗通過
      // 調用提交訂單接口
      const res = await orderSubmitApi(order.value)
      if(res.code){
        ElMessage.success('訂單提交成功！')
        // 獲取訂單ID
        payOrderId.value = res.data.id
        // 彈出支付彈窗
        isPayDialogVisible.value = true
        // 開啟倒計時器
        startCountdown()   
      }
    }else{
      ElMessage.error('表單校驗不通過')
    }
  })
}
// 關閉支付彈窗
const handleClose = () => {
  // 清空購物車列表
  shoppingCartItems.length = 0
  // 跳轉至歷史訂單頁面
  router.push({name: 'history'})
}
// 立即支付按鈕操作
const payNow = async () => {
  // 調用支付接口
  console.log('payOrderId:' + payOrderId.value)
  const res = await orderPayApi(payOrderId.value)
  if(res.code){
    ElMessage.success('支付成功！')
    // 更新餘額顯示
    balanceStore.setBalance(newBalance.value)
    // 跳轉到歷史訂單頁面
    router.push({name: 'history'})
  }else{
    ElMessage.error(result.msg)
  }
}
</script>

<template>
  <div class="checkout-page">
    <!-- 第一部分：收貨地址和下單方式 -->
    {{ order }}
    {{ shoppingCartItems }}
    <el-card class="card">
      <h3>收貨資訊</h3>
      <el-form label-width="120px" :model="order" :rules="rules" ref="orderFormRef">
        <!-- 收貨地址 -->
        <el-form-item class="top-item" label="收貨地址" prop="addressBookId">
          <el-select v-model="order.addressBookId" placeholder="請選擇收貨地址">
            <el-option
              v-for="address in addressList"
              :key="address.id"
              :label="address.cityName + ' ' + address.districtName + ' ' + address.detail"
              :value="address.id"
            />
          </el-select>
        </el-form-item>
        <!-- 配送狀態 -->
        <el-form-item label="下單方式" prop="deliveryStatus">
          <el-radio-group v-model="order.deliveryStatus">
            <el-radio label="1">立即送出</el-radio>
            <el-radio label="0">選擇其他時間 ( 請在備註欄說明 )</el-radio>
          </el-radio-group>
          <el-alert
            v-if="deliveryStatus === '選擇其他時間'"
            title="配送時間請寫在備註"
            type="info"
            show-icon
            class="mt-2"
          />
        </el-form-item>
      </el-form>
    </el-card>

    <!-- 第二部分：訂單明細 -->
    <el-card class="card">
      <h3>訂單明細</h3>
      <el-table :data="shoppingCartItems" border>
        <el-table-column class="top-item" label="餐點圖片" width="100" align="center">
          <template #default="{ row }">
            <el-image
              :src="row.image"
              fit="cover"
              style="width: 60px; height: 60px; border-radius: 8px;"
            />
          </template>
        </el-table-column>
        <el-table-column label="餐點名稱" prop="name" align="center"/>
        <el-table-column label="口味" prop="mealFlavor" align="center"/>
        <el-table-column label="數量" align="center">
          <template #default="{ row }">
            <span>{{ row.number }}</span>
          </template>
        </el-table-column>
        <el-table-column label="金額" align="center">
          <template #default="{ row }">
            <span>NT$ {{ row.amount }}</span>
          </template>
        </el-table-column>
      </el-table>
      <div class="summary">
        <div class="summary-row">
          <span>外送費</span>
          <span>NT$ 30</span>
        </div>
        <div class="summary-row total">
          <span>合計</span>
          <span>NT$ {{ amount }}</span>
        </div>
      </div>
    </el-card>

    <!-- 第三部分：備註與支付 -->
    <el-card class="card">
      <h3>備註欄</h3>
      <el-input
        class="top-item"
        v-model="order.remark"
        type="textarea"
        placeholder="請填寫備註（可選）"
        rows="3"
      />
      <el-button
        type="primary"
        class="pay-button"
        size="large"
        @click="submitOrder"
      >
        提交訂單
      </el-button>
    </el-card>


    <!-- 支付確認彈窗 -->
    <el-dialog
      v-model="isPayDialogVisible" 
      title="要立即支付費用嗎?" 
      :close-on-click-modal="true"
      @close="handleClose"
      width="400px">
      <!-- 剩餘支付時間 -->
      <p style="margin-bottom: 20px; color: rgb(127, 67, 74); font-weight: bold;">
        剩餘支付時間：{{ remainingTimeText }}
      </p>

      <span>扣除費用 {{ amount }} 元，餘額為 {{ newBalance }} 元</span>

      <template #footer>
        <el-button @click="isPayDialogVisible = false">稍後支付</el-button>
        <el-button type="primary" @click="payNow">立即支付</el-button>
      </template>
    </el-dialog>
  
  </div>
</template>

<style scoped>
.checkout-page {
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
}

.card {
  margin-bottom: 20px;
}
.top-item{
  margin-top: 15px;
}

.mt-2 {
  margin-top: 10px;
}

.summary {
  margin-top: 20px;
  border-top: 1px solid #eaeaea;
  padding-top: 10px;
}

.summary-row {
  display: flex;
  justify-content: space-between;
  margin-bottom: 10px;
  padding-left: 10px;
  padding-right: 20px;
}

.summary-row.total {
  font-weight: bold;
  font-size: 16px;
}

.pay-button {
  display: block;
  width: 100%;
  margin-top: 20px;
}
</style>