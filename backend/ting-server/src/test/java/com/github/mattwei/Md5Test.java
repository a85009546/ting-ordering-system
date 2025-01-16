package com.github.mattwei;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.util.DigestUtils;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/13 下午 07:23
 */

//@SpringBootTest
public class Md5Test {

    @Test
    public void passwordTest(){
        String password = DigestUtils.md5DigestAsHex("123456".getBytes());
        System.out.println(password);
    }
}
