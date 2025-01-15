package com.github.mattwei.utils;

import com.alibaba.fastjson2.JSONObject;
import org.apache.http.NameValuePair;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

import java.io.IOException;
import java.net.URI;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/15 下午 04:11
 */
public class HttpClientUtil {

    final static int TIMEOUT = 1000;
    final static int TIMEOUT_MSEC = 5 * 1000;


    /**
     * 發送GET請求
     * @param url
     * @param paramMap
     * @return
     */
    public static String doGet(String url, Map<String, String> paramMap){
        // 創建 HttpClient 物件
        CloseableHttpClient httpClient = HttpClients.createDefault();

        String result = "";
        CloseableHttpResponse response = null;

        try{
            URIBuilder builder = new URIBuilder(url);
            if(paramMap != null){
                for(String key : paramMap.keySet()){
                    builder.addParameter(key, paramMap.get(key));
                }
            }
            URI uri = builder.build();

            // 創建 GET 請求
            HttpGet httpGet = new HttpGet(uri);

            // 發送糗求
            response = httpClient.execute(httpGet);

            // 判斷響應狀態
            if(response.getStatusLine().getStatusCode() == 200){
                result = EntityUtils.toString(response.getEntity(), "UTF-8");
            }
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            try {
                response.close();
                httpClient.close();
            }catch (IOException e){
                e.printStackTrace();
            }
        }
        return result;
    }

    public static String doPost(String url, Map<String, String> paramMap) throws IOException {
        // 創建 HttpClient 物件
        CloseableHttpClient httpClient = HttpClients.createDefault();
        String result = "";
        CloseableHttpResponse response = null;

        try {
            // 創建 POST 請求
            HttpPost httpPost = new HttpPost(url);

            // 創建參數列表
            if(paramMap != null){
                List<NameValuePair> paramList = new ArrayList<>();
                for(Map.Entry<String, String> param : paramMap.entrySet()){
                    paramList.add(new BasicNameValuePair(param.getKey(), param.getValue()));
                }

                // 模擬表單
                UrlEncodedFormEntity entity = new UrlEncodedFormEntity(paramList);
                httpPost.setEntity(entity);
            }

            httpPost.setConfig(builderRequestConfig());

            // 執行 http 請求
            response = httpClient.execute(httpPost);

            result = EntityUtils.toString(response.getEntity(), "UTF-8");
        }catch (Exception e){
            throw e;
        }finally{
            try{
                response.close();
            }catch (IOException e){
                e.printStackTrace();
            }
        }

        return result;
    }


    /**
     * 發送 POST 請求
     * @param url
     * @param paramMap
     * @return
     * @throws IOException
     */
    public static String doPost4Json(String url, Map<String, String> paramMap) throws IOException {
        // 創建 Httpclient 物件
        CloseableHttpClient httpClient = HttpClients.createDefault();
        CloseableHttpResponse response = null;
        String resultString = "";

        try {
            // 創建 Http Post 請求
            HttpPost httpPost = new HttpPost(url);

            if (paramMap != null) {
                // 構造json格式數據
                JSONObject jsonObject = new JSONObject();
                for (Map.Entry<String, String> param : paramMap.entrySet()) {
                    jsonObject.put(param.getKey(),param.getValue());
                }
                StringEntity entity = new StringEntity(jsonObject.toString(),"utf-8");
                // 設置請求編碼
                entity.setContentEncoding("utf-8");
                // 設置數據模型
                entity.setContentType("application/json");
                httpPost.setEntity(entity);
            }

            httpPost.setConfig(builderRequestConfig());

            // 執行 http 請求
            response = httpClient.execute(httpPost);

            resultString = EntityUtils.toString(response.getEntity(), "UTF-8");
        } catch (Exception e) {
            throw e;
        } finally {
            try {
                response.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        return resultString;
    }
    private static RequestConfig builderRequestConfig() {
        return RequestConfig.custom()
                .setConnectTimeout(TIMEOUT_MSEC)
                .setConnectionRequestTimeout(TIMEOUT_MSEC)
                .setSocketTimeout(TIMEOUT_MSEC).build();
    }
}
