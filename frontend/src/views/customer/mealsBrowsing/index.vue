<script setup>
import { ref, onMounted, inject, watch } from 'vue'
import { queryListForCustomerApi } from '@/api/category' 
import { queryMealListByCategoryIdApi} from '@/api/meal'
import { addToCartApi } from '@/api/shoppingCart'
import { ElMessage } from 'element-plus'
import { useRouter } from 'vue-router'

const router = useRouter()

const shoppingCartItems = inject('shoppingCartItems');
const updateCart = inject('updateCart');

// 餐點分類和餐點列表
const categories = ref([]) // 餐點分類列表
const meals = ref([]) // 餐點列表
const selectedCategory = ref('') // 當前選中的分類
const selectedMeal = ref(null) // 當前選中的餐點
const flavorDialogVisible = ref(false) // 調整口味控制彈框是否可見
const plusDialogVisible = ref(false) // 加號彈框是否可見
const selectedFlavor = ref([]) // 當前選中的口味

watch(shoppingCartItems, (newCartItems) => {
  console.log('購物車更新了:', newCartItems)
  // 可以在此執行其他操作，如重新載入餐點數據
})

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
  const response = await queryMealListByCategoryIdApi(categoryId)
  // 解析每個餐點的 flavor value
  meals.value = response.data.map((meal) => ({
    ...meal,
    mealFlavors: meal.mealFlavors.map((flavor) => ({
      ...flavor,
      parsedValues: parseFlavorValue(flavor.value), // 將 value 轉換為陣列
    })),
  }))
}
// 切換分類
const selectCategory = async (categoryId) => {
  selectedCategory.value = categoryId
  // currentPage.value = 1 // 切換分類時重置到第一頁
  await getMeals(categoryId)
}
// 解析口味數據
const parseFlavorValue = (value) => {
  try {
    // 替換單引號為雙引號，使其成為合法的 JSON 格式
    const jsonString = value.replace(/'/g, '"');
    return JSON.parse(jsonString); // 使用 JSON.parse 解析為陣列
  } catch (error) {
    console.error('解析口味失敗:', value, error);
    return []; // 如果解析失敗，返回空陣列
  }
}
// 點擊調整口味按鈕後，打開口味彈框
const openFlavorDialog = (meal) => {
  selectedMeal.value = meal
  flavorDialogVisible.value = true
  selectedFlavor.value = [] // 預設選中為空
}
// 點擊加號按鈕後，打開確認彈框
const openConfirmDialog = (meal) => {
  selectedMeal.value = meal
  plusDialogVisible.value = true
}
// 處理選擇口味的邏輯
const toggleFlavor = (option) => {
  if (selectedFlavor.value.includes(option)) {
    // 如果已經選中，則移除
    selectedFlavor.value = selectedFlavor.value.filter((flavor) => flavor !== option);
  } else {
    // 如果未選中，則新增
    selectedFlavor.value.push(option);
  }
}
// 加入購物車
const addToCart = async () => {
  const flavorString = selectedFlavor.value.join(', ');
  console.log('加入購物車', {
    mealId: selectedMeal.value.id,
    mealFlavor: flavorString, // 傳遞拼接後的字符串
  })
  console.log('flavorString: ', {flavorString})
  const newCartItem = {
    name: selectedMeal.value.name,
    image: selectedMeal.value.image,
    mealId: selectedMeal.value.id,
    mealFlavor: flavorString,
    number: 1,
    amount: selectedMeal.value.price,
  };
  // 將新餐點加入購物車
  shoppingCartItems.push(newCartItem);

  // 更新購物車
  updateCart(shoppingCartItems);
  // 調用 addToCartApi
  const result = await addToCartApi(newCartItem)
  if(result.code){
    ElMessage.success('成功加入購物車')
  }
  // 關閉彈框
  if(flavorString === ''){
    plusDialogVisible.value = false
  }else{
    flavorDialogVisible.value = false 
  }
  // 清空數據
  selectedFlavor.value = [],
  selectedMeal.value = null
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
                <el-button type="success" size="small" @click="openFlavorDialog(meal)">
                  調整口味
                </el-button>
              </template>
              <template v-else>
                <el-button type="primary" size="small" @click="openConfirmDialog(meal)">
                  +
                </el-button>
              </template>
            </div>
          </div>
        </el-card>
      </div>
    </el-row>
    <p v-else>目前沒有餐點資料。</p>

    <!-- 調整口味彈框 -->
    <el-dialog
      v-model="flavorDialogVisible"
      :title="selectedMeal?.name || ''"
      width="500px"
    >
      <!-- 口味選擇 -->
      <div
        v-for="(flavor, index) in selectedMeal?.mealFlavors"
        :key="index"
      > 
        <p>{{flavor.name}}：</p>
        <div class="flavors">
          <el-button
            v-for="option in flavor.parsedValues || []"
            :key="option"
            :type="selectedFlavor.includes(option) ? 'primary' : 'default'"
            @click="toggleFlavor(option)"
          >
            {{ option }}
          </el-button>
        </div>
      </div>

      <div class="dialog-footer">
        <span>費用：{{ selectedMeal?.price || 0 }} 元</span>
        <el-button type="primary" @click="addToCart">加入購物車</el-button>
      </div>
    </el-dialog>

    <!-- 加號彈框 -->
    <el-dialog
      v-model="plusDialogVisible"
      title="確認加入購物車"
      width="400px"
    >
      <p>是否新增一份 <b>{{ selectedMeal?.name }}</b> 至購物車？</p>
      <div class="dialog-footer">
        <span>金額：{{ selectedMeal?.price || 0 }} 元</span>
        <div>
          <el-button @click="plusDialogVisible = false">否</el-button>
          <el-button type="primary" @click="addToCart">是</el-button>
        </div>
      </div>
    </el-dialog>

  </div>
  
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
@media (max-width: 1200px) {
  .meal-card-container {
    flex: 0 0 calc(33.33% - 10px); /* 每行顯示 3 個 */
  }
}

@media (max-width: 768px) {
  .meal-card-container {
    flex: 0 0 calc(50% - 10px); /* 每行顯示 2 個 */
  }
}

@media (max-width: 480px) {
  .meal-card-container {
    flex: 0 0 calc(100% - 10px); /* 每行顯示 1 個 */
  }
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

.flavors {
  display: flex;
  gap: 10px;
  margin: 10px 0;
}

.dialog-footer {
  display: flex;
  justify-content: space-between;
  margin-top: 20px;
  align-items: center;
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
