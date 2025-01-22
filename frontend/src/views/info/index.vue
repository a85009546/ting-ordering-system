<script setup>
import { ref, onMounted } from 'vue';
import { ElMessage } from 'element-plus';
import { getUserByIdApi, updateUserApi } from '@/api/user'
import { useUserIdStore } from '@/stores/userId'

const userIdStore = useUserIdStore()
// 鉤子
onMounted(() => {
  getUserInfo()
})
// 獲得用戶資訊
const getUserInfo = async () => {
  const res = await getUserByIdApi(userIdStore.userId)
  user.value = res.data
}
// 用戶信息
const user = ref({
  account: 'user123', // 帳戶 (不可編輯)
  name: '', 
  sex: '', 
  phone: '', 
})
const userFormRef = ref()

// 表單校驗規則
const rules = {
  name: [
    { required: true, message: '請輸入姓名', trigger: 'blur' },
    { min: 2, max: 16, message: '姓名長度需在2到16字符之間', trigger: 'blur' },
  ],
  sex: [{ required: true, message: '請選擇性別', trigger: 'change' }],
  phone: [
    { required: true, message: '請輸入手機號碼', trigger: 'blur' },
    { pattern: /^09\d{8}$/, message: '手機號碼必須為09 開頭的 10 位數字', trigger: 'blur'}
  ],
}
// 提交表單
const updateUserInfo = () => {
  // 表單校驗
  if(!userFormRef.value) return
  userFormRef.value.validate(async (valid) => {
    if(valid){ // 校驗通過
      let res = await updateUserApi(user.value)
      if(res.code){
        ElMessage.success('個人資料修改成功！')
      }else{
        ElMessage.error(res.msg)
      }
    }else{
      ElMessage.error('表單校驗不通過')
    }
  })
}
</script>

<template>
  <h1>個人中心</h1>
  <el-form
    :model="user"
    :rules="rules"
    ref="userFormRef"
    label-width="80px"
    class="personal-center-form"
  >
    <!-- 帳戶 -->
    <el-form-item label="帳戶">
      <el-input v-model="user.account" disabled></el-input>
    </el-form-item>

    <!-- 姓名 -->
    <el-form-item label="姓名" prop="name">
      <el-input v-model="user.name" placeholder="請輸入姓名"></el-input>
    </el-form-item>

    <!-- 性別 -->
    <el-form-item label="性別" prop="sex">
      <el-radio-group v-model="user.sex">
        <el-radio label="1">男</el-radio>
        <el-radio label="0">女</el-radio>
      </el-radio-group>
    </el-form-item>

    <!-- 手機 -->
    <el-form-item label="手機" prop="phone">
      <el-input v-model="user.phone" placeholder="請輸入手機號碼"></el-input>
    </el-form-item>

    <!-- 保存按鈕 -->
    <el-form-item>
      <el-button type="primary" @click="updateUserInfo">保存</el-button>
    </el-form-item>
  </el-form>
</template>

<style scoped>
.personal-center-form {
  max-width: 400px;
  margin: 0 auto;
  padding: 20px;
  background-color: #fff;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}
</style>