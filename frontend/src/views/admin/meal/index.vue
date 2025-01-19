<script setup>
import { ref, onMounted } from 'vue'
import { queryListApi as queryCategoryListApi } from '@/api/category'
import { pageQueryApi, updateStatusApi, addApi, queryInfoApi, updateApi, deleteApi } from '@/api/meal'
import { ElMessage, ElMessageBox } from 'element-plus'
// 鉤子
onMounted(() => {
  search()
  // 查詢啟用中的分類數據
  queryCategorys()
})
// 分類列表數據
const categorys = ref([])
// 搜索餐點條件
const searchMeal = ref({name:'', categoryId:'', status:''})
// 接收查詢餐點列表數據
const mealList = ref([])
// 分頁相關
const currentPage = ref(1) 
const pageSize = ref(5) 
const background = ref(true)
const total = ref(0)
//新增/修改表单 餐點數據模型
const meal = ref({
  name: '',
  categoryId: '',
  price: '',
  mealFlavors: [],
  image:'',
  description:''
})
// 定義口味選項
const flavorOptions = ref([
      { name: '溫度', value: "['熱飲', '常溫', '去冰', '少冰', '多冰']"},
      { name: '甜度', value: "['無糖', '少糖', '半糖', '多糖', '全糖']"},
      { name: '忌口', value: "['不要蔥', '不要蒜', '不要香菜']"},
      { name: '辣度', value: "['不辣', '微辣', '中辣', '大辣']"}
])
// 控制彈窗
const dialogVisible = ref(false)
const dialogTitle = ref('新增餐點')
// 表單引入
const mealFormRef = ref()

// 查詢啟用中的分類數據
const queryCategorys = async () => {
  const result = await queryCategoryListApi()
  if(result.code){
    categorys.value = result.data
  }
}
// 查詢
const search = async () => {
  const result = await pageQueryApi(searchMeal.value.name, searchMeal.value.categoryId, searchMeal.value.status, 
                                    currentPage.value, pageSize.value)
  if(result.code === 1){
    mealList.value = result.data.records
    total.value = result.data.total
  }
}
// 清空
const clear = () => {
  searchMeal.value = {name:'', categoryId:'', status:''}
  search()
}
// 每頁展示紀錄數變化
const handleSizeChange = (val) => {
  console.log(`每頁展示 ${val} 項紀錄`)
  search()
}
// 頁碼變化時觸發
const handleCurrentChange = (val) => {
  console.log(`當前頁碼: ${val}`)
  search()
}
// 新增餐點彈出對話框
const addMeal = () => {
  dialogVisible.value = true
  dialogTitle.value = '新增餐點'
  // 清空數據
  meal.value = {
    name: '',
    categoryId: '',
    price: '',
    mealFlavors: [],
    image:'',
    description:''
  }
  // 重置表單提示訊息
  if(mealFormRef.value){
    mealFormRef.value.resetFields()
  }
}

// 修改狀態
const changeStatusById = (id, currentStatus) => {
  const newStatus = currentStatus === 1 ? 0 : 1; // 根據當前狀態切換
  updateStatusApi(id, newStatus).then(result => {
    if(result.code){
      ElMessage.success('修改狀態成功')
      search() // 重新查詢並刷新表格
    } else {
      ElMessage.error(result.msg)
    }
  })
}
//文件上傳
// 圖片上傳成功後觸發
const handleAvatarSuccess = (response) => {
  meal.value.image = response.data
}
// 文件上傳之前觸發
const beforeAvatarUpload = (rawFile) => {
  // 先判斷文件類型是否是圖片
  if (rawFile.type !== 'image/jpeg' && rawFile.type !== 'image/png') {
    ElMessage.error('只支持上傳圖片')
    return false
  } else if (rawFile.size / 1024 / 1024 > 10) {
    ElMessage.error('只能上傳10M以内圖片')
    return false
  }
  return true
}
// 添加口味數據
const addFlavorItem = () => {
  meal.value.mealFlavors.push({name: '', value: ''})
}
// 刪除口味數據
const removeFlavorItem = (index) => {
  meal.value.mealFlavors.splice(index, 1)
}
// 當口味改變時自動更新標籤
const handleFlavorChange = (index) => {
  const selectedFlavor = meal.value.mealFlavors[index].name
  const matchingOption = flavorOptions.value.find(option => option.name === selectedFlavor)
  if(matchingOption){
    meal.value.mealFlavors[index].value = matchingOption.value
  }
}
// 保存餐點，
const save = async () => {
  // 表單校驗
  mealFormRef.value.validate(async valid => {
    if(valid){ // 校驗通過，新增餐點 or 編輯餐點
      let result
      if(meal.value.id){ // 編輯餐點
        result = await updateApi(meal.value)
      }else{ // 新增餐點
        result = await addApi(meal.value)
      }
      if(result.code){
        ElMessage.success('保存成功')
        // 關閉彈框
        dialogVisible.value = false
        search() // 重新查詢並刷新表格
      }else{
        ElMessage.error(result.msg)
      }
    }else{
      ElMessage.error('表單校驗不通過')
    }
  })
}
// 表單校驗規則
const rules = {
  name: [
    { required: true, message: '請輸入餐點名稱', trigger: 'blur' },
    { min: 2, max: 16, message: '餐點名稱長度應為2~16個字符', trigger: 'blur' },
  ],
  categoryId: [
    { required: true, message: '請選擇分類', trigger: 'change' },
  ],
  price: [
    { required: true, message: '請輸入價格', trigger: 'blur' },
    { pattern: /^[1-9]\d*(\.\d{1,2})?$/, message: '請輸入有效的價格，例如: 1 或 1.99', trigger: 'blur' },
  ],
  image: [
    { required: true, message: '請上傳圖片', trigger: 'change' },
  ],
}

