package com.github.mattwei.result;

import lombok.Data;

import java.io.Serializable;

/**
 * Description:
 *  後端統一返回的結果
 * @Author Matt Wei
 * @Create 2025/1/13 上午 09:54
 */

@Data
public class Result<T> implements Serializable {

    private Integer code; // 狀態碼: 1-成功，0和其他數字為失敗
    private String msg; // 訊息
    private T data; // 數據

    public static <T> Result<T> success() {
        Result<T> result = new Result<T>();
        result.code = 1;
        return result;
    }

    public static <T> Result<T> success(T object) {
        Result<T> result = new Result<T>();
        result.data = object;
        result.code = 1;
        return result;
    }

    public static <T> Result<T> error(String msg) {
        Result result = new Result();
        result.msg = msg;
        result.code = 0;
        return result;
    }
}
