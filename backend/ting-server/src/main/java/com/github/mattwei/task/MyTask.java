package com.github.mattwei.task;

import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.Date;

/**
 * Description:
 *  自定義定時任務類
 * @Author Matt Wei
 * @Create 2025/1/22 下午 07:04
 */
@Component
@Slf4j
public class MyTask {

    /**
     * 定時任務 每隔5秒執行一次
     */
//    @Scheduled(cron = "0/5 * * * * ?")
//    public void executeTask() {
//        log.info("定時任務開始執行: {}", new Date());
//    }
}
