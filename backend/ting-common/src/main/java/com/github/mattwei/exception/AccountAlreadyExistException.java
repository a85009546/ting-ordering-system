package com.github.mattwei.exception;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/13 下午 04:08
 */
public class AccountAlreadyExistException extends BaseException {

    public AccountAlreadyExistException() {}
    public AccountAlreadyExistException(String message) {
        super(message);
    }
}
