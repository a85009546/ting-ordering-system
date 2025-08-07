DROP DATABASE IF EXISTS mydb;
CREATE DATABASE mydb DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE mydb;

# 創建 用戶表
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` bigint NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '主鍵',
  `role` varchar(2) NOT NULL COMMENT '角色',
  `name` varchar(32) NOT NULL COMMENT '姓名',
  `account` varchar(32) NOT NULL UNIQUE COMMENT '帳號',
  `password` varchar(64) NOT NULL COMMENT '密碼',
  `balance` DECIMAL(10, 2) DEFAULT NULL COMMENT '餘額，只有顧客才有此項',
  `phone` varchar(10) NOT NULL COMMENT '手機號',
  `sex` varchar(2) NOT NULL COMMENT '性別',
  `avatar` varchar(500) DEFAULT NULL COMMENT '頭像',
  `create_time` datetime DEFAULT NULL COMMENT '註冊時間',
  `update_time` datetime DEFAULT NULL COMMENT '最後登入時間'
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用戶資訊';

# 創建 選單表
DROP TABLE IF EXISTS `menu_item`;
CREATE TABLE menu_item (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT '主鍵',       -- 唯一識別 ID，整數型，並自動遞增
    name VARCHAR(255) NOT NULL COMMENT '選單名稱',              -- 選單名稱，不允許為空
    path VARCHAR(255) NOT NULL COMMENT '前端路徑',               -- 前端路徑，不允許為空
    icon VARCHAR(32) DEFAULT NULL COMMENT '圖示',
    level VARCHAR(2) NOT NULL COMMENT '選單級別',              -- 選單級別，不允許為空
    exclusive tinyint(1) DEFAULT NULL COMMENT '是否為專屬'
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='選單';

# 創建 餐點分類表
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` bigint NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '主键',
  `name` varchar(32) NOT NULL UNIQUE COMMENT '分類名稱',
  `status` int DEFAULT '1' COMMENT '分類狀態 0:禁用，1:啟用',
  `create_time` datetime DEFAULT NULL COMMENT '創建時間',
  `update_time` datetime DEFAULT NULL COMMENT '更新時間'
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='餐點分類';

