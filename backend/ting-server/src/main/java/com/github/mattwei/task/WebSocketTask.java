package com.github.mattwei.task;

import com.github.mattwei.websocket.WebSocketServer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Component
public class WebSocketTask {
    @Autowired
    private WebSocketServer webSocketServer;

    /**
     * 通過WebSocket每隔5秒向用戶端發送消息
     */
    @Scheduled(cron = "0/5 1 * * * ?")
    public void sendMessageToClient() {
        webSocketServer.sendToAllClient("這是来自伺服端的消息：" + DateTimeFormatter.ofPattern("HH:mm:ss").format(LocalDateTime.now()));
    }
}
