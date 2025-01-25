package com.github.mattwei.websocket;

import org.springframework.stereotype.Component;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

/**
 * WebSocket服務
 */
@Component
@ServerEndpoint("/ws/{sid}")
public class WebSocketServer {

    // 存放會話物件，key為sid，也就是用戶端的唯一標識，value為Session物件
    private static Map<String, Session> sessionMap = new HashMap();

    /**
     * 連接建立成功调用的方法
     */
    @OnOpen
    public void onOpen(Session session, @PathParam("sid") String sid) {
        System.out.println("客戶端：" + sid + "建立連接");
        sessionMap.put(sid, session);
    }

    /**
     * 收到用戶端消息後调用的方法
     *
     * @param message 用戶端發送過來的消息
     */
    @OnMessage
    public void onMessage(String message, @PathParam("sid") String sid) {
        System.out.println("收到来自用戶端：" + sid + "的訊息:" + message);
    }

    /**
     * 連接關閉调用的方法
     *
     * @param sid
     */
    @OnClose
    public void onClose(@PathParam("sid") String sid) {
        System.out.println("断開連接:" + sid);
        // 清理會話物件
        sessionMap.remove(sid);
    }

    /**
     * 群發
     *
     * @param message
     */
    public void sendToAllClient(String message) {
        // 會話物件集合
        Collection<Session> sessions = sessionMap.values();
        // 群發
        for (Session session : sessions) {
            try {
                //服務器向用戶端發送消息
                session.getBasicRemote().sendText(message);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