# 創建 餐點表
DROP TABLE IF EXISTS `meal`;
CREATE TABLE `meal` (
  `id` bigint NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '主鍵',
  `name` varchar(32) NOT NULL UNIQUE COMMENT '餐點名稱',
  `category_id` bigint NOT NULL COMMENT '餐點分類id',
  `price` decimal(10,2) DEFAULT NULL COMMENT '餐點價格',
  `image` varchar(255) DEFAULT NULL COMMENT '餐點圖片',
  `description` varchar(255) DEFAULT NULL COMMENT '餐點描述',
  `status` int DEFAULT '1' COMMENT '0 停售 1 販售中',
  `create_time` datetime DEFAULT NULL COMMENT '創建時間',
  `update_time` datetime DEFAULT NULL COMMENT '更新時間'
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='餐點';

# 創建 餐點口味關係表
DROP TABLE IF EXISTS `meal_flavor`;
CREATE TABLE `meal_flavor` (
  `id` bigint NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '主鍵',
  `meal_id` bigint NOT NULL COMMENT '餐點id',
  `name` varchar(32) DEFAULT NULL COMMENT '口味名稱',
  `value` varchar(255) DEFAULT NULL COMMENT '口味數據list'
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='餐點口味關係';

# 創建 購物車表
DROP TABLE IF EXISTS `shopping_cart`;
CREATE TABLE `shopping_cart` (
  `id` bigint NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '主鍵',
  `name` varchar(32) DEFAULT NULL COMMENT '餐點名稱',
  `image` varchar(255) DEFAULT NULL COMMENT '餐點圖片',
  `user_id` bigint NOT NULL COMMENT '顧客id',
  `meal_id` bigint NOT NULL COMMENT '餐點id',
  `meal_flavor` varchar(50) DEFAULT NULL COMMENT '口味',
  `number` int NOT NULL DEFAULT '1' COMMENT '數量',
  `amount` decimal(10,2) NOT NULL COMMENT '金額',
  `create_time` datetime DEFAULT NULL COMMENT '創建時間'
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='購物車';

# 創建 地址簿 表
DROP TABLE IF EXISTS `address_book`;
CREATE TABLE `address_book` (
  `id` bigint NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '主鍵',
  `user_id` bigint NOT NULL COMMENT '用戶id',
  `consignee` varchar(50) DEFAULT NULL COMMENT '聯繫人',
  `sex` varchar(2) DEFAULT NULL COMMENT '性別',
  `phone` varchar(11) NOT NULL COMMENT '手機號碼',
  `city_code` varchar(12) DEFAULT NULL COMMENT '市級編號',
  `city_name` varchar(32) DEFAULT NULL COMMENT '市级名稱',
  `district_code` varchar(12) DEFAULT NULL COMMENT '區级編號',
  `district_name` varchar(32) DEFAULT NULL COMMENT '區级名稱',
  `detail` varchar(200) DEFAULT NULL COMMENT '詳細地址',
  `label` varchar(100) DEFAULT NULL COMMENT '標籤',
  `is_default` tinyint(1) NOT NULL DEFAULT '0' COMMENT '默認 0 否 1 是'
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='地址簿';

# 創建 訂單 表
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` bigint NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '主鍵',
  `number` varchar(50) DEFAULT NULL COMMENT '訂單號碼',
  `status` int NOT NULL DEFAULT '1' COMMENT '訂單狀態 1待支付 2待接單 3已接單 4派送中 5已完成 6已取消',
  `user_id` bigint NOT NULL COMMENT '下單用戶id',
  `address_book_id` bigint NOT NULL COMMENT '地址id',
  `order_time` datetime NOT NULL COMMENT '下單時間',
  `checkout_time` datetime DEFAULT NULL COMMENT '結帳時間',
  `pay_status` tinyint NOT NULL DEFAULT '1' COMMENT '支付狀態 0未支付 1已支付 2退款',
  `amount` decimal(10,2) NOT NULL COMMENT '實收金額',
  `remark` varchar(100) DEFAULT NULL COMMENT '備註',
  `phone` varchar(10) DEFAULT NULL COMMENT '手機號碼',
  `address` varchar(255) DEFAULT NULL COMMENT '地址',
  `user_name` varchar(32) DEFAULT NULL COMMENT '用戶名稱',
  `consignee` varchar(32) DEFAULT NULL COMMENT '收貨人',
  `cancel_reason` varchar(255) DEFAULT NULL COMMENT '訂單取消原因',
  `rejection_reason` varchar(255) DEFAULT NULL COMMENT '拒單原因',
  `cancel_time` datetime DEFAULT NULL COMMENT '訂單取消時間',
  `estimated_delivery_time` datetime DEFAULT NULL COMMENT '預計送達時間',
  `delivery_status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '配送狀態 1立即送出 0選擇具體時間',
  `delivery_time` datetime DEFAULT NULL COMMENT '送達時間'
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='訂單表';

# 創建 訂單明細 表
DROP TABLE IF EXISTS `order_detail`;
CREATE TABLE `order_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '主鍵',
  `name` varchar(32) DEFAULT NULL COMMENT '餐點名稱',
  `image` varchar(255) DEFAULT NULL COMMENT '餐點圖片',
  `order_id` bigint NOT NULL COMMENT '訂單id',
  `meal_id` bigint DEFAULT NULL COMMENT '餐點id',
  `meal_flavor` varchar(50) DEFAULT NULL COMMENT '口味',
  `number` int NOT NULL DEFAULT '1' COMMENT '數量',
  `amount` decimal(10,2) NOT NULL COMMENT '金額'
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='訂單明細表';

# ------------------------------------ 插入數據 -----------------------------------
# 用戶數據
insert into `user` (id, role, name, account, password, balance, phone, sex, avatar, create_time, update_time)
values  (1, '3', 'matt', 'admin', 'e10adc3949ba59abbe56e057f20f883e', 5845.00, '0912345699', '1', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/99936061-6122-4b8c-a397-fca53cc891d1.png', '2025-01-13 11:20:24', '2025-08-04 21:04:21'),
        (2, '1', '郭靖', 'guojing', 'e10adc3949ba59abbe56e057f20f883e', 2000.00, '0912345678', '1', null, '2025-01-13 11:20:41', '2025-01-13 11:20:41'),
        (3, '1', '黃蓉', 'huangrong', 'e10adc3949ba59abbe56e057f20f883e', 2000.00, '0912345678', '0', null, '2025-01-13 11:20:41', '2025-01-13 11:20:41'),
        (4, '1', '楊過', 'yangguo', 'e10adc3949ba59abbe56e057f20f883e', 2000.00, '0912345678', '1', null, '2025-01-13 11:20:41', '2025-01-13 11:20:41'),
        (5, '1', '小龍女', 'xiaolongnv', 'e10adc3949ba59abbe56e057f20f883e', 2000.00, '0912345678', '0', null, '2025-01-13 11:20:41', '2025-01-13 11:20:41'),
        (6, '1', '洪七公', 'hongqigong', 'e10adc3949ba59abbe56e057f20f883e', 2000.00, '0912345678', '1', null, '2025-01-13 11:20:41', '2025-01-13 11:20:41'),
        (7, '1', '歐陽鋒', 'ouyangfeng', 'e10adc3949ba59abbe56e057f20f883e', 2000.00, '0912345678', '1', null, '2025-01-13 11:20:41', '2025-01-13 11:20:41'),
        (10, '1', '黃藥師', 'huangyaoshi', 'e10adc3949ba59abbe56e057f20f883e', 2000.00, '0912345678', '1', null, '2025-01-13 11:20:41', '2025-01-13 11:20:41'),
        (12, '2', '陸無雙', 'luwushuang', 'e10adc3949ba59abbe56e057f20f883e', 2000.00, '0912345678', '0', null, '2025-01-13 11:20:41', '2025-01-13 11:20:41'),
        (14, '2', '金輪法王', 'jinlunfawang', 'e10adc3949ba59abbe56e057f20f883e', 2000.00, '0912345678', '1', null, '2025-01-13 11:20:41', '2025-01-13 11:20:41'),
        (15, '1', '郭襄', 'guoxiang', 'e10adc3949ba59abbe56e057f20f883e', 2000.00, '0912345678', '0', null, '2025-01-13 11:20:41', '2025-01-13 11:20:41'),
        (22, '1', 'John', 'john', 'e10adc3949ba59abbe56e057f20f883e', 2610.00, '0912345678', '1', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/be87a7c2-e885-4b4f-8ba0-357ec502e4a9.jpg', '2025-01-13 11:57:39', '2025-08-01 01:08:53'),
        (23, '2', '湯姆貓', 'Tom', 'e10adc3949ba59abbe56e057f20f883e', null, '0912345678', '1', null, '2025-01-13 22:50:17', '2025-01-16 23:25:49'),
        (35, '2', 'tiger', 'tiger123', 'e10adc3949ba59abbe56e057f20f883e', 5000.00, '0912345678', '1', null, '2025-01-17 11:02:32', '2025-01-17 11:02:32'),
        (42, '2', 'mmm123', 'mmm123', 'e10adc3949ba59abbe56e057f20f883e', null, '0912345678', '1', null, '2025-01-17 15:20:43', '2025-01-17 15:20:43'),
        (44, '1', 'uuu', 'uuu123', 'e10adc3949ba59abbe56e057f20f883e', 2210.00, '0985426514', '1', null, '2025-01-17 18:31:43', '2025-08-03 20:26:17'),
        (47, '1', '神雕大俠', 'yang', 'e10adc3949ba59abbe56e057f20f883e', 4790.00, '0912345678', '1', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/0c91b88c-cdde-4e36-9de5-3761e32b7428.png', '2025-01-27 23:48:03', '2025-07-31 15:12:42'),
        (48, '2', 'employee', 'employee', 'e10adc3949ba59abbe56e057f20f883e', null, '0912345678', '1', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/54613fd5-fe45-468b-b5f1-a8193b15e187.png', '2025-02-08 14:37:20', '2025-04-18 20:54:54'),
        (49, '1', 'customer', 'customer', 'e10adc3949ba59abbe56e057f20f883e', 3210.00, '0912345678', '0', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/d50c7805-a0a7-45f2-9e40-b3e7b0be88f7.png', '2025-03-27 14:40:08', '2025-07-31 15:09:48'),
        (50, '2', 'alani', 'employee123', 'e10adc3949ba59abbe56e057f20f883e', null, '0912345678', '0', null, '2025-07-29 17:32:11', '2025-07-29 17:32:11'),
        (51, '1', 'test01', 'test01', 'e10adc3949ba59abbe56e057f20f883e', 4740.00, '0912345678', '0', null, '2025-08-01 01:12:11', '2025-08-01 01:12:19'),
        (52, '1', 'test02', 'test02', 'e10adc3949ba59abbe56e057f20f883e', 4737.00, '0912345678', '1', null, '2025-08-01 13:35:39', '2025-08-01 13:35:47'),
        (53, '1', 'test03', 'test03', 'e10adc3949ba59abbe56e057f20f883e', 4680.00, '0912345678', '0', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/d762f3c5-8295-4d19-883d-6540822037b4.jpg', '2025-08-01 13:38:26', '2025-08-01 13:38:35'),
        (54, '1', 'test04', 'test04', 'e10adc3949ba59abbe56e057f20f883e', 4640.00, '0912345678', '1', null, '2025-08-03 20:22:39', '2025-08-03 20:22:44');

# 選單數據
insert into `menu_item` (id, name, path, level, icon, exclusive)
values  (2, '數據統計', '/admin/report', '3', null, 3),
        (3, '訂單管理', '/admin/order', '2', null, null),
        (4, '餐點管理', '/admin/meal', '2', null, null),
        (5, '分類管理', '/admin/category', '2', null, null),
        (6, '員工管理', '/admin/employee', '3', null, 3),
        (7, '個人中心', '/user/info', '1', null, null),
        (8, '餐點瀏覽', '/customer/meal', '1', null, null),
        (10, '歷史訂單', '/customer/order/history', '1', null, 1);

# 餐點分類數據
insert into `category` (id, name, status, create_time, update_time)
values  (1, '魚類', 0, '2025-01-14 14:40:35', '2025-02-08 14:20:58'),
        (2, '開胃菜', 0, '2025-01-01 12:00:00', '2025-02-08 14:21:50'),
        (3, '主菜', 1, '2025-01-02 13:30:00', '2025-01-11 16:00:00'),
        (4, '甜點', 1, '2025-01-03 14:00:00', '2025-01-12 17:00:00'),
        (5, '飲品', 1, '2025-01-04 14:30:00', '2025-01-13 18:00:00'),
        (6, '小吃', 1, '2025-01-05 15:00:00', '2025-01-14 19:00:00'),
        (7, '湯品', 1, '2025-01-06 16:00:00', '2025-01-15 20:00:00'),
        (8, '沙拉', 1, '2025-01-07 17:00:00', '2025-01-16 21:00:00'),
        (9, '麵食', 0, '2025-01-08 18:00:00', '2025-02-08 14:22:34'),
        (10, '燒烤', 1, '2025-01-09 19:00:00', '2025-02-08 14:33:03'),
        (11, '冰品', 1, '2025-01-10 20:00:00', '2025-02-08 14:24:50'),
        (14, '午餐', 0, '2025-01-13 23:00:00', '2025-02-08 14:18:40'),
        (15, '晚餐', 0, '2025-01-14 08:00:00', '2025-02-08 14:18:39'),
        (16, '宵夜', 0, '2025-01-15 09:00:00', '2025-02-08 14:18:36'),
        (23, '西點', 0, '2025-01-14 18:08:23', '2025-01-17 21:44:57'),
        (30, '零食', 1, '2025-02-08 14:17:39', '2025-02-08 14:18:01');

# 餐點數據
insert into `meal` (id, name, category_id, price, image, description, status, create_time, update_time)
values  (2, '蝦餅', 30, 60.00, 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/9d4eba2f-10ea-434a-8672-a6e53b9f27d8.jpg', '香脆的蝦餅佐以特製醬料', 1, '2025-01-01 12:40:00', '2025-02-08 14:18:18'),
        (3, '烤牛排', 3, 350.00, 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/33b21f85-ea65-4bb6-becd-4d21f5b60fc0.jpg', '精選肉質嫩滑的烤牛排', 1, '2025-01-02 13:40:00', '2025-02-08 14:19:22'),
        (5, '巧克力蛋糕', 4, 120.00, 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/34410213-4971-4e4e-815f-41aefb1aa34b.jpg', '濃郁的巧克力風味蛋糕', 1, '2025-01-03 14:40:00', '2025-02-08 14:19:16'),
        (6, '草莓奶酪', 4, 90.00, 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/dadd55a7-8d63-4753-ad63-215a9af12019.jpg', '清新香甜的草莓奶酪', 1, '2025-01-03 14:50:00', '2025-02-08 14:19:10'),
        (7, '檸檬紅茶', 5, 40.00, 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f4efbb29-2859-4f3a-bb77-98e0575a7f5d.jpg', '提神醒腦的檸檬紅茶', 1, '2025-01-04 14:40:00', '2025-02-08 14:19:04'),
        (8, '拿鐵咖啡', 5, 70.00, 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/9f560cac-4ee2-4de0-8455-08bef525b297.jpg', '香濃的義式拿鐵咖啡', 1, '2025-01-04 14:50:00', '2025-02-08 14:19:29'),
        (10, '炸薯條', 6, 60.00, 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/92a8d9af-3471-42d6-805d-5211983ee95f.jpg', '香酥的炸薯條，搭配特製醬料', 1, '2025-01-05 15:50:00', '2025-02-08 14:19:37'),
        (11, '南瓜濃湯', 7, 90.00, 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/8ee334f4-18e9-4002-880a-7837e3798da8.jpg', '濃郁的南瓜濃湯，暖胃又營養', 1, '2025-01-06 16:40:00', '2025-02-08 14:20:02'),
        (12, '洋蔥湯', 7, 80.00, 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/be53a625-910c-4e67-8b5d-bc8f9c70ce89.jpg', '法式經典洋蔥湯，香氣撲鼻', 1, '2025-01-06 16:50:00', '2025-02-08 14:19:47'),
        (14, '水果沙拉', 8, 90.00, 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/60cbe8ff-b697-497b-9475-097268b7fec8.jpg', '清爽的水果沙拉，健康又美味', 1, '2025-01-07 17:50:00', '2025-02-08 14:19:54'),
        (17, '烤雞翅', 6, 120.00, 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/22f6b075-3285-480b-995a-6563bc642446.jpg', '香濃烤雞翅，滿滿的醬香味', 1, '2025-01-09 19:40:00', '2025-02-08 14:20:32'),
        (18, '牛肉串', 10, 150.00, 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f7c3bc3a-994d-4498-9ace-3c3ab5135862.jpg', '多汁的炭烤牛肉串', 1, '2025-01-09 19:50:00', '2025-02-08 14:28:16'),
        (19, '芒果冰沙', 5, 80.00, 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/22c4c9a2-c2f2-49b7-8693-5ab08eacecf3.jpg', '清涼的芒果冰沙，夏日必備', 1, '2025-01-10 20:40:00', '2025-02-08 14:22:48'),
        (20, '草莓聖代', 11, 90.00, 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/54be8604-3f3b-4d9e-b44d-fff4c2f6ac1b.jpg', '香甜的草莓聖代，搭配新鮮水果', 1, '2025-01-10 20:50:00', '2025-02-08 14:22:47'),
        (30, '豆漿', 5, 20.00, 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/b52e3be6-e150-40a4-9796-3d1460dada5d.jpg', '香濃的豆漿', 1, '2025-01-19 15:14:22', '2025-02-08 14:23:36'),
        (31, '牛奶', 5, 23.00, 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/ab0dec6c-3807-4b79-bced-a2856d3b8dfc.jpg', '全脂牛奶，健康滑順', 1, '2025-01-19 15:17:19', '2025-02-08 14:23:58');

# 地址簿數據
insert into `address_book` (id, user_id, consignee, sex, phone, city_code, city_name, district_code, district_name, detail, label, is_default)
values  (3, 1, null, '0', '0912345888', '2', '南投', '2', '西區', '軍暉街282號5F2', '公司', 1),
        (4, 1, null, '0', '0933345888', '3', '台中', '2', '北區', '大江街2號7F2', '家', 0),
        (8, 44, '193', '0', '0912345678', '', '台北', '', '東區', '98號', '', 1),
        (9, 32, '1234', '0', '0912345678', '', '台北', '', '東區', '38號', '', 0),
        (12, 32, '8743', '1', '0937489237', '', '宜蘭', '', '', '大江街98號', '', 0),
        (14, 44, '1234', '1', '0912345678', '', '新北', '', '', '238號2樓', '', 0),
        (15, 44, '1234', '1', '0912345678', '', '新竹', '', '', '232號三樓', '', 0),
        (16, 49, 'abc', '0', '0912345678', '', '台北', '', '東區', '大東路48號', '', 1),
        (17, 47, 'yang', '0', '0912345678', '', '新竹', '', '西區', '小東路28號', '1', 1),
        (18, 22, 'john', '1', '0912345678', '', '嘉義', '', '東區', '輔仁路68號', '', 1),
        (19, 51, 'test01', '0', '0912345678', '', '桃園', '', '北區', '桃子路34號', '', 0),
        (20, 52, 'test02', '1', '0912345678', '', '彰化', '', '西區', '小彰路72號', '', 0),
        (21, 53, 'test03', '1', '0912345678', '', '雲林', '', '東區', '雲中路21號', '', 0),
        (22, 54, 'test04', '1', '0912345678', '', '南投', '', '西區', '小投路63號', '', 1);

# 訂單數據
insert into `orders` (id, number, status, user_id, address_book_id, order_time, checkout_time, pay_status, amount, remark, phone, address, user_name, consignee, cancel_reason, rejection_reason, cancel_time, estimated_delivery_time, delivery_status, delivery_time)
values  (1, '1737553430709', 6, 1, 2, '2025-02-22 21:43:51', null, 2, 140.00, '', '0912345678', null, null, 'asbc', '顧客取消', null, '2025-01-24 18:59:17', '2025-01-22 22:22:05', 1, null),
        (2, '1737555460462', 5, 1, 3, '2025-01-22 22:17:40', null, 0, 240.00, '', '0912345888', null, null, null, '訂單超時，自訂取消', '食材不足', '2025-01-23 14:39:34', '2025-01-22 23:17:10', 1, '2025-02-08 14:29:19'),
        (3, '1737555759564', 5, 1, 2, '2025-01-22 22:22:40', null, 0, 180.00, '', '0912345678', null, null, 'asbc', '食材不足', null, '2025-01-23 14:43:30', '2025-01-22 23:22:05', 1, '2025-01-26 00:04:33'),
        (4, '1737556472155', 6, 1, 3, '2025-02-24 22:34:32', null, 0, 113.00, '', '0912345888', null, null, null, '訂單超時，自訂取消', null, '2025-01-24 18:58:00', '2025-01-22 23:34:15', 1, '2025-01-23 15:00:18'),
        (5, '1737556749599', 6, 1, 2, '2025-01-22 22:39:10', null, 0, 140.00, '', '0912345678', null, null, 'asbc', '訂單超時，自訂取消', null, '2025-01-24 18:58:00', '2025-01-22 23:39:07', 1, '2025-01-23 15:00:30'),
        (6, '1737556832125', 5, 1, 3, '2025-01-22 22:40:32', null, 0, 103.00, '', '0912345888', null, null, null, '訂單超時，自訂取消', null, '2025-01-22 22:56:00', '2025-01-22 23:40:29', 1, '2025-01-23 23:38:29'),
        (7, '1737557051891', 5, 1, 2, '2025-02-27 22:44:12', null, 0, 210.00, '', '0912345678', null, null, 'asbc', '訂單超時，自訂取消', null, '2025-01-22 23:45:00', '2025-01-22 23:44:10', 1, '2025-01-23 23:38:19'),
        (8, '1737557102765', 5, 1, 3, '2025-01-22 22:45:03', null, 0, 190.00, '', '0912345888', null, null, null, '訂單超時，自訂取消', null, '2025-01-24 01:00:00', '2025-01-22 23:45:01', 1, null),
        (9, '1737557406407', 5, 1, 2, '2025-01-22 22:50:06', null, 0, 170.00, '', '0912345678', null, null, 'asbc', '訂單超時，自訂取消', null, '2025-01-24 01:00:00', '2025-01-22 23:50:05', 1, null),
        (10, '1737558020222', 5, 1, 2, '2025-01-22 23:00:20', null, 0, 140.00, '', '0912345678', null, null, 'asbc', '訂單超時，自訂取消', null, '2025-01-22 23:46:00', '2025-01-23 00:00:17', 1, null),
        (11, '1737558150888', 5, 1, 4, '2025-01-22 23:02:31', null, 0, 90.00, '', '0933345888', null, null, null, '訂單超時，自訂取消', null, '2025-01-22 23:46:00', '2025-01-23 00:02:28', 1, null),
        (12, '1737558328724', 5, 1, 3, '2025-01-22 23:05:29', null, 0, 80.00, '', '0912345888', null, null, null, '訂單超時，自訂取消', null, '2025-01-22 23:39:00', '2025-01-23 00:05:27', 1, '2025-01-23 23:38:06'),
        (13, '1737558972114', 5, 1, 2, '2025-02-20 23:16:12', null, 0, 270.00, '', '0912345678', null, null, 'asbc', '訂單超時，自訂取消', null, '2025-01-22 23:46:00', '2025-01-23 00:16:01', 1, null),
        (14, '1737559167650', 6, 1, 3, '2025-01-22 23:19:28', null, 0, 90.00, '', '0912345888', null, null, null, '訂單超時，自訂取消', '休', '2025-01-24 22:42:00', '2025-01-23 00:19:25', 1, null),
        (15, '1737559868627', 6, 1, 2, '2025-01-22 23:31:09', null, 0, 320.00, '', '0912345678', null, null, 'asbc', '訂單超時，自訂取消', '太遠哥各', '2025-01-24 22:42:00', '2025-01-23 00:30:48', 1, null),
        (16, '1737637670396', 6, 1, 4, '2025-01-23 21:07:50', null, 0, 170.00, '11點送來', '0933345888', null, 'matt', null, '訂單超時，自訂取消', '休了', '2025-01-24 22:42:00', null, 0, null),
        (17, '1737638653719', 6, 1, 3, '2025-01-23 21:24:14', null, 0, 485.00, '', '0912345888', '南投西區軍暉街282號5F2', 'matt', null, '訂單超時，自訂取消', '遠到爆', '2025-01-24 22:42:00', '2025-01-23 22:24:10', 1, null),
        (18, '1737650301572', 6, 1, 4, '2025-01-24 00:38:22', null, 0, 173.00, '', '0933345888', '台中北區大江街2號7F2', 'matt', null, '訂單超時，自訂取消', null, '2025-01-24 22:27:00', '2025-01-24 01:38:06', 1, null),
        (19, '1737695301549', 5, 1, 3, '2025-01-24 13:08:22', '2025-01-25 14:25:35', 1, 90.00, '', '0912345888', '南投西區軍暉街282號5F2', 'matt', null, '訂單超時，自訂取消', null, '2025-01-24 22:11:00', '2025-01-24 14:08:16', 1, '2025-02-08 14:29:19'),
        (20, '1737695586051', 6, 1, 3, '2025-02-27 13:13:06', null, 0, 80.00, '', '0912345888', '南投西區軍暉街282號5F2', 'matt', null, '訂單超時，自訂取消', null, '2025-01-24 14:14:00', '2025-01-24 14:13:04', 1, null),
        (21, '1737697169981', 5, 1, 3, '2025-01-24 13:39:30', '2025-01-25 14:24:16', 1, 90.00, '', '0912345888', '南投西區軍暉街282號5F2', 'matt', null, '訂單超時，自訂取消', null, '2025-01-24 22:27:00', '2025-01-24 14:39:27', 1, '2025-02-08 14:29:19'),
        (22, '1737697275139', 5, 1, 3, '2025-01-24 13:41:15', '2025-01-25 14:26:59', 1, 90.00, '', '0912345888', '南投西區軍暉街282號5F2', 'matt', null, '訂單超時，自訂取消', null, '2025-01-24 14:14:00', '2025-01-24 14:41:11', 1, '2025-02-08 14:29:18'),
        (23, '1737697415775', 6, 1, 4, '2025-01-24 13:43:36', null, 0, 80.00, '', '0933345888', '台中北區大江街2號7F2', 'matt', null, '訂單超時，自訂取消', null, '2025-01-24 22:27:00', '2025-01-24 14:43:27', 1, null),
        (24, '1737697716355', 5, 1, 3, '2025-01-24 13:48:36', '2025-01-25 14:23:36', 1, 90.00, '', '0912345888', '南投西區軍暉街282號5F2', 'matt', null, '訂單超時，自訂取消', null, '2025-01-24 22:27:00', '2025-01-24 14:48:31', 1, '2025-02-08 14:29:18'),
        (25, '1737699175999', 5, 1, 3, '2025-01-24 14:12:56', '2025-01-24 14:24:52', 1, 90.00, '', '0912345888', '南投西區軍暉街282號5F2', 'matt', null, null, null, null, '2025-01-24 15:12:53', 1, '2025-01-26 00:04:32'),
        (26, '1737700812717', 6, 1, 3, '2025-03-04 14:40:13', null, 0, 90.00, '', '0912345888', '南投西區軍暉街282號5F2', 'matt', null, '訂單超時，自訂取消', null, '2025-01-24 14:56:00', '2025-01-24 15:40:06', 1, null),
        (27, '1737700998781', 5, 1, 4, '2025-01-24 14:43:19', '2025-01-24 14:43:39', 1, 130.00, '', '0933345888', '台中北區大江街2號7F2', 'matt', null, null, null, null, '2025-01-24 15:43:04', 1, '2025-02-08 14:29:17'),
        (28, '1737701532479', 6, 1, 3, '2025-03-02 14:52:12', null, 0, 125.00, '', '0912345888', '南投西區軍暉街282號5F2', 'matt', null, '訂單超時，自訂取消', null, '2025-02-08 13:33:00', '2025-01-24 15:52:07', 1, null),
        (29, '1737701776354', 5, 1, 3, '2025-01-24 14:56:16', '2025-01-25 14:22:11', 1, 135.00, '', '0912345888', '南投西區軍暉街282號5F2', 'matt', null, '訂單超時，自訂取消', null, '2025-01-24 22:27:00', '2025-01-24 15:56:11', 1, '2025-01-26 00:04:32'),
        (30, '1737702474182', 6, 1, 3, '2025-01-24 15:07:54', '2025-01-24 23:22:15', 1, 140.00, '', '0912345888', '南投西區軍暉街282號5F2', 'matt', null, '訂單超時，自訂取消', null, '2025-02-08 13:33:00', '2025-01-24 16:07:52', 1, null),
        (31, '1737702589198', 6, 1, 3, '2025-01-24 15:09:49', '2025-01-24 23:22:06', 1, 90.00, '', '0912345888', '南投西區軍暉街282號5F2', 'matt', null, '訂單超時，自訂取消', null, '2025-02-08 13:33:00', '2025-01-24 16:09:40', 1, null),
        (32, '1737703701634', 6, 1, 3, '2025-03-08 15:28:22', null, 0, 80.00, '', '0912345888', '南投西區軍暉街282號5F2', 'matt', null, '訂單超時，自訂取消', null, '2025-01-24 22:11:00', '2025-01-24 16:27:46', 1, null),
        (33, '1737723915481', 6, 1, 3, '2025-01-24 21:05:15', '2025-01-24 23:29:16', 1, 670.00, '', '0912345888', '南投西區軍暉街282號5F2', 'matt', null, '訂單超時，自訂取消', null, '2025-02-08 13:33:00', '2025-01-24 22:05:12', 1, null),
        (34, '1737731932240', 5, 1, 3, '2025-01-24 23:18:52', '2025-01-25 14:56:55', 1, 175.00, '', '0912345888', '南投西區軍暉街282號5F2', 'matt', null, null, null, null, '2025-01-25 00:18:50', 1, '2025-01-26 00:04:32'),
        (35, '1737782659604', 5, 1, 3, '2025-01-25 13:24:20', '2025-01-25 14:55:23', 1, 815.00, '', '0912345888', '南投西區軍暉街282號5F2', 'matt', null, null, null, null, '2025-01-25 14:24:14', 1, '2025-01-26 00:04:32'),
        (36, '1737782832891', 5, 1, 3, '2025-01-25 13:27:13', '2025-01-25 14:53:13', 1, 180.00, '', '0912345888', '南投西區軍暉街282號5F2', 'matt', null, null, null, null, null, 0, '2025-01-26 00:04:32'),
        (37, '1737782873838', 5, 1, 3, '2025-03-11 13:27:54', '2025-01-25 14:47:35', 1, 80.00, '', '0912345888', '南投西區軍暉街282號5F2', 'matt', null, null, null, null, '2025-01-25 14:27:50', 1, '2025-01-26 00:04:31'),
        (38, '1737785318050', 5, 1, 3, '2025-01-25 14:08:38', '2025-01-25 14:08:50', 1, 90.00, '', '0912345888', '南投西區軍暉街282號5F2', 'matt', null, null, null, null, '2025-01-25 15:08:34', 1, '2025-01-26 00:04:31'),
        (39, '1737788506506', 5, 44, 8, '2025-03-13 15:01:47', '2025-01-25 15:01:49', 1, 240.00, '', '0912345678', '台北東區98號', 'uuu', '193', null, null, null, '2025-01-25 16:01:44', 1, '2025-02-08 14:29:17'),
        (40, '1737788626881', 5, 44, 8, '2025-01-25 15:03:47', '2025-01-25 15:03:52', 1, 240.00, '', '0912345678', '台北東區98號', 'uuu', '193', null, null, null, '2025-01-25 16:03:45', 1, '2025-02-08 14:29:16'),
        (41, '1737788960606', 5, 44, 8, '2025-01-25 15:09:21', '2025-01-25 15:09:22', 1, 80.00, '', '0912345678', '台北東區98號', 'uuu', '193', null, null, null, '2025-01-25 16:09:15', 1, '2025-02-08 14:29:16'),
        (42, '1737789098870', 5, 44, 8, '2025-03-07 15:11:39', '2025-01-25 15:11:40', 1, 80.00, '', '0912345678', '台北東區98號', 'uuu', '193', null, null, null, '2025-01-25 16:11:37', 1, '2025-02-08 14:29:16'),
        (43, '1737789163924', 5, 44, 8, '2025-01-25 15:12:44', '2025-01-25 15:12:45', 1, 80.00, '', '0912345678', '台北東區98號', 'uuu', '193', null, null, null, '2025-01-25 16:12:42', 1, '2025-02-08 14:29:15'),
        (44, '1737789198363', 5, 44, 8, '2025-01-25 15:13:18', '2025-01-25 15:13:19', 1, 80.00, '', '0912345678', '台北東區98號', 'uuu', '193', null, null, null, '2025-01-25 16:13:17', 1, '2025-02-08 14:29:14'),
        (45, '1737821054230', 5, 1, 3, '2025-01-26 00:04:14', '2025-01-26 00:04:15', 1, 90.00, '', '0912345888', '南投西區軍暉街282號5F2', 'matt', null, null, null, null, '2025-01-26 01:04:12', 1, '2025-01-26 00:04:31'),
        (46, '1742452825698', 5, 44, 14, '2025-03-20 14:40:26', '2025-03-20 14:40:36', 1, 280.00, '', '0912345678', '新北238號2樓', 'uuu', '1234', null, null, null, '2025-03-20 15:39:57', 1, '2025-03-20 20:23:45'),
        (47, '1742453230314', 6, 44, 8, '2025-03-20 14:47:10', null, 0, 53.00, '', '0912345678', '台北東區98號', 'uuu', '193', '訂單超時，自動取消', null, '2025-03-20 19:07:00', '2025-03-20 15:47:08', 1, null),
        (48, '1742470717513', 5, 44, 14, '2025-03-20 19:38:38', '2025-03-20 19:38:38', 1, 470.00, '', '0912345678', '新北238號2樓', 'uuu', '1234', null, null, null, '2025-03-20 20:38:36', 1, '2025-03-20 20:23:44'),
        (49, '1742474001778', 5, 44, 15, '2025-03-20 20:33:22', '2025-03-20 20:33:24', 1, 240.00, '', '0912345678', '新竹232號三樓', 'uuu', '1234', null, null, null, '2025-03-20 21:33:20', 1, '2025-07-28 14:48:13'),
        (50, '1743075193336', 5, 49, 16, '2025-03-27 19:33:13', '2025-03-27 19:39:11', 1, 320.00, '', '0912345678', '台北東區大東路48號', 'customer', 'abc', null, null, null, '2025-03-27 20:33:09', 1, '2025-07-28 14:48:12'),
        (51, '1743075683918', 5, 49, 16, '2025-03-27 19:41:24', '2025-03-27 19:41:25', 1, 470.00, '', '0912345678', '台北東區大東路48號', 'customer', 'abc', null, null, null, '2025-03-27 20:41:22', 1, '2025-04-18 21:01:25'),
        (52, '1743075823317', 6, 49, 16, '2025-03-27 19:43:43', null, 0, 113.00, '', '0912345678', '台北東區大東路48號', 'customer', 'abc', '訂單超時，自動取消', null, '2025-03-27 19:59:00', '2025-03-27 20:43:42', 1, null),
        (53, '1744981165134', 5, 49, 16, '2025-04-18 20:59:25', '2025-04-18 20:59:31', 1, 240.00, '', '0912345678', '台北東區大東路48號', 'customer', 'abc', null, null, null, '2025-04-18 21:59:22', 1, '2025-04-18 21:01:23'),
        (54, '1753685236006', 5, 49, 16, '2025-07-28 14:47:16', '2025-07-28 14:47:23', 1, 90.00, '', '0912345678', '台北東區大東路48號', 'customer', 'abc', null, null, null, '2025-07-28 15:47:13', 1, '2025-07-31 15:10:49'),
        (55, '1753685370262', 5, 49, 16, '2025-07-28 14:49:30', '2025-07-28 14:49:47', 1, 210.00, '', '0912345678', '台北東區大東路48號', 'customer', 'abc', null, null, null, '2025-07-28 15:49:27', 1, '2025-07-31 15:10:48'),
        (56, '1753945821122', 5, 49, 16, '2025-07-31 15:10:21', '2025-07-31 15:10:23', 1, 460.00, '', '0912345678', '台北東區大東路48號', 'customer', 'abc', null, null, null, '2025-07-31 16:10:20', 1, '2025-07-31 15:10:48'),
        (57, '1753946009584', 5, 47, 17, '2025-07-31 15:13:30', '2025-07-31 15:13:31', 1, 210.00, '', '0912345678', '新竹西區小東路28號', '神雕大俠', 'yang', null, null, null, '2025-07-31 16:13:28', 1, '2025-07-31 15:14:07'),
        (58, '1753981796116', 5, 22, 18, '2025-08-01 01:09:56', '2025-08-01 01:09:57', 1, 390.00, '', '0912345678', '嘉義東區輔仁路68號', 'John', 'john', null, null, null, '2025-08-01 02:09:55', 1, '2025-08-01 01:10:20'),
        (59, '1753981986803', 5, 51, 19, '2025-08-01 01:13:07', '2025-08-01 01:13:08', 1, 260.00, '', '0912345678', '桃園北區桃子路34號', 'test01', 'test01', null, null, null, '2025-08-01 02:13:05', 1, '2025-08-01 01:13:18'),
        (60, '1754026624978', 5, 52, 20, '2025-08-01 13:37:05', '2025-08-01 13:37:06', 1, 263.00, '', '0912345678', '彰化西區小彰路72號', 'test02', 'test02', null, null, null, '2025-08-01 14:37:04', 1, '2025-08-01 13:37:38'),
        (61, '1754026770965', 5, 53, 21, '2025-08-01 13:39:31', '2025-08-01 13:39:32', 1, 160.00, '', '0912345678', '雲林東區雲中路21號', 'test03', 'test03', null, null, null, '2025-08-01 14:39:30', 1, '2025-08-01 13:39:50'),
        (62, '1754026816299', 5, 53, 21, '2025-08-01 13:40:16', '2025-08-01 13:40:17', 1, 160.00, '', '0912345678', '雲林東區雲中路21號', 'test03', 'test03', null, null, null, '2025-08-01 14:40:14', 1, '2025-08-01 13:40:28'),
        (63, '1754223806882', 5, 54, 22, '2025-08-03 20:23:27', '2025-08-03 20:23:28', 1, 360.00, '', '0912345678', '南投西區小投路63號', 'test04', 'test04', null, null, null, '2025-08-03 21:23:24', 1, '2025-08-03 20:23:38'),
        (64, '1754223994756', 5, 44, 14, '2025-08-03 20:26:35', '2025-08-03 20:26:36', 1, 300.00, '', '0912345678', '新北238號2樓', 'uuu', '1234', null, null, null, '2025-08-03 21:26:33', 1, '2025-08-03 20:26:41');

# 訂單明細數據
insert into `order_detail` (id, name, image, order_id, meal_id, meal_flavor, number, amount)
values  (1, '炸洋蔥圈', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png', 1, 1, '', 1, 50.00),
        (2, '義大利麵', null, 1, 15, '', 1, 150.00),
        (3, '蝦餅', null, 2, 2, '', 1, 60.00),
        (4, '南瓜濃湯', null, 2, 11, '', 1, 90.00),
        (5, '檸檬紅茶', null, 2, 7, '', 1, 40.00),
        (6, '巧克力蛋糕', null, 2, 5, '', 1, 120.00),
        (7, '烤雞翅', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/30413757-375c-471b-8ae4-15581a729e66.png', 2, 17, '少冰', 1, 120.00),
        (8, '炸洋蔥圈', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png', 3, 1, '', 1, 50.00),
        (9, '凱撒沙拉', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/9399826c-16c8-484d-8d7f-165872bc4b82.png', 3, 13, '', 1, 100.00),
        (10, '炸洋蔥圈', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png', 4, 1, '', 1, 50.00),
        (11, '蝦餅', null, 4, 2, '', 1, 60.00),
        (12, '蝦餅', null, 5, 2, '', 1, 60.00),
        (13, '南瓜濃湯', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/c3830bbb-227b-4098-916c-45001f591c00.png', 5, 11, '', 1, 90.00),
        (14, '蝦餅', null, 6, 2, '', 1, 60.00),
        (15, '草莓奶酪', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/435c06ec-379a-40d0-8617-d7cd30401ced.png', 6, 6, '', 1, 90.00),
        (16, '蝦餅', null, 7, 2, '', 1, 60.00),
        (17, '烤雞翅', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/30413757-375c-471b-8ae4-15581a729e66.png', 7, 17, '去冰', 1, 120.00),
        (18, '拿鐵咖啡', null, 7, 8, '', 1, 70.00),
        (19, '炸洋蔥圈', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png', 8, 1, '', 1, 50.00),
        (20, '南瓜濃湯', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/c3830bbb-227b-4098-916c-45001f591c00.png', 8, 11, '', 1, 90.00),
        (21, '炸洋蔥圈', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png', 1, 1, '', 1, 50.00),
        (22, '蝦餅', null, 1, 2, '', 1, 60.00),
        (23, '蝦餅', null, 2, 2, '', 1, 60.00),
        (24, '炸洋蔥圈', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png', 2, 1, '', 1, 50.00),
        (25, '凱撒沙拉', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/9399826c-16c8-484d-8d7f-165872bc4b82.png', 2, 13, '', 1, 100.00),
        (26, '蝦餅', null, 3, 2, '', 1, 60.00),
        (27, '南瓜濃湯', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/c3830bbb-227b-4098-916c-45001f591c00.png', 3, 11, '', 1, 90.00),
        (28, '蝦餅', null, 4, 2, '', 1, 60.00),
        (29, '牛奶', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/2ff569bb-8edb-4d4d-8d10-2b13745e1e25.png', 4, 31, '', 1, 23.00),
        (30, '炸洋蔥圈', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png', 5, 1, '', 1, 50.00),
        (31, '蝦餅', null, 5, 2, '', 1, 60.00),
        (32, '炸洋蔥圈', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png', 6, 1, '', 1, 50.00),
        (33, '牛奶', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/2ff569bb-8edb-4d4d-8d10-2b13745e1e25.png', 6, 31, '', 1, 23.00),
        (34, '蝦餅', null, 7, 2, '', 1, 60.00),
        (35, '烤雞翅', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/30413757-375c-471b-8ae4-15581a729e66.png', 7, 17, '熱飲', 1, 120.00),
        (36, '蝦餅', null, 8, 2, '', 1, 60.00),
        (37, '凱撒沙拉', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/9399826c-16c8-484d-8d7f-165872bc4b82.png', 8, 13, '', 1, 100.00),
        (38, '炸洋蔥圈', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png', 9, 1, '', 1, 50.00),
        (39, '南瓜濃湯', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/c3830bbb-227b-4098-916c-45001f591c00.png', 9, 11, '', 1, 90.00),
        (40, '蝦餅', null, 10, 2, '', 1, 60.00),
        (41, '炸洋蔥圈', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png', 10, 1, '', 1, 50.00),
        (42, '蝦餅', null, 11, 2, '', 1, 60.00),
        (43, '炸洋蔥圈', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png', 12, 1, '', 1, 50.00),
        (44, '南瓜濃湯', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/c3830bbb-227b-4098-916c-45001f591c00.png', 13, 11, '', 1, 90.00),
        (45, '義大利麵', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/56b204aa-225c-4ed5-8142-75926f38509d.png', 13, 15, '', 1, 150.00),
        (46, '蝦餅', null, 14, 2, '', 1, 60.00),
        (47, '炸洋蔥圈', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png', 15, 1, '', 1, 50.00),
        (48, '烤雞翅', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/30413757-375c-471b-8ae4-15581a729e66.png', 15, 17, '', 1, 120.00),
        (49, '蝦餅', null, 15, 2, '', 2, 60.00),
        (50, '炸洋蔥圈', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png', 16, 1, '', 1, 50.00),
        (51, '南瓜濃湯', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/c3830bbb-227b-4098-916c-45001f591c00.png', 16, 11, '', 1, 90.00),
        (52, '炸洋蔥圈', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png', 17, 1, '', 1, 50.00),
        (53, '烤雞翅', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/30413757-375c-471b-8ae4-15581a729e66.png', 17, 17, '常溫', 2, 120.00),
        (54, '烤雞翅', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/30413757-375c-471b-8ae4-15581a729e66.png', 17, 17, '熱飲', 1, 120.00),
        (55, '蜂蜜烏龍123', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/889b2503-2ab7-421f-a5c5-c221850b2c1b.png', 17, 25, '去冰, 少糖', 1, 45.00),
        (56, '烤雞翅', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/30413757-375c-471b-8ae4-15581a729e66.png', 18, 17, '少冰', 1, 120.00),
        (57, '牛奶', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/2ff569bb-8edb-4d4d-8d10-2b13745e1e25.png', 18, 31, '', 1, 23.00),
        (58, '蝦餅', null, 19, 2, '', 1, 60.00),
        (59, '炸洋蔥圈', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png', 20, 1, '', 1, 50.00),
        (60, '蝦餅', null, 21, 2, '', 1, 60.00),
        (61, '蝦餅', null, 22, 2, '', 1, 60.00),
        (62, '炸洋蔥圈', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png', 23, 1, '', 1, 50.00),
        (63, '蝦餅', null, 24, 2, '', 1, 60.00),
        (64, '蝦餅', null, 25, 2, '', 1, 60.00),
        (65, '蝦餅', null, 26, 2, '', 1, 60.00),
        (66, '凱撒沙拉', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/9399826c-16c8-484d-8d7f-165872bc4b82.png', 27, 13, '', 1, 100.00),
        (67, '炸洋蔥圈', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png', 28, 1, '', 1, 50.00),
        (68, '蜂蜜烏龍123', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/889b2503-2ab7-421f-a5c5-c221850b2c1b.png', 28, 25, '去冰, 少糖', 1, 45.00),
        (69, '蝦餅', null, 29, 2, '', 1, 60.00),
        (70, '蜂蜜烏龍123', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/889b2503-2ab7-421f-a5c5-c221850b2c1b.png', 29, 25, '少冰, 半糖', 1, 45.00),
        (71, '蝦餅', null, 30, 2, '', 1, 60.00),
        (72, '炸洋蔥圈', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png', 30, 1, '', 1, 50.00),
        (73, '蝦餅', null, 31, 2, '', 1, 60.00),
        (74, '炸洋蔥圈', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png', 32, 1, '', 1, 50.00),
        (75, '蝦餅', null, 33, 2, '', 1, 60.00),
        (76, '南瓜濃湯', null, 33, 11, '', 1, 90.00),
        (77, '檸檬紅茶', null, 33, 7, '', 1, 40.00),
        (78, '巧克力蛋糕', null, 33, 5, '', 1, 120.00),
        (79, '烤雞翅', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/30413757-375c-471b-8ae4-15581a729e66.png', 33, 17, '少冰', 1, 120.00),
        (80, '蝦餅', null, 33, 2, '', 1, 60.00),
        (81, '炸洋蔥圈', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png', 33, 1, '', 1, 50.00),
        (82, '凱撒沙拉', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/9399826c-16c8-484d-8d7f-165872bc4b82.png', 33, 13, '', 1, 100.00),
        (83, '炸洋蔥圈', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png', 34, 1, '', 2, 50.00),
        (84, '蜂蜜烏龍123', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/889b2503-2ab7-421f-a5c5-c221850b2c1b.png', 34, 25, '去冰, 多糖', 1, 45.00),
        (85, '炸洋蔥圈', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png', 35, 1, '', 2, 50.00),
        (86, '蜂蜜烏龍123', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/889b2503-2ab7-421f-a5c5-c221850b2c1b.png', 35, 25, '去冰, 多糖', 1, 45.00),
        (87, '蝦餅', null, 35, 2, '', 1, 60.00),
        (88, '南瓜濃湯', null, 35, 11, '', 1, 90.00),
        (89, '檸檬紅茶', null, 35, 7, '', 1, 40.00),
        (90, '巧克力蛋糕', null, 35, 5, '', 1, 120.00),
        (91, '烤雞翅', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/30413757-375c-471b-8ae4-15581a729e66.png', 35, 17, '少冰', 1, 120.00),
        (92, '蝦餅', null, 35, 2, '', 1, 60.00),
        (93, '炸洋蔥圈', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png', 35, 1, '', 1, 50.00),
        (94, '凱撒沙拉', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/9399826c-16c8-484d-8d7f-165872bc4b82.png', 35, 13, '', 1, 100.00),
        (95, '蝦餅', null, 36, 2, '', 1, 60.00),
        (96, '南瓜濃湯', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/c3830bbb-227b-4098-916c-45001f591c00.png', 36, 11, '', 1, 90.00),
        (97, '炸洋蔥圈', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png', 37, 1, '', 1, 50.00),
        (98, '蝦餅', null, 38, 2, '', 1, 60.00),
        (99, '烤雞翅', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/30413757-375c-471b-8ae4-15581a729e66.png', 39, 17, '', 1, 120.00),
        (100, '南瓜濃湯', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/c3830bbb-227b-4098-916c-45001f591c00.png', 39, 11, '', 1, 90.00),
        (101, '烤雞翅', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/30413757-375c-471b-8ae4-15581a729e66.png', 40, 17, '', 1, 120.00),
        (102, '南瓜濃湯', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/c3830bbb-227b-4098-916c-45001f591c00.png', 40, 11, '', 1, 90.00),
        (103, '炸洋蔥圈', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png', 41, 1, '', 1, 50.00),
        (104, '炸洋蔥圈', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png', 42, 1, '', 1, 50.00),
        (105, '炸洋蔥圈', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png', 43, 1, '', 1, 50.00),
        (106, '炸洋蔥圈', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f0f6fb14-6245-4e50-b130-c8aaa40aa62b.png', 44, 1, '', 1, 50.00),
        (107, '蝦餅', null, 45, 2, '', 1, 60.00),
        (108, '草莓奶酪', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/dadd55a7-8d63-4753-ad63-215a9af12019.jpg', 46, 6, '', 1, 90.00),
        (109, '洋蔥湯', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/be53a625-910c-4e67-8b5d-bc8f9c70ce89.jpg', 46, 12, '', 2, 80.00),
        (110, '牛奶', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/ab0dec6c-3807-4b79-bced-a2856d3b8dfc.jpg', 47, 31, '', 1, 23.00),
        (111, '烤牛排', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/33b21f85-ea65-4bb6-becd-4d21f5b60fc0.jpg', 48, 3, '', 1, 350.00),
        (112, '草莓聖代', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/54be8604-3f3b-4d9e-b44d-fff4c2f6ac1b.jpg', 48, 20, '', 1, 90.00),
        (113, '巧克力蛋糕', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/34410213-4971-4e4e-815f-41aefb1aa34b.jpg', 49, 5, '', 1, 120.00),
        (114, '水果沙拉', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/60cbe8ff-b697-497b-9475-097268b7fec8.jpg', 49, 14, '', 1, 90.00),
        (115, '烤雞翅', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/22f6b075-3285-480b-995a-6563bc642446.jpg', 50, 17, '微辣', 1, 120.00),
        (116, '洋蔥湯', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/be53a625-910c-4e67-8b5d-bc8f9c70ce89.jpg', 50, 12, '', 1, 80.00),
        (117, '水果沙拉', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/60cbe8ff-b697-497b-9475-097268b7fec8.jpg', 50, 14, '', 1, 90.00),
        (118, '烤牛排', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/33b21f85-ea65-4bb6-becd-4d21f5b60fc0.jpg', 51, 3, '', 1, 350.00),
        (119, '草莓聖代', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/54be8604-3f3b-4d9e-b44d-fff4c2f6ac1b.jpg', 51, 20, '', 1, 90.00),
        (120, '牛奶', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/ab0dec6c-3807-4b79-bced-a2856d3b8dfc.jpg', 52, 31, '', 1, 23.00),
        (121, '炸薯條', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/92a8d9af-3471-42d6-805d-5211983ee95f.jpg', 52, 10, '', 1, 60.00),
        (122, '草莓奶酪', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/dadd55a7-8d63-4753-ad63-215a9af12019.jpg', 53, 6, '', 1, 90.00),
        (123, '烤雞翅', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/22f6b075-3285-480b-995a-6563bc642446.jpg', 53, 17, '中辣', 1, 120.00),
        (124, '炸薯條', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/92a8d9af-3471-42d6-805d-5211983ee95f.jpg', 54, 10, '', 1, 60.00),
        (125, '草莓奶酪', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/dadd55a7-8d63-4753-ad63-215a9af12019.jpg', 55, 6, '', 1, 90.00),
        (126, '水果沙拉', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/60cbe8ff-b697-497b-9475-097268b7fec8.jpg', 55, 14, '', 1, 90.00),
        (127, '烤牛排', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/33b21f85-ea65-4bb6-becd-4d21f5b60fc0.jpg', 56, 3, '', 1, 350.00),
        (128, '芒果冰沙', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/22c4c9a2-c2f2-49b7-8693-5ab08eacecf3.jpg', 56, 19, '', 1, 80.00),
        (129, '草莓奶酪', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/dadd55a7-8d63-4753-ad63-215a9af12019.jpg', 57, 6, '', 1, 90.00),
        (130, '草莓聖代', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/54be8604-3f3b-4d9e-b44d-fff4c2f6ac1b.jpg', 57, 20, '', 1, 90.00),
        (131, '巧克力蛋糕', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/34410213-4971-4e4e-815f-41aefb1aa34b.jpg', 58, 5, '', 1, 120.00),
        (132, '牛肉串', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f7c3bc3a-994d-4498-9ace-3c3ab5135862.jpg', 58, 18, '', 1, 150.00),
        (133, '草莓聖代', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/54be8604-3f3b-4d9e-b44d-fff4c2f6ac1b.jpg', 58, 20, '', 1, 90.00),
        (134, '洋蔥湯', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/be53a625-910c-4e67-8b5d-bc8f9c70ce89.jpg', 59, 12, '', 1, 80.00),
        (135, '南瓜濃湯', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/8ee334f4-18e9-4002-880a-7837e3798da8.jpg', 59, 11, '', 1, 90.00),
        (136, '蝦餅', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/9d4eba2f-10ea-434a-8672-a6e53b9f27d8.jpg', 59, 2, '', 1, 60.00),
        (137, '炸薯條', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/92a8d9af-3471-42d6-805d-5211983ee95f.jpg', 60, 10, '', 1, 60.00),
        (138, '牛奶', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/ab0dec6c-3807-4b79-bced-a2856d3b8dfc.jpg', 60, 31, '', 1, 23.00),
        (139, '牛肉串', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f7c3bc3a-994d-4498-9ace-3c3ab5135862.jpg', 60, 18, '', 1, 150.00),
        (140, '拿鐵咖啡', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/9f560cac-4ee2-4de0-8455-08bef525b297.jpg', 61, 8, '', 1, 70.00),
        (141, '檸檬紅茶', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f4efbb29-2859-4f3a-bb77-98e0575a7f5d.jpg', 61, 7, '', 1, 40.00),
        (142, '豆漿', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/b52e3be6-e150-40a4-9796-3d1460dada5d.jpg', 61, 30, '去冰', 1, 20.00),
        (143, '拿鐵咖啡', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/9f560cac-4ee2-4de0-8455-08bef525b297.jpg', 62, 8, '', 1, 70.00),
        (144, '檸檬紅茶', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f4efbb29-2859-4f3a-bb77-98e0575a7f5d.jpg', 62, 7, '', 1, 40.00),
        (145, '豆漿', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/b52e3be6-e150-40a4-9796-3d1460dada5d.jpg', 62, 30, '去冰', 1, 20.00),
        (146, '炸薯條', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/92a8d9af-3471-42d6-805d-5211983ee95f.jpg', 63, 10, '', 1, 60.00),
        (147, '烤雞翅', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/22f6b075-3285-480b-995a-6563bc642446.jpg', 63, 17, '中辣', 1, 120.00),
        (148, '牛肉串', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/f7c3bc3a-994d-4498-9ace-3c3ab5135862.jpg', 63, 18, '', 1, 150.00),
        (149, '巧克力蛋糕', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/34410213-4971-4e4e-815f-41aefb1aa34b.jpg', 64, 5, '', 1, 120.00),
        (150, '草莓聖代', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/54be8604-3f3b-4d9e-b44d-fff4c2f6ac1b.jpg', 64, 20, '', 1, 90.00),
        (151, '蝦餅', 'https://ting-ordering-system.oss-ap-northeast-1.aliyuncs.com/9d4eba2f-10ea-434a-8672-a6e53b9f27d8.jpg', 64, 2, '', 1, 60.00);