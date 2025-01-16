<script setup>
  import { ref } from 'vue'
  
  let loginForm = ref({username:'', password:''})
  
</script>

<template>
  <div id="container">
    <div class="login-form">
      <el-form label-width="80px">
        <p class="title">Ting 點餐系統</p>
        <el-form-item label="用户名" prop="username">
          <el-input v-model="loginForm.username" placeholder="請輸入用戶名"></el-input>
        </el-form-item>

        <el-form-item label="密码" prop="password">
          <el-input type="password" v-model="loginForm.password" placeholder="請輸入密碼"></el-input>
        </el-form-item>

        <el-form-item>
          
          <el-button class="button" type="primary">登 入</el-button>
          <el-button class="button" type="info">清 空</el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<style scoped>
#container {
  padding: 10%;
  height: 571px;
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