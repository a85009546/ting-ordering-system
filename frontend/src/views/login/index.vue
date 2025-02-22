<script setup>
import { ref} from 'vue'
import { ElMessage } from 'element-plus'
import { registerApi, loginApi } from '@/api/auth'
import { useRouter } from 'vue-router'
import { useUserIdStore } from '@/stores/userId'
import { useTokenStore } from '@/stores/token'
import { useRoleStore } from '@/stores/role'
import { useAccountStore } from '@/stores/account'
import { useBalanceStore } from '@/stores/balance'
import { useAvatarStore } from '@/stores/avatar'

const router = useRouter()
const userIdStore = useUserIdStore()
const tokenStore = useTokenStore()
const roleStore = useRoleStore()
const accountStore = useAccountStore()
const balanceStore = useBalanceStore()
const avatarStore = useAvatarStore()

// 控制登入與註冊表單的切換
const isRegister = ref(false)
// 定義註冊表單數據
const sex = ref('')
let registerData = ref({
  name:'',
  account:'',
  password:'',
  rePassword:'',
  phone:''
})
// 定義清空數據模型的函數
const clearRegisterData = () => {
  registerData.value = {
    name: '',
    account: '',
    password: '',
    rePassword: '',
    phone: '',
    sex: ''
  }
}
// 校驗密碼的函數
const checkRePassword = (rule, value, callback) => {
  if (value === '') {
    callback(new Error('請再次輸入密碼'))
  } else if (value !== registerData.value.password) {
    callback(new Error('兩次輸入的密碼不一致'))
  } else {
    callback()
  }
}
// 定義註冊表單校驗規則
const rules = {
  name: [
  { required: true, message: '請輸入姓名', trigger: 'blur' },
  { min: 2, max: 16, message: '長度為 2 到 16 位非空字符', trigger: 'blur' }
  ],
  account: [
    { required: true, message: '請輸入帳號', trigger: 'blur' },
    { min: 4, max: 16, message: '長度為 4 到 16 位非空字符', trigger: 'blur' }
  ],
  password: [
    { required: true, message: '請輸入密碼', trigger: 'blur' },
    { min: 4, max: 16, message: '長度為 4 到 16 位非空字符', trigger: 'blur' }
  ],
  rePassword: [
    { validator: checkRePassword, trigger: 'blur' }
  ],
  phone: [
    { required: true, message: '請輸入手機號碼', trigger: 'blur' },
    { pattern: /^09\d{8}$/, message: '手機號碼必須為09 開頭的 10 位數字', trigger: 'blur'}
  ],
  sex:  [
    { required: true, message: '請選擇性別', trigger: 'change' } // 性別校驗
  ]
}
const registerFormRef = ref()
// 註冊函數
const register = async () => {
  // 表單校驗
  if(!registerFormRef.value) return
  registerFormRef.value.validate(async (valid) => {
    if(valid){ // 校驗通過，去註冊
      let result = await registerApi(registerData.value)
      if (result.code === 1) {
        ElMessage.success(result.msg ? result.msg : '註冊成功') 
        // 跳轉到登入頁面
        isRegister.value = false
        // 清空表單數據
        clearRegisterData()
      }else{
        ElMessage.error(result.msg ? result.msg : '註冊失敗')
      }
    }else{
      ElMessage.error('表單校驗不通過')
    }
  })
}
// 登入函數
const login = async () => {
  let result = await loginApi(registerData.value)
  console.log(result)
  if (result.code === 1) {
    ElMessage.success(result.msg ? result.msg : '登入成功') 
    // 把userId存到pinia
    userIdStore.setUserId(result.data.id)
    console.log('存入userId至pinia:', userIdStore.userId)
    // 把token存到pinia
    tokenStore.setToken(result.data.token)
    console.log('存入token至pinia:', tokenStore.token)
    // 角色狀態存到 pinia
    roleStore.setRole(result.data.role)
    console.log('存入role至pinia:',roleStore.role)
    // 帳號存到 pinia
    accountStore.setAccount(result.data.account)
    console.log('存入account至pinia:',accountStore.account)
    // 頭像存到 pinia
    avatarStore.setAvatar(result.data.avatar)
    console.log('存入avatar至pinia:',avatarStore.avatar)
    // 餘額存到 pinia
    balanceStore.setBalance(result.data.balance)
    console.log('存入balance至pinia:',balanceStore.balance)
    // 跳轉到首頁
    router.push('/')
  }
}
</script>

<template>
  <div id="container">
    <div class="login-form">
      <!-- 註冊 表單 -->
      <el-form label-width="80px" v-if="isRegister" :model="registerData" :rules="rules" ref="registerFormRef">
        <p class="title">註冊</p>
        <el-form-item label="姓名" prop="name">
          <el-input :prefix-icon="Avatar" v-model="registerData.name" placeholder="請輸入姓名"></el-input>
        </el-form-item>
        <el-form-item label="帳號" prop="account">
          <el-input :prefix-icon="User" v-model="registerData.account" placeholder="請輸入帳號"></el-input>
        </el-form-item>

        <el-form-item label="密碼" prop="password">
          <el-input :prefix-icon="Lock" type="password" v-model="registerData.password" placeholder="請輸入密碼"></el-input>
        </el-form-item>

        <el-form-item prop="rePassword">
          <el-input :prefix-icon="Lock" type="password" v-model="registerData.rePassword"  placeholder="請再次輸入密碼"></el-input>
        </el-form-item>

        <el-form-item label="手機號碼" prop="phone">
          <el-input :prefix-icon="Phone" v-model="registerData.phone" placeholder="請輸入手機號碼"></el-input>
        </el-form-item>

        <el-form-item label="性別" prop="sex">
          <el-radio-group v-model="registerData.sex">
            <el-radio label="1">男</el-radio>
            <el-radio label="0">女</el-radio>
          </el-radio-group>
        </el-form-item>
        <!-- 註冊與清空按鈕 -->
        <el-form-item>
          <el-button class="button" type="primary" @click="register">註 冊</el-button>
          <el-button class="button" type="info" @click="clearRegisterData">清 空</el-button>
        </el-form-item>
        <!-- end 註冊與清空按鈕 -->
        <!-- 切換登入頁面按鈕 -->
        <el-form-item class="flex">
            <el-link type="info" :underline="false" @click="isRegister = false ; clearRegisterData()">
                ← 登入頁面
            </el-link>
        </el-form-item>
        <!-- end 切換登入頁面按鈕 -->
      </el-form>
      <!-- end 註冊 表單 -->
      <!-- 登入 表單 -->
      <el-form label-width="80px" v-else :model="registerData">
        <p class="title">登入</p>
        <!-- 帳號與密碼輸入框 -->
        <el-form-item label="帳號" prop="account">
          <el-input :prefix-icon="User" v-model="registerData.account" placeholder="請輸入帳號"></el-input>
        </el-form-item>
        <el-form-item label="密碼" prop="password">
          <el-input :prefix-icon="Lock" type="password" v-model="registerData.password" placeholder="請輸入密碼"></el-input>
        </el-form-item>
        <!-- end 帳號與密碼輸入框 -->
        <!-- 登入與清空按鈕 -->
        <el-form-item>
          <el-button class="button" type="primary" @click="login">登 入</el-button>
          <el-button class="button" type="info" @click="clearRegisterData">清 空</el-button>
        </el-form-item>
        <!-- end 登入與清空按鈕 -->
        <!-- 切換註冊頁面按鈕 -->
        <el-form-item class="flex">
          <el-link type="info" :underline="false" @click="isRegister = true; clearRegisterData()">
              註冊 →
          </el-link>
        </el-form-item>
        <!-- end 切換註冊頁面按鈕 -->
      </el-form>
      <!-- end 登入 表單 -->
    </div>

  </div>
</template>

<style scoped>
#container {
  padding: 10%;
  height: 600px;
  background-image: url('@/assets/images/login.jpg');
  background-repeat: no-repeat;
  background-size: cover;
}

.login-form {
  max-width: 400px;
  padding: 30px;
  margin: 0 auto;
  border: 1px solid #e0e0e0;
  border-radius: 10px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
  background-color: white;
}

.title {
  font-size: 30px;
  font-family: '楷体';
  text-align: center;
  margin-bottom: 30px;
  font-weight: bold;
}

.button {
  margin-top: 30px;
  width: 120px;
}
</style>