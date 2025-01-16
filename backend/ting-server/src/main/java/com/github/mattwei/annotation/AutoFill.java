package com.github.mattwei.annotation;

import com.github.mattwei.enumeration.OperationType;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * Description:
 *  自定義註解，用於表示需要進行公共欄位自動填充的方法
 * @Author Matt Wei
 * @Create 2025/1/14 下午 07:54
 */

@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface AutoFill {
    // 數據庫操作類型: INSERT
    OperationType value();
}
