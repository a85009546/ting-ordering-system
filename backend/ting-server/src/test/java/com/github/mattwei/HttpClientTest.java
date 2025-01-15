package com.github.mattwei;

import com.alibaba.fastjson2.JSONObject;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.core.codec.EncodingException;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/15 下午 03:07
 */
@SpringBootTest
public class HttpClientTest {

    /**
     * 測試通過 httpclient發送GET方式的請求
     */
    @Test
    public void testGET() throws IOException {
        // 創建 httpclient 物件
        CloseableHttpClient httpClient = HttpClients.createDefault();

        // 創建請求物件
        HttpGet httpGet = new HttpGet("http://localhost:8080/customer/shop/status");

        // 發送請求，接收響應結果
        CloseableHttpResponse response = httpClient.execute(httpGet);

        // 獲取服務端返回的狀態碼
        int statusCode = response.getStatusLine().getStatusCode();
        System.out.println("服務端返回的狀態碼: " + statusCode);

        HttpEntity entity = response.getEntity();
        String body = EntityUtils.toString(entity);
        System.out.println("服務端返回的數據為: " + body);

        // 關閉資源
        response.close();
        httpClient.close();
    }

    /**
     * 測試通過 httpclient發送POST方式的請求
     */
    @Test
    public void testPOST() throws Exception {
        // 創建 httpclient 物件
        CloseableHttpClient httpClient = HttpClients.createDefault();

        // 創建請求物件
        HttpPost httPost = new HttpPost("http://localhost:8080/auth/login");

        JSONObject jsonObject = new JSONObject();
        jsonObject.put("account", "admin");
        jsonObject.put("password", "123456");

        StringEntity entity = new StringEntity(jsonObject.toString());
        // 指定請求編碼方式
        entity.setContentEncoding("utf-8");
        // 數據格式
        entity.setContentType("application/json");
        httPost.setEntity(entity);

        // 發送請求，接收響應結果
        CloseableHttpResponse response = httpClient.execute(httPost);

        // 解析返回結果
        int statusCode = response.getStatusLine().getStatusCode();
        System.out.println("響應碼為: " + statusCode);

        HttpEntity entity1 = response.getEntity();
        String body = EntityUtils.toString(entity1);
        System.out.println("服務端返回的數據為: " + body);

        // 關閉資源
        response.close();
        httpClient.close();

    }
}
