import { fileURLToPath, URL } from 'node:url'

import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [vue()],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url))
    }
  },
  server: {
    proxy: {
      '/api': { // 匹配所有以 /api 開頭的請求
        target: 'http://localhost:8080', // 將請求轉發到 http://localhost:8080，也就是後端伺服器的ip地址
        changeOrigin: true, // 是否修改源
        rewrite: (path) => path.replace(/^\/api/, '')
      }
    }
  }
})
