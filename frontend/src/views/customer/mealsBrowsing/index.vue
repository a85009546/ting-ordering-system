<script setup>
import { ref, onMounted } from 'vue'
import { queryListForCustomerApi } from '@/api/category' 
import { pageMealListByCategoryIdApi} from '@/api/meal'

// 餐點分類和餐點列表
const categories = ref([]) // 餐點分類列表
const meals = ref([]) // 餐點列表
const selectedCategory = ref('') // 當前選中的分類

// 初始化數據
onMounted(async () => {
  await getCategories()
  if (categories.value.length > 0) {
    selectedCategory.value = categories.value[0].id // 默認選中第一個分類
    await getMeals(selectedCategory.value)
  }
})
// 獲取餐點分類
const getCategories = async () => {
  const response = await queryListForCustomerApi()
  categories.value = response.data
}

// 獲取餐點數據
const getMeals = async (categoryId) => {
  const response = await pageMealListByCategoryIdApi(categoryId)
  console.log(response)
  meals.value = response.data
}

// 切換分類
const selectCategory = async (categoryId) => {
  selectedCategory.value = categoryId
  // currentPage.value = 1 // 切換分類時重置到第一頁
  await getMeals(categoryId)
}

</script>

<template>
  <div class="meal-browser">
    <!-- 分類選擇列 -->
    <el-row class="category-row" type="flex" justify="center" gutter="20">
      <el-button
        v-for="category in categories"
        :key="category.id"
        :type="selectedCategory === category.id ? 'primary' : 'default'"
        @click="selectCategory(category.id)"
      >
        {{ category.name }}
      </el-button>
    </el-row>

    <!-- 餐點卡片 -->
    <el-row class="meal-list" v-if="meals.length > 0" gutter="10" justify="start">
      <div
        v-for="meal in meals"
        :key="meal.id"
        :xs="24"
        :sm="12"
        :md="8"
        :lg="4.8"
        class="meal-card-container"
      >
        <el-card class="meal-card" shadow="always">
          <div class="meal-image-container">
            <img 
              v-if="meal.image" 
              :src="meal.image" 
              alt="meal image" 
              class="meal-image" 
            />
            <div v-else class="placeholder-image">無圖片</div>
          </div>
          <h3 class="meal-name">{{ meal.name }}</h3>
          <p class="meal-description">{{ meal.description }}</p>
          <div class="meal-info">
            <div class="info-left">
              <p>費用：{{ meal.price }} 元</p>
              <p>月銷量：{{ meal.sales }} 份</p>
            </div>
            <div class="info-right">
              <template v-if="meal.mealFlavors && meal.mealFlavors.length > 0">
                <el-button type="success" size="mini" @click="addFlavor(meal)">
                  調整口味
                </el-button>
              </template>
              <template v-else>
                <el-button type="primary" size="mini" @click="addMeal(meal)">
                  +
                </el-button>
              </template>
            </div>
          </div>
        </el-card>
      </div>
    </el-row>

    <p v-else>目前沒有餐點資料。</p>
  </div>

  <!-- 口味調整彈框 -->
  

</template>


<style scoped>

.meal-browser {
  padding: 20px;
  margin-bottom: 30px;
}

.category-row {
  margin-bottom: 20px;
}

.meal-list {
  display: flex;
  flex-wrap: wrap;
  gap: 10px; /* 卡片間距 */
  justify-content: flex-start;  /* 靠左對齊 */
}

.meal-card-container {
  flex: 0 0 calc(20% - 10px); /* 每行展示 5 張卡片 */
  box-sizing: border-box;
}

.meal-card {
  height: 350px; /* 固定卡片高度 */
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  padding: 10px;
  box-sizing: border-box;
  background-color: #fff; /* 卡片背景颜色 */
  border-radius: 4px;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1)
}

.meal-image-container {
  width: 100%;
  height: 180px; /* 固定圖片容器高度 */
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: #f5f5f5;
  border-radius: 4px;
  margin-bottom: 10px;
}

.meal-image {
  max-width: 100%;
  max-height: 100%;
  object-fit: cover; /* 確保圖片缩放时不變形 */
  border-radius: 4px;
}

.placeholder-image {
  color: #bbb;
  font-size: 14px;
  text-align: center;
}

.meal-name {
  font-size: 16px;
  font-weight: bold;
  margin: 5px 0;
  text-align: center;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.meal-description {
  font-size: 14px;
  color: #606266;
  margin: 5px 0;
  height: 40px; /* 固定描述區域高度 */
  overflow: hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 2; /* 顯示兩行文字，超出部分用省略號 */
  -webkit-box-orient: vertical;
}

.meal-info {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.info-left {
  font-size: 12px;
  color: #606266;
}

.info-right {
  display: flex;
  align-items: center;
}

</style>

