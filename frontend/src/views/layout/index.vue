<script setup>

</script>

<template>
  <div class="common-layout">
    <el-container>
      <!-- Header 區域 -->
      <el-header class="header">
        <span class="title">Ting 點餐系統</span>
        <span class="right_tool">
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
          <el-menu router="true">

            <!-- 首頁 -->
              <el-menu-item index="/index">
                <el-icon><HomeFilled /></el-icon> 首頁
              </el-menu-item>
            
            <!-- 工作台 -->
            <el-menu-item index="/index">
              <el-icon><Platform /></el-icon> 工作臺
            </el-menu-item>

            <!-- 訂單管理 -->
            <el-menu-item index="/order">
              <el-icon><List /></el-icon> 訂單管理
            </el-menu-item>
            
            <!-- 套餐管理 -->
            <el-menu-item index="/category">
              <el-icon><Menu /></el-icon> 分類管理
            </el-menu-item>

            <!-- 餐點管理 -->
            <el-menu-item index="/meal">
              <el-icon><Dish /></el-icon> 餐點管理
            </el-menu-item>

            <!-- 員工管理 -->
            <el-menu-item index="/meal">
              <el-icon><Management /></el-icon> 員工管理
            </el-menu-item>
            
          </el-menu>
        </el-aside>
        <!-- 右側主區域 -->
        <el-main>
          <router-view></router-view>
        </el-main>
      </el-container>
      
    </el-container>
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

  a {
    color: white;
    text-decoration: none;
  }

  .aside {
    width: 220px;
    border-right: 1px solid #ccc;
    height: 730px;
  }
</style>
