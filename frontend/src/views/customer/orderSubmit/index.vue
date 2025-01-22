<script setup>
import {ref, computed, inject, watch, reactive, onMounted} from 'vue'
import { orderSubmitApi } from '@/api/order'
import { useBalanceStore } from '@/stores/balance'
import { ElMessage } from 'element-plus'
import useAddress from '@/composables/useAddress';

const balanceStore = useBalanceStore()
const addressList = inject('addressList', reactive([])) // 地址列表，從父組件傳入
const shoppingCartItems = inject('shoppingCartItems', reactive([])) // 購物車列表，從父組件傳入
const isPayDialogVisible = ref(false) // 控制確定支付彈窗
const orderFormRef = ref()
const { fetchAddressList } = useAddress()

onMounted(() => {
  fetchAddressList()
})

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
  { required: true, message: '請選擇收貨地址', trigger: 'blur' },
  ],
  deliveryStatus: [
    { required: true, message: '請選擇下單方式', trigger: 'blur' },
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
        // 清空購物車列表
        shoppingCartItems.length = 0
        // 跳轉到訂單頁面，去支付
      }
    }else{
      ElMessage.error('表單校驗不通過')
    }
  })
}
// 確認支付按鈕操作
// const payOrder = async () => {
//   // 調用支付接口
//   const result = await orderSubmitApi(order.value)
//   if(result.code){
//     ElMessage.success('訂單提交成功')
//     // 更新餘額顯示
//     balanceStore.setBalance(newBalance.value)
//     // 清空訂單信息
//     clearOrder()
//     // 關閉彈窗
//     isPayDialogVisible.value = false
//     // 跳轉到歷史訂單頁面
//     console.log('跳轉到歷史訂單頁面')
//   }else{
//     ElMessage.error(result.msg)
//   }
// }
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
        <el-form-item label="收貨地址" prop="addressBookId">
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
            <el-radio label="0">選擇其他時間</el-radio>
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
        <el-table-column label="餐點圖片" width="100">
          <template #default="{ row }">
            <el-image
              :src="row.image"
              fit="cover"
              style="width: 60px; height: 60px; border-radius: 8px;"
            />
          </template>
        </el-table-column>
        <el-table-column label="餐點名稱" prop="name" />
        <el-table-column label="數量">
          <template #default="{ row }">
            <span>{{ row.number }}</span>
          </template>
        </el-table-column>
        <el-table-column label="金額">
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
      <h3>備註與支付</h3>
      <el-input
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
    <el-dialog v-model="isPayDialogVisible" title="確定支付" width="400px">
      <span>扣除費用 {{ amount }} 元，餘額為 {{ newBalance }} 元</span>

      <template #footer>
        <el-button @click="isPayDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="payOrder">確定支付</el-button>
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