package com.github.mattwei.context;

/**
 * Description:
 *
 * @Author Matt Wei
 * @Create 2025/1/13 下午 09:14
 */

public class BaseContext {

    public static ThreadLocal<Long> threadLocal = new ThreadLocal<>();

    public static void setCurrentId(Long id) {
        threadLocal.set(id);
    }

    public static Long getCurrentId() {
        return threadLocal.get();
    }

    public static void removeCurrentId() {
        threadLocal.remove();
    }
}
