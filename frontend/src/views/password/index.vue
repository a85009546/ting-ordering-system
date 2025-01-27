<script setup>
import { ref } from 'vue';
import { ElMessage } from 'element-plus';
import { updateUserPasswordApi } from '@/api/user'
import { useRouter } from 'vue-router'


// 表單數據模型
const user = ref({
  password: '',
  newPassword: '',
  rePassword: '',
})
const userFormRef = ref()
const router = useRouter()
// 校驗密碼的函數
const checkRePassword = (rule, value, callback) => {
  if (value === '') {
    callback(new Error('請再次輸入密碼'))
  } else if (value !== user.value.newPassword) {
    callback(new Error('兩次輸入的密碼不一致'))
  } else {
    callback()
  }
}
// 表單校驗規則
const rules = {
  password: [
    { required: true, message: '請輸入原密碼', trigger: 'blur' },
    { min: 4, max: 16, message: '密碼長度在4到16字符之間', trigger: 'blur' },
  ],
  newPassword: [
    { required: true, message: '請輸入新密碼', trigger: 'blur' },
    { min: 4, max: 16, message: '密碼長度在4到16字符之間', trigger: 'blur' },
  ],
  rePassword: [
    { validator: checkRePassword, trigger: 'blur' }
  ]
}
// 提交表單
const updatePassword = () => {
  // 表單校驗
  if(!userFormRef.value) return
  userFormRef.value.validate(async (valid) => {
    if(valid){ // 表單校驗通過
      // 調用修改密碼 API
      const res = await updateUserPasswordApi(user.value.password, user.value.newPassword)
      if(res.code){
        ElMessage.success('密碼已更新，請重新登入!')
        // 清空表單數據
        user.value = {
          password: '',
          newPassword: '',
          rePassword: ''
        }
        // 清空表單提示
        userFormRef.value.resetFields()
        // 跳轉到登入頁面
        router.push('/login')
      }
    }else{ // 表單校驗不通過
      ElMessage.error('表單校驗不通過')
    }
  })
}
</script>

<template>
  <h1>修改密碼</h1>
  <el-form
    :model="user"
    :rules="rules"
    ref="userFormRef"
    label-width="80px"
    class="personal-center-form"
  >
    <!-- 原密碼 -->
    <el-form-item label="原密碼" prop="password">
      <el-input 
        v-model="user.password"
        type="password"
        placeholder="請輸入原密碼"
        show-password></el-input>
    </el-form-item>

    <!-- 新密碼 -->
    <el-form-item label="新密碼" prop="newPassword">
      <el-input 
        v-model="user.newPassword" 
        type="password"
        placeholder="請輸入新密碼"
        show-password></el-input>
    </el-form-item>

    <!-- 新密碼重複 -->
    <el-form-item prop="rePassword">
      <el-input 
        v-model="user.rePassword"
        type="password"
        placeholder="請再次輸入新密碼"
        show-password></el-input>
    </el-form-item>

    <!-- 保存按鈕 -->
    <el-form-item>
      <el-button class="save" type="primary" @click="updatePassword">提交</el-button>
    </el-form-item>
  </el-form>
</template>

<style scoped>
.personal-center-form {
  max-width: 400px;
  margin: 0 auto;
  padding: 50px 40px 30px;
  background-color: #ffffff;
  border-radius: 8px;
  box-shadow: 0 10px 4px rgba(0, 0, 0, 0.1);

  transform: scale(1.15); /* 這裡可以調整放大的倍數 */
  transform-origin: top center; /* 設置縮放的起始點，這樣縮放後內容不會偏移 */
}
.personal-center-form .el-form-item {
  margin-bottom: 30px; /* 增加表單項目的間距 */
}
.save{
  margin-top: 20px;
  margin-left: 100px;
}
</style>