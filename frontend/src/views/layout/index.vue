<script setup>
import { ref, onMounted, watch } from 'vue'
import { useRouter } from 'vue-router'
import { getMenuApi } from '@/api/menu'

const menuList = ref([])
const router = useRouter()
const activeMenuItem = ref('/meal')

const navigateToPath = (path) => {
  router.push(path)
}
// 獲得選單數據
onMounted(async () => {
  const response = await getMenuApi()
  menuList.value = response.data
  console.log(menuList.value)
  console.log(menuList.value[0])

})

// 監視路由變化並更新選單
watch(
  () => router.currentRoute.value.path,
  (newPath) => {
    const validPaths = ['/admin/meal', '/user/meal']
    if(validPaths.includes(newPath)){
      activeMenuItem.value = newPath
    }
  },
)
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