// 編輯
const edit = async (id) => {
  const result = await queryInfoApi(id)
  if(result.code){
    dialogVisible.value = true
    dialogTitle.value = '編輯餐點'
    meal.value = result.data
  }
}

// 刪除單個餐點
const deleteById = async (id) => {
  ElMessageBox.confirm('確定刪除此餐點嗎？', '提示',
    { confirmButtonText: '確定', cancelButtonText: '取消', type: 'warning',}
  ).then(async () => { // 確定
    const result = await deleteApi(id)
    if(result.code){
      ElMessage.success('刪除成功')
      search() // 重新查詢並刷新表格
    }
  })
}
// 記錄勾選的id
const selectedIds = ref([])
// 複選框勾選發生變化時觸發 - selection: 當前選中的紀錄 (數組)
const handleSelectionChange = (selection) => {
  selectedIds.value = selection.map(item => {
    return item.id
  })
}
// 批次刪除餐點
const deleteBatch = () => {
  ElMessageBox.confirm('確定刪除這些餐點嗎？', '提示',
    { confirmButtonText: '確定', cancelButtonText: '取消', type: 'warning',}
  ).then(async () => { // 確定
    console.log(selectedIds.value)
    if(selectedIds.value && selectedIds.value.length > 0){ 
      const result = await deleteApi(selectedIds.value)
      if(result.code){
      ElMessage.success('刪除成功')
      search() // 重新查詢並刷新表格
      }
    }else{
      ElMessage.info('您沒有選擇要刪除的餐點')
    }
  }).catch(() => { // 取消
    ElMessage.info('取消刪除')
  })
}
</script>

