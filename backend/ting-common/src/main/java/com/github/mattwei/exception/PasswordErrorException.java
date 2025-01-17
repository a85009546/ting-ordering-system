package com.github.mattwei.exception;

/**
 * Description:
 *  異常類: 密碼錯誤
 * @Author Matt Wei
 * @Create 2025/1/13 下午 03:23
 */
public class PasswordErrorException extends BaseException {

    public PasswordErrorException() {}
    public PasswordErrorException(String message) {
        super(message);
    }

}