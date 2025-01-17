package com.github.mattwei.exception;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/13 下午 12:54
 */

public class BaseException extends RuntimeException {

    public BaseException() {}

    public BaseException(String message) {
        super(message);
    }
}
