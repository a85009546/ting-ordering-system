FROM openjdk:17

LABEL author=mattwei

# 設定工作目錄
WORKDIR /app

# 將打包好的 jar 檔複製進容器
COPY ting-server/target/ting-server-0.0.1-SNAPSHOT.jar /app/ting-ordering-system-backend.jar

# 開放 8080 端口
EXPOSE 8080

# 指定容器啟動時要執行的指令
CMD ["java", "-jar", "ting-ordering-system-backend.jar"]