<template>
  <h1>餐點管理</h1>
  <!-- 搜索欄 -->
  <div class="container">
    <el-form :inline="true" :model="searchMeal" class="demo-form-inline">
      <el-form-item label="餐點名稱" :style="{width: '15%', marginRight: '15px'}">
        <el-input v-model="searchMeal.name" placeholder="請輸入餐點名稱" clearable/>
      </el-form-item>

      <el-form-item label="分類" :style="{width: '15%', marginRight: '15px'}">
        <el-select v-model="searchMeal.categoryId" placeholder="請選擇">
          <el-option v-for="c in categorys" :key="c.id" :label="c.name" :value="c.id" />
        </el-select>
      </el-form-item>

      <el-form-item label="狀態" :style="{width: '15%', marginRight: '15px'}"> 
        <el-select v-model="searchMeal.status" placeholder="請選擇" clearable>
          <el-option label="已下架" value=0 />
          <el-option label="上架中" value=1 />
        </el-select>
      </el-form-item>

      <el-form-item>
        <el-button type="primary" @click="search">查詢</el-button>
        <el-button type="info" @click="clear">清空</el-button>
      </el-form-item>
    </el-form>
  </div>
  
  <!-- 功能按鈕 -->
  <div class="container">
    <el-button type="primary" @click="addMeal"> + 新增餐點</el-button>
    <el-button type="danger" @click="deleteBatch"> - 批次刪除</el-button>
  </div>

  <!-- 表格 -->
  <div class="container">
    <el-table :data="mealList" border style="width: 100%" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center"/>
      <el-table-column type="index" label="序號" width="55" align="center"/>
      <el-table-column prop="name" label="餐點名稱" width="150" align="center"/>
      <el-table-column prop="image" label="圖片" width="150" align="center">
        <template #default="scope">
          <img :src="scope.row.image" height="40px">
        </template>
      </el-table-column>
      <el-table-column prop="categoryName" label="分類" width="150" align="center"/>
      <el-table-column prop="price" label="價格 (元)" width="150" align="center"/>
      <el-table-column prop="status" label="狀態" width="150" align="center">
        <template #default="scope">
          <span :style="{
            color: scope.row.status === 1 ? '#67C23A' : '#F56C6C',
            fontWeight: 'bold'
          }">
            {{ scope.row.status === 1 ? '上架中' : '已下架' }}
          </span>
        </template>
      </el-table-column>
      <el-table-column prop="updateTime" label="最後修改時間"  align="center"/>
      <el-table-column label="操作" align="center">
        <template #default="scope">
          <el-button type="primary" size="small" @click="edit(scope.row.id)"><el-icon><Edit /></el-icon>編輯</el-button>
          <el-button type="danger" size="small" @click="deleteById(scope.row.id)"><el-icon><Delete /></el-icon>刪除</el-button>
          <el-button 
            :type="scope.row.status === 1 ? 'danger' : 'success'"
            size="small"
            @click="changeStatusById(scope.row.id, scope.row.status)"
          >
            {{ scope.row.status === 1 ? '下架' : '上架' }}
          </el-button>
        </template>
      </el-table-column>
    </el-table>
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

  <!-- 新增餐點/編輯餐點 彈出框 -->
  <el-dialog v-model="dialogVisible" :title="dialogTitle" width="40%">
      <el-form :model="meal" :rules="rules" ref="mealFormRef" label-width="150px">
        <!-- 餐點名稱 -->
        <el-row>
          <el-col :span="12">
            <el-form-item label="餐點名稱" prop="name">
              <el-input v-model="meal.name" placeholder="請輸入餐點名稱"></el-input>
            </el-form-item>
          </el-col>
        </el-row>
        <!-- 分類 -->
        <el-row>
          <el-col :span="24">
            <el-form-item label="分類" prop="categoryId">
              <el-select v-model="meal.categoryId" placeholder="請選擇">
                <el-option v-for="c in categorys" :key="c.id" :label="c.name" :value="c.id"/>
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        <!-- 價格 -->
        <el-row>
          <el-col :span="12">
            <el-form-item label="價格 (元)" prop="price">
              <el-input v-model="meal.price" placeholder="請輸入餐點價格"></el-input>
            </el-form-item>
          </el-col>
        </el-row>
        <!-- 口味配置 -->
        <el-row>
          <el-col :span="24">
            <el-form-item label="口味配置" prop="mealFlavors">
              <!-- 新增按鈕 -->
              <el-button type="success" size="small" @click="addFlavorItem">+ 新增口味配置</el-button>
              <!-- 動態生成的口味名與標籤 -->
              <div style="margin-top: 10px;">
                <div v-for="(flavor, index) in meal.mealFlavors" :key="flavor.id" style="margin-bottom: 8px;">
                  <el-row :gutter="8">
                    <!-- 口味名 -->
                    <el-col :span="6">
                      <el-form-item label="口味" label-width="40px">
                        <el-select v-model="flavor.name" placeholder="請選擇" @change="handleFlavorChange(index)">
                          <el-option v-for="option in flavorOptions" :key="option.value.name" :label="option.value.name" :value="option.name"/> 
                        </el-select>
                      </el-form-item>
                    </el-col>
                    <!-- 口味標籤 -->
                    <el-col :span="16">
                      <el-form-item label="標籤" label-width="40px">
                        <el-input placeholder="口味標籤" v-model="flavor.value" :readonly="true"/>
                      </el-form-item>
                    </el-col>
                    <!-- 刪除按鈕 -->
                    <el-col :span="2">
                      <el-button type="danger" icon="Delete" size="mini" @click="removeFlavorItem(index)"></el-button>
                    </el-col>
                  </el-row>
                </div>
              </div>
            </el-form-item>
          </el-col>
        </el-row>
        <!-- 圖片 -->
        <el-row>
          <el-cow :span="20">
            <el-form-item label="餐點圖片" prop="image">
              <el-upload
                class="avatar-uploader"
                action="/api/upload"
                :show-file-list="false"
                :on-success="handleAvatarSuccess"
                :before-upload="beforeAvatarUpload"
                >
                <img v-if="meal.image" :src="meal.image" class="iamge"
                style="width: 200px; height: 120px; object-fit: cover;"/>
                <el-icon v-else class="avatar-uploader-icon"><Plus /></el-icon>
              </el-upload>
            </el-form-item>
          </el-cow>
        </el-row>
        <!-- 餐點簡介 -->
        <el-row>
          <el-col :span="20">
            <el-form-item label="餐點簡介" prop="description">
              <el-input v-model="meal.description" type="textarea" placeholder="請描述餐點，200字以內" maxlength="200"/>
            </el-form-item>
          </el-col>
        </el-row>
        <!-- 底部按钮 -->
        <span class="dialog-footer" style="display: flex; justify-content: flex-end; gap: 8px;">
          <el-button @click="dialogVisible = false">取消</el-button>
          <el-button type="primary" @click="save">保存</el-button>
        </span>

      </el-form>
  </el-dialog>

</template>

<style scoped>
.container {
  margin: 15px 0px;
}
/* 圖片樣式 */
.avatar {
  height: 40px;
}
.avatar-uploader .avatar {
  width: 78px;
  height: 78px;
  display: block;
}
.avatar-uploader .el-upload {
  border: 1px dashed var(--el-border-color);
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  transition: var(--el-transition-duration-fast);
}

.avatar-uploader .el-upload:hover {
  border-color: var(--el-color-primary);
}

.el-icon.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 78px;
  height: 78px;
  text-align: center;
  border-radius: 10px;
  /* 添加灰色的虚线边框 */
  border: 1px dashed var(--el-border-color);
}
</style>