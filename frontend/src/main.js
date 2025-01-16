import { createApp } from 'vue'

import App from './App.vue'
import router from './router'
import ElementPlus from 'element-plus'
import 'element-plus/dist/index.css'
import zhTw from 'element-plus/es/locale/lang/zh-tw'
import { createPinia } from 'pinia'
import piniaPluginPersistedstate from 'pinia-plugin-persistedstate'
// 導入以下套件才能使用 icon，並且要加下面那個for迴圈
import * as ElementPlusIconsVue from '@element-plus/icons-vue'

import './assets/main.css'

const app = createApp(App)
const pinia = createPinia()
// const persist = createPersistedState()

app.use(router)
app.use(pinia)
pinia.use(piniaPluginPersistedstate)
app.use(ElementPlus, {locale: zhTw})
for (const [key, component] of Object.entries(ElementPlusIconsVue)) {
  app.component(key, component)
}
app.mount('#app')