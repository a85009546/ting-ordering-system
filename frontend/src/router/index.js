import { createRouter, createWebHistory } from 'vue-router'

import LayoutView from '@/views/layout/index.vue'
import LoginView from '@/views/login/index.vue'
import IndexView from '@/views/index/index.vue'
import DashboardView from '@/views/admin/dashboard/index.vue'
import OrderView from '@/views/admin/order/index.vue'
import CategoryView from '@/views/admin/category/index.vue'
import EmpView from '@/views/admin/emp/index.vue'
import MealView from '@/views/admin/meal/index.vue'
import InfoView from '@/views/info/index.vue'
import MealsBrowsingView from '@/views/customer/mealsBrowsing/index.vue'
import OrderSubmitView from '@/views/customer/orderSubmit/index.vue'
import HistoryOrdersView from '@/views/customer/historyOrders/index.vue'
import ReportView from '@/views/admin/report/index.vue'
import PasswordView from '@/views/password/index.vue'


const routes = [
  { path: '/login', name: 'login', component: LoginView},

  { path: '/', name: 'layout', component: LayoutView, redirect: '/index', // 重定向
    children: [
      { path: '/index', name: 'index', component: IndexView},
      { path: '/admin/dashboard', name: 'dashboard', component: DashboardView},
      { path: '/admin/order', name: 'order', component: OrderView},
      { path: '/admin/category', name: 'category', component: CategoryView},
      { path: '/admin/employee', name: 'employee', component: EmpView},
      { path: '/admin/meal', name: 'meal', component: MealView},
      { path: '/admin/report', name: 'report', component: ReportView},
      { path: '/user/info', name: 'info', component: InfoView},
      { path: '/user/changePassword', name: 'password', component: PasswordView},
      { path: '/customer/meal', name: 'mealsBrowsing', component: MealsBrowsingView},
      { path: '/customer/order/submit', name: 'checkout', component: OrderSubmitView},
      { path: '/customer/order/history', name: 'history', component: HistoryOrdersView},
    ]
  }
]


const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: routes,
})

export default router