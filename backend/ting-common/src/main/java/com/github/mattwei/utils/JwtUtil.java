package com.github.mattwei.utils;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

import java.nio.charset.StandardCharsets;
import java.util.Date;
import java.util.Map;

/**
 * Description:
 *  JWT令牌工具类
 * @Author Matt Wei
 * @Create 2025/1/13 下午 06:39
 */
public class JwtUtil {


    /**
     * 生成jwt令牌
     * 使用Hs256加密算法
     * @param secretKey
     * @param ttlMilis
     * @param claims
     * @return
     */
    public static String createJWT(String secretKey, long ttlMilis, Map<String, Object> claims){

        // 指定簽名算法
        SignatureAlgorithm signatureAlgorithm = SignatureAlgorithm.HS256;

        // 設定令牌過期時間
        long expMillis = System.currentTimeMillis() + ttlMilis;
        Date exp = new Date(expMillis);

        return Jwts.builder()
                .setClaims(claims)
                .setExpiration(exp)
                .signWith(signatureAlgorithm, secretKey.getBytes(StandardCharsets.UTF_8))
                .compact();
    }


    /**
     * 解析jwt令牌
     * @param secretKey
     * @param token
     * @return
     */
    public static Claims parseJWT(String secretKey, String token){
        return Jwts.parser()
                .setSigningKey(secretKey.getBytes(StandardCharsets.UTF_8))
                .parseClaimsJws(token)
                .getBody();
    }
}
