package com.github.mattwei.handler;

import com.github.mattwei.exception.BaseException;
import com.github.mattwei.result.Result;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

/**
 * Description:
 *  全局異常處理器
 * @Author Matt Wei
 * @Create 2025/1/13 下午 01:00
 */
@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {


    /**
     * 捕獲業務異常
     * @param e
     * @return
     */
    @ExceptionHandler
    public Result exceptionHandler(BaseException e) {
        log.error("異常訊息: {}", e.getMessage());
        return Result.error(e.getMessage());
    }
}
