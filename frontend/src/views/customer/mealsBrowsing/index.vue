<script setup>
import { ref, onMounted } from 'vue'
import { queryListForCustomerApi } from '@/api/category' 
import { pageQueryByCategoryIdApi} from '@/api/meal'

// 餐點分類和餐點列表
const categories = ref([]) // 餐點分類列表
const meals = ref([]) // 餐點列表
const selectedCategory = ref('') // 當前選中的分類

// 分頁相關
const currentPage = ref(1) 
const pageSize = ref(5) 
const background = ref(true)
const total = ref(0)

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
  const response = await pageQueryByCategoryIdApi(categoryId, currentPage.value, pageSize.value)
  console.log(response)
  meals.value = response.data.records
  total.value = response.data.total
}

// 切換分類
const selectCategory = async (categoryId) => {
  selectedCategory.value = categoryId
  currentPage.value = 1 // 切換分類時重置到第一頁
  await getMeals(categoryId)
}

// 調整口味
const adjustFlavor = (meal) => {
  console.log(`調整口味: ${meal.name}`)
  // 彈窗或其他操作
}
// 處理分頁事件
const handleSizeChange = async (newSize) => {
  pageSize.value = newSize
  await getMeals(selectedCategory.value) // 加載當前分類的新分頁數據
}

const handleCurrentChange = async (newPage) => {
  currentPage.value = newPage
  await getMeals(selectedCategory.value) // 加載當前分類的新分頁數據
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
    {{meals}}
    <!-- 餐點卡片 -->
    <el-row class="meal-list" v-if="meals.length > 0" gutter="20">
      <el-col
        v-for="meal in meals"
        :key="meal.id"
        :xs="24"
        :sm="12"
        :md="8"
        :lg="6"
      >
        <el-card class="meal-card" shadow="always">
          <img :src="meal.image" alt="meal image" class="meal-image" />
          <h3 class="meal-name">{{ meal.name }}</h3>
          <div class="meal-info">
            <div class="info-left">
              <p>費用：{{ meal.price }} 元</p>
              <p>月銷量：{{ meal.sales }} 份</p>
            </div>
            <div class="info-right">
              <el-button type="success" size="mini" @click="adjustFlavor(meal)">
                調整口味
              </el-button>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <p v-else>目前沒有餐點資料。</p>
  </div>

  <!-- 分頁條 -->
  <div class="container">
    <el-pagination
      v-model:current-page="currentPage"
      v-model:page-size="pageSize"
      :page-sizes="[5, 10, 20, 30, 40]"
      :background="background"
      layout="total, sizes, prev, pager, next, jumper"
      :total="total"
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
    />
  </div>

</template>


<style scoped>

.meal-browser {
  padding: 20px;
}

.category-row {
  margin-bottom: 20px;
}

.meal-list {
  display: flex;
  flex-wrap: wrap;
}

.meal-card {
  margin-bottom: 20px;
}

.meal-image {
  width: 100%;
  height: 150px;
  object-fit: cover;
  border-radius: 4px;
  margin-bottom: 10px;
}

.meal-name {
  font-size: 18px;
  font-weight: bold;
  margin-bottom: 10px;
  text-align: center;
}

.meal-info {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.info-left {
  font-size: 14px;
  color: #606266;
}

.info-right {
  display: flex;
  align-items: center;
}
</style>

