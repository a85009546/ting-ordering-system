package com.github.mattwei.exception;

/**
 * Description:
 *  異常類: 帳號不存在
 * @Author Matt Wei
 * @Create 2025/1/13 下午 02:56
 */
public class AccountNotFoundException extends BaseException {

    public AccountNotFoundException() {}
    public AccountNotFoundException(String message) {
        super(message);
    }
}
