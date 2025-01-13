package com.github.mattwei;

import lombok.extern.slf4j.Slf4j;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * Hello world!
 *
 */
@SpringBootApplication
@Slf4j
public class TingApplication {
    public static void main( String[] args ) {
        SpringApplication.run(TingApplication.class, args);
        log.info("ting-server started");
    }
}
