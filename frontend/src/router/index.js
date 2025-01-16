import { createRouter, createWebHistory } from 'vue-router'

import LayoutView from '@/views/layout/index.vue'
import LoginView from '@/views/login/index.vue'
import IndexView from '@/views/index/index.vue'
import DashboardView from '@/views/admin/dashboard/index.vue'
import OrderView from '@/views/admin/order/index.vue'
import CategoryView from '@/views/admin/category/index.vue'
import EmpView from '@/views/admin/emp/index.vue'
import MealView from '@/views/admin/meal/index.vue'


const routes = [
  { path: '/login', name: 'login', component: LoginView},

  { path: '/', name: 'layout', component: LayoutView, redirect: '/index', // 重定向
    children: [
      { path: '/index', name: 'index', component: IndexView},
      { path: '/dashboard', name: 'dashboard', component: DashboardView},
      { path: '/order', name: 'order', component: OrderView},
      { path: '/category', name: 'category', component: CategoryView},
      { path: '/employee', name: 'employee', component: EmpView},
      { path: '/meal', name: 'meal', component: MealView},
    ]
  }
]


const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: routes,
})

export default router