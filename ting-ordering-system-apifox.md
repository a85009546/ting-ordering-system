---
title: Web開發-AI
language_tabs:
  - shell: Shell
  - http: HTTP
  - javascript: JavaScript
  - ruby: Ruby
  - python: Python
  - php: PHP
  - java: Java
  - go: Go
toc_footers: []
includes: []
search: true
code_clipboard: true
highlight_theme: darkula
headingLevel: 2
generator: "@tarslib/widdershins v4.0.29"

---

# Web開發-AI

Base URLs:

# Authentication

# Ting Ordering System/管理端/員工管理

## POST 新增員工

POST /admin/employee

> Body 请求参数

```json
{
  "account": "Tom",
  "name": "湯姆",
  "phone": "0937492741",
  "sex": "1"
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|token|header|string| 是 |none|
|body|body|object| 否 |none|
|» account|body|string| 是 |none|
|» name|body|string| 是 |none|
|» phone|body|string| 是 |none|
|» sex|body|string| 是 |none|

> 返回示例

```json
{
  "code": 1,
  "msg": null,
  "data": null
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

状态码 **200**

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|» code|integer|true|none||none|
|» msg|null|true|none||none|
|» data|null|true|none||none|

## PUT 編輯員工數據

PUT /admin/employee

> Body 请求参数

```json
{
  "id": 23,
  "account": "Tom",
  "name": "湯姆貓",
  "phone": "0912345678",
  "sex": "1"
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|token|header|string| 否 |none|
|body|body|object| 否 |none|
|» id|body|integer| 是 |none|
|» account|body|string| 是 |none|
|» name|body|string| 是 |none|
|» phone|body|string| 是 |none|
|» sex|body|string| 是 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

## DELETE 刪除員工

DELETE /admin/employee

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|id|query|string| 是 |none|
|token|header|string| 否 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

## GET 員工分頁查詢

GET /admin/employee/page

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|account|query|string| 是 |none|
|name|query|string| 是 |none|
|phone|query|string| 是 |none|
|sex|query|string| 是 |none|
|page|query|string| 是 |none|
|pageSize|query|string| 是 |none|
|token|header|string| 是 |none|

> 返回示例

```json
{
  "code": 1,
  "msg": null,
  "data": {
    "total": 1,
    "records": [
      {
        "id": 24,
        "name": "湯姆12",
        "account": "Tom12",
        "phone": "0937492741",
        "sex": "1",
        "updateTime": "2025-01-14 11:24"
      }
    ]
  }
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

状态码 **200**

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|» code|integer|true|none||none|
|» msg|null|true|none||none|
|» data|object|true|none||none|
|»» total|integer|true|none||none|
|»» records|[object]|true|none||none|
|»»» id|integer|false|none||none|
|»»» name|string|false|none||none|
|»»» account|string|false|none||none|
|»»» phone|string|false|none||none|
|»»» sex|string|false|none||none|
|»»» updateTime|string|false|none||none|

## GET 根據id查詢員工

GET /admin/employee/{id}

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|id|path|string| 是 |none|
|token|header|string| 否 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

# Ting Ordering System/管理端/分類管理

## POST 新增分類

POST /admin/category

> Body 请求参数

```json
{
  "name": "魚類"
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|token|header|string| 否 |none|
|body|body|object| 否 |none|
|» name|body|string| 是 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

## PUT 編輯分類

PUT /admin/category

> Body 请求参数

```json
{
  "id": 20,
  "name": "海鮮燉飯類",
  "status": "1"
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|token|header|string| 否 |none|
|body|body|object| 否 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

## DELETE 刪除分類

DELETE /admin/category

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|id|query|string| 是 |none|
|token|header|string| 否 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

## GET 查詢全部分類

GET /admin/category

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|token|header|string| 否 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

## GET 分類的條件分頁查詢

GET /admin/category/page

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|name|query|string| 是 |none|
|status|query|string| 是 |none|
|page|query|string| 是 |none|
|pageSize|query|string| 是 |none|
|token|header|string| 否 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

## POST 修改分類狀態

POST /admin/category/status/{status}

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|status|path|string| 是 |none|
|id|query|number| 是 |none|
|token|header|string| 否 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

## GET 根據id查詢分類

GET /admin/category/{id}

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|id|path|string| 是 |none|
|token|header|string| 否 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

# Ting Ordering System/管理端/餐點管理

## POST 新增餐點

POST /admin/meal

> Body 请求参数

```json
{
  "name": "蜂蜜烏龍123",
  "categoryId": 5,
  "price": 45,
  "mealFlavors": [
    {
      "name": "溫度",
      "value": "['熱飲','常溫','去冰','少冰','多冰']"
    }
  ],
  "image": "https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/889b2503-2ab7-421f-a5c5-c221850b2c1b.png",
  "description": "清爽微甜的蜂蜜烏龍123"
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|token|header|string| 否 |none|
|body|body|object| 否 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

## DELETE 批次刪除餐點

DELETE /admin/meal

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|ids|query|string| 是 |none|
|token|header|string| 否 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

## PUT 編輯餐點

PUT /admin/meal

> Body 请求参数

```json
{
  "id": 25,
  "name": "蜂蜜烏龍1",
  "categoryId": 5,
  "price": 45,
  "mealFlavors": [
    {
      "name": "溫度",
      "value": "['熱飲','常溫','去冰','少冰','多冰']"
    },
    {
      "name": "甜度",
      "value": "['無糖','少糖','半糖','多糖','全糖']"
    }
  ],
  "image": "https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/889b2503-2ab7-421f-a5c5-c221850b2c1b.png",
  "description": "清爽微甜的蜂蜜烏龍1"
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|token|header|string| 否 |none|
|body|body|object| 否 |none|
|» id|body|integer| 是 |none|
|» name|body|string| 是 |none|
|» categoryId|body|integer| 是 |none|
|» price|body|integer| 是 |none|
|» mealFlavors|body|[object]| 是 |none|
|»» name|body|string| 是 |none|
|»» value|body|string| 是 |none|
|» image|body|string| 是 |none|
|» description|body|string| 是 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

## GET 餐點的條件分頁查詢

GET /admin/meal/page

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|name|query|string| 是 |none|
|categoryId|query|string| 是 |none|
|status|query|string| 是 |none|
|page|query|string| 是 |none|
|pageSize|query|string| 是 |none|
|token|header|string| 否 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

## GET 根據id查詢餐點

GET /admin/meal/{id}

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|id|path|string| 是 |none|
|token|header|string| 是 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

## POST 修改餐點狀態

POST /admin/meal/status/{status}

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|status|path|string| 是 |none|
|id|query|string| 否 |none|
|token|header|string| 是 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

# Ting Ordering System/管理端/店家營業狀態

## PUT 設置營業狀態

PUT /admin/shop/{status}

> Body 请求参数

```json
{}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|status|path|string| 是 |none|
|token|header|string| 否 |none|
|body|body|object| 否 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

## GET 管理端查詢營業狀態

GET /admin/shop/status

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|token|header|string| 否 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

# Ting Ordering System/管理端/訂單管理

## GET 訂單條件分頁查詢

GET /admin/order/conditionSearch

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|beginTime|query|string| 否 |none|
|endTime|query|string| 否 |none|
|number|query|string| 否 |none|
|phone|query|string| 否 |none|
|userId|query|string| 否 |none|
|page|query|string| 否 |none|
|pageSize|query|string| 否 |none|
|token|header|string| 是 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

## GET 各個狀態的訂單數量統計

GET /admin/order/statistics

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|token|header|string| 是 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

## GET 查詢訂單詳情

GET /admin/order/details/{id}

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|id|path|string| 是 |none|
|token|header|string| 是 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

## PUT 接單

PUT /admin/order/confirm

> Body 请求参数

```json
{
  "id": 2
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|token|header|string| 是 |none|
|body|body|object| 否 |none|
|» id|body|integer| 是 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

## PUT 拒單

PUT /admin/order/rejection

> Body 请求参数

```json
{
  "id": 2,
  "rejectionReason": "顧客為黑名單"
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|token|header|string| 是 |none|
|body|body|object| 否 |none|
|» id|body|integer| 是 |none|
|» rejectionReason|body|string| 是 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

## PUT 取消訂單

PUT /admin/order/cancel

> Body 请求参数

```json
{
  "id": 3,
  "cancelReason": "食材不足"
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|token|header|string| 是 |none|
|body|body|object| 否 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

## PUT 派送訂單

PUT /admin/order/delivery/{id}

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|id|path|string| 是 |none|
|token|header|string| 是 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

## PUT 完成訂單

PUT /admin/order/complete/{id}

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|id|path|string| 是 |none|
|token|header|string| 是 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

# Ting Ordering System/管理端/數據統計

## GET 營業額統計

GET /admin/report/turnoverStatistics

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|begin|query|string| 是 |none|
|end|query|string| 是 |none|
|token|header|string| 是 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

## GET 顧客統計

GET /admin/report/customerStatistics

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|begin|query|string| 否 |none|
|end|query|string| 否 |none|
|token|header|string| 是 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

## GET 訂單統計

GET /admin/report/ordersStatistics

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|begin|query|string| 否 |none|
|end|query|string| 否 |none|
|token|header|string| 是 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

## GET 銷量排名統計

GET /admin/report/top10

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|begin|query|string| 是 |none|
|end|query|string| 是 |none|
|token|header|string| 是 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

# Ting Ordering System/顧客端/餐點瀏覽

## GET 根據分類id查詢餐點，分頁查詢

GET /customer/meal/page

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|categoryId|query|string| 是 |none|
|page|query|string| 是 |none|
|pageSize|query|string| 是 |none|
|token|header|string| 否 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

## GET 根據分類id查詢餐點

GET /customer/meal/list

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|categoryId|query|string| 是 |none|
|token|header|string| 否 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

# Ting Ordering System/顧客端/購物車

## POST 添加餐點至購物車

POST /customer/shoppingCart/add

> Body 请求参数

```json
{
  "mealId": 30,
  "mealFlavor": "常溫"
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|mealFlavor|query|string| 否 |none|
|token|header|string| 否 |none|
|body|body|object| 否 |none|
|» mealId|body|integer| 是 |none|
|» mealFlavors|body|string| 是 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

## GET 查看購物車

GET /customer/shoppingCart/list

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|token|header|string| 否 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

## DELETE 清空購物車

DELETE /customer/shoppingCart/clean

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|token|header|string| 否 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

# Ting Ordering System/顧客端/地址管理

## POST 新增地址

POST /customer/addressBook

> Body 请求参数

```json
{
  "sex": "0",
  "phone": "0933345888",
  "cityCode": 3,
  "cityName": "台中",
  "districtCode": 2,
  "districtName": "北區",
  "detail": "大江街2號7F2",
  "label": "家",
  "isDefault": 0
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|token|header|string| 否 |none|
|body|body|object| 否 |none|
|» sex|body|string| 是 |none|
|» phone|body|string| 是 |none|
|» cityCode|body|integer| 是 |none|
|» cityName|body|string| 是 |none|
|» districtCode|body|integer| 是 |none|
|» districtName|body|string| 是 |none|
|» detail|body|string| 是 |none|
|» label|body|string| 是 |none|
|» isDefault|body|integer| 是 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

## PUT 修改地址

PUT /customer/addressBook

> Body 请求参数

```json
{
  "id": 1,
  "sex": "1",
  "phone": "0912345678",
  "cityCode": 2,
  "cityName": "嘉義",
  "districtCode": 1,
  "districtName": "東區",
  "detail": "軍暉街28號3F2",
  "label": "家",
  "isDefault": 0
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|token|header|string| 是 |none|
|body|body|object| 否 |none|
|» id|body|integer| 是 |none|
|» sex|body|string| 是 |none|
|» phone|body|string| 是 |none|
|» cityCode|body|integer| 是 |none|
|» cityName|body|string| 是 |none|
|» districtCode|body|integer| 是 |none|
|» districtName|body|string| 是 |none|
|» detail|body|string| 是 |none|
|» label|body|string| 是 |none|
|» isDefault|body|integer| 是 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

## DELETE 刪除地址

DELETE /customer/addressBook

> Body 请求参数

```json
{}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|id|query|string| 是 |none|
|token|header|string| 是 |none|
|body|body|object| 否 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

## GET 查詢當前用戶所有地址

GET /customer/addressBook/list

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|token|header|string| 否 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

## GET 查詢默認地址

GET /customer/addressBook/default

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|token|header|string| 是 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

## PUT 設置默認地址

PUT /customer/addressBook/default

> Body 请求参数

```json
""
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|id|query|string| 否 |ID 编号|
|token|header|string| 是 |none|
|body|body|object| 否 |none|
|» id|body|integer| 是 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

## GET 根據id查詢地址

GET /customer/addressBook/{id}

> Body 请求参数

```json
{}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|id|path|string| 是 |none|
|token|header|string| 是 |none|
|body|body|object| 否 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

# Ting Ordering System/顧客端/訂單

## POST 顧客下單

POST /customer/order/submit

> Body 请求参数

```json
{
  "addressBookId": 8,
  "amount": "250",
  "remark": "餐具5份",
  "estimatedDeliveryTime": "2025-01-25 13:19:30",
  "deliveryStatus": 1
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|token|header|string| 是 |none|
|body|body|object| 否 |none|
|» addressBookId|body|integer| 是 |none|
|» amount|body|string| 是 |none|
|» remark|body|string| 是 |none|
|» estimatedDeliveryTime|body|string| 是 |none|
|» deliveryStatus|body|integer| 是 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

## PUT 顧客支付

PUT /customer/order/pay/{id}

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|id|path|string| 是 |none|
|token|header|string| 是 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

## GET 歷史訂單分頁查詢

GET /customer/order/historyOrders

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|status|query|string| 是 |none|
|page|query|string| 是 |none|
|pageSize|query|string| 是 |none|
|token|header|string| 是 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

## GET 查詢訂單詳情

GET /customer/order/orderDetail/{id}

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|id|path|string| 是 |none|
|token|header|string| 是 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

## PUT 取消訂單

PUT /customer/order/cancel/{id}

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|id|path|string| 是 |none|
|token|header|string| 是 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

## POST 再來一單

POST /customer/order/repetition/{id}

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|id|path|string| 是 |none|
|token|header|string| 是 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

## GET 催單

GET /customer/order/reminder/{id}

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|id|path|string| 是 |none|
|token|header|string| 否 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

# Ting Ordering System/用戶相關

## POST 註冊

POST /auth/register

> Body 请求参数

```json
{
  "name": "John1234",
  "account": "john1234",
  "password": "123456",
  "phone": "0912345678",
  "sex": "1"
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|object| 否 |none|
|» name|body|string| 是 |none|
|» account|body|string| 是 |none|
|» password|body|string| 是 |none|
|» phone|body|string| 是 |none|
|» sex|body|string| 是 |none|

> 返回示例

```json
{
  "code": 1,
  "msg": null,
  "data": null
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

状态码 **200**

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|» code|integer|true|none||none|
|» msg|null|true|none||none|
|» data|null|true|none||none|

## POST 登入

POST /auth/login

> Body 请求参数

```json
{
  "account": "admin",
  "password": "123456"
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|object| 否 |none|
|» account|body|string| 是 |none|
|» password|body|string| 是 |none|

> 返回示例

```json
{
  "code": 1,
  "msg": null,
  "data": {
    "id": 22,
    "name": "John",
    "account": "john",
    "token": "eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE3MzY4NDAyNTYsInVzZXJJZCI6MjJ9.appiFOMSvtvaGECgorlNBxySaUebZQM-Rfhncmgqtak",
    "menuItems": [
      {
        "id": 7,
        "name": "個人中心",
        "path": "/user/info",
        "level": "1"
      }
    ]
  }
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

状态码 **200**

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|» code|integer|true|none||none|
|» msg|null|true|none||none|
|» data|object|true|none||none|
|»» id|integer|true|none||none|
|»» name|string|true|none||none|
|»» account|string|true|none||none|
|»» token|string|true|none||none|
|»» menuItems|[object]|true|none||none|
|»»» id|integer|false|none||none|
|»»» name|string|false|none||none|
|»»» path|string|false|none||none|
|»»» level|string|false|none||none|

## GET 根據角色獲取選單列表

GET /menu

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|role|query|string| 是 |none|
|token|header|string| 否 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

## GET 根據id查詢用戶

GET /user/{id}

> Body 请求参数

```json
{}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|id|path|string| 是 |none|
|token|header|string| 是 |none|
|body|body|object| 否 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

## PUT 更新用戶資訊

PUT /user

> Body 请求参数

```json
{
  "id": 22,
  "name": "John",
  "account": "john",
  "password": "123456",
  "balance": 3000,
  "phone": "0912345678",
  "sex": "1",
  "avatar": "https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/00eefa20-6860-4a8e-b3bd-17ddec16f9f7.png"
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|token|header|string| 是 |none|
|body|body|object| 否 |none|
|» id|body|integer| 是 |none|
|» name|body|string| 是 |none|
|» account|body|string| 是 |none|
|» password|body|string| 是 |none|
|» balance|body|integer| 是 |none|
|» phone|body|string| 是 |none|
|» sex|body|string| 是 |none|
|» avatar|body|string| 是 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

## PUT 修改密碼

PUT /user/changePassword

> Body 请求参数

```json
{
  "password": "123456",
  "newPassword": "1234567"
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|token|header|string| 是 |none|
|body|body|object| 否 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

## GET 登出

GET /user/logout

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|token|header|string| 是 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

# Ting Ordering System/通用

## POST 文件上傳

POST /upload

> Body 请求参数

```yaml
file: file://C:\Users\MATTWEI\Desktop\图片资源\3.png

```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|token|header|string| 否 |none|
|body|body|object| 否 |none|
|» file|body|string(binary)| 是 |none|

> 返回示例

> 200 Response

```json
{}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|Inline|

### 返回数据结构

# 数据模型

