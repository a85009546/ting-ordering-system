# 點餐系統 ( Ting Ordering System )

這是一個基於 Spring Boot 和 Vue.js 的點餐系統，分為管理端與顧客端。

此專案已經使用 Docker 部署，方便本地和雲端環境運行。

---

## 部署與運行

##### 前提條件

* 安裝 [Docker](https://www.docker.com/get-started) 
* 安裝 [Docker Compose](https://docs.docker.com/compose/install/)

**運行專案**

1. 克隆專案

```bash
git clone https://github.com/a85009546/ting-ordering-system.git
cd ting-ordering-system
```

2. 將放在`ting-ordering-system\backend\ting-server\src\main\resources` 的配置文件`application-example.yml`  改名為 `application-prod.yml`，並將阿里云的 `access-key-id` 與 `access-key-secrect` 改成自己的。
   沒有阿里雲的話，將文件改名為 `application-prod.yml`即可，除了圖片上傳功能以外，其他功能可以正常運行。
3. 使用 Docker Compose 啟動前後端容器：

```bash
# 在 ting-ordering-system 目錄下執行指令
docker-compose up --build
```

4. 這會構建並啟動前端和後端服務以及初始化數據庫，並且你可以在 http://localhost 訪問應用。
5. 停止容器：

```bash
docker-compose down
```



---

## 主要功能

- **管理端 - 管理者、員工**

  - 訂單管理
  - 餐點管理
  - 分類管理
  - 餐點瀏覽

  - 員工管理
  - 數據統計
  - 運營報表導出
  - 來單提醒

- 顧客端

  - 餐點瀏覽
  - 購物車
  - 地址管理
  - 查看歷史訂單
  - 下單
  - 催單 
  - 再來一單

- **通用**

  - 用戶註冊與登入
  - 個人中心
  - 支援文件上傳 ( 圖片 )

---

## 技術棧

- **前端** : Vue.js、Element-Plus、Apache ECharts
- **後端** : Spring Boot、Spring MVC、Spring Task、JWT、阿里雲 OSS、POI、WebSocket
- **數據存儲** : MySQL、Redis
- **容器化** : Docker
- **工具** : Git、Maven、Junit、Apifox
- **其他** : Nginx



---

