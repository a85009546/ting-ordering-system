package com.github.mattwei;

import com.ulisesbocchio.jasyptspringboot.annotation.EnableEncryptableProperties;
import lombok.extern.slf4j.Slf4j;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.transaction.annotation.EnableTransactionManagement;

/**
 * Hello world!
 *
 */
@SpringBootApplication
@EnableTransactionManagement // 開啟註解方式的事務管理
@EnableScheduling // 開啟任務調度
@EnableEncryptableProperties // 啟用 Jasypt 屬性加密
@Slf4j
public class TingApplication {
    public static void main( String[] args ) {
        SpringApplication.run(TingApplication.class, args);
        log.info("ting-server started");
    }
}
