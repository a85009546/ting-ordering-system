FROM nginx:alpine

WORKDIR /usr/share/nginx/html

# 清除 Nginx 的預設配置
RUN rm -rf ./*

# 複製打包後的 dist 資料夾到 Nginx 的目錄
COPY dist /usr/share/nginx/html

# 複製自定義設定
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

# 設定 Nginx 服務
CMD ["nginx", "-g", "daemon off;"]
