<script setup>
import { ref } from 'vue'
import { ElMessage } from 'element-plus'
import { registerApi, loginApi } from '@/api/auth'
import { Avatar, User, Lock, Phone } from '@element-plus/icons-vue'

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
// 校驗手機號的函數
const checkPhone = (rule, value, callback) => {
  const phoneRegex = /^09\d{8}$/; // 以09開頭，後面8位數字
  if (!phoneRegex.test(value)) {
    callback(new Error('手機號碼必須為 09 開頭的 10 位數字'));
  } else {
    callback();
  }
}

// 定義註冊表單校驗規則
const rules = {
  name: [
  { required: true, message: '請輸入姓名', trigger: 'blur' },
  { min: 1, max: 16, message: '長度為 1 到 16 位非空字符', trigger: 'blur' }
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
    { validator: checkPhone, trigger: 'blur',}
  ]
}

// 註冊函數
const register = async () => {
  let result = await registerApi(registerData.value)
  if (result.code === 1) {
    ElMessage.success(result.msg ? result.msg : '註冊成功') 
  }else{
    ElMessage.error(result.msg ? result.msg : '註冊失敗')
  }
  
  
  
}  
// 登入函數
const login = async () => {
  let result = await loginApi(registerData.value)
  if (result.code === 1) {
    ElMessage.success(result.msg ? result.msg : '登入成功') 
  }else{
    ElMessage.error(result.msg ? result.msg : '登入失敗')
  }
}
// 定義清空數據模型的函數
const clearRegisterData = () => {
  registerData.value = {
    name: '',
    account: '',
    password: '',
    rePassword: '',
    phone: ''
  }
}

</script>

<template>
  <div id="container">
    <div class="login-form">
      <!-- 註冊 表單 -->
      <el-form label-width="80px" v-if="isRegister" :model="registerData" :rules="rules">
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

        <el-form-item>
          <el-button class="button" type="primary" @click="register">註 冊</el-button>
          <el-button class="button" type="info" @click="clearRegisterData">清 空</el-button>
        </el-form-item>

        <el-form-item class="flex">
            <el-link type="info" :underline="false" @click="isRegister = false ; clearRegisterData()">
                ← 登入頁面
            </el-link>
        </el-form-item>

      </el-form>
      <!-- 登入 表單 -->
      <el-form label-width="80px" v-else :model="registerData">
        <p class="title">登入</p>
        <el-form-item label="帳號" prop="account">
          <el-input :prefix-icon="User" v-model="registerData.account" placeholder="請輸入帳號"></el-input>
        </el-form-item>

        <el-form-item label="密碼" prop="password">
          <el-input :prefix-icon="Lock" type="password" v-model="registerData.password" placeholder="請輸入密碼"></el-input>
        </el-form-item>
        
        <el-form-item class="flex">
            <div class="flex">
                <el-checkbox>記住我</el-checkbox>
            </div>
        </el-form-item>
        <!-- 登入按鈕 -->
        <el-form-item>
          <el-button class="button" type="primary" @click="login">登 入</el-button>
          <el-button class="button" type="info" @click="clearRegisterData">清 空</el-button>
        </el-form-item>

        <el-form-item class="flex">
          <el-link type="info" :underline="false" @click="isRegister = true; clearRegisterData()">
              註冊 →
          </el-link>
        </el-form-item>
      </el-form>
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