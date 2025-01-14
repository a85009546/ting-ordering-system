package com.github.mattwei.aspect;

import com.github.mattwei.annotation.AutoFill;
import com.github.mattwei.constant.AutoFillConstant;
import com.github.mattwei.context.BaseContext;
import com.github.mattwei.enumeration.OperationType;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.stereotype.Component;

import java.lang.reflect.Method;
import java.time.LocalDateTime;

/**
 * Description:
 *  自定義切面，對公共欄位進行填值
 * @Author Matt Wei
 * @Create 2025/1/14 下午 07:58
 */

@Aspect
@Component
@Slf4j
public class AutoFillAspect {

    /**
     * 切入點
     * 攔截 com.github.mattwei.mapper包下 且 加了@AutoFill註解的方法
     */
    @Pointcut("execution(* com.github.mattwei.mapper.*.*(..)) && " +
            "@annotation(com.github.mattwei.annotation.AutoFill)")
    public void autoFillPointCut() {
    }


    /**
     * 前置通知，在通知中進行公共欄位的賦值
     *
     * @param joinPoint
     */
    @Before("autoFillPointCut()")
    public void autoFill(JoinPoint joinPoint) {
        log.info("開始進行公共欄位自動填值...");

        // 1. 獲取到當前被攔截的方法上數據庫的操作類型
        MethodSignature signature = (MethodSignature) joinPoint.getSignature(); // 方法簽名對象

        AutoFill autoFill = signature.getMethod().getAnnotation(AutoFill.class); // 獲取方法上的註解物件
        OperationType operationType = autoFill.value(); // 獲得數據庫操作類型

        // 2. 獲取到當前被攔截的方法的參數 - 實體物件
        Object[] args = joinPoint.getArgs();
        if (args == null || args.length == 0) {
            return;
        }
        Object entity = args[0];

        // 3. 準備賦值的數據
        LocalDateTime now = LocalDateTime.now();

        // 4. 根據當前不同的操作類型，為對應的屬性通過反射來賦值
        if (operationType == OperationType.INSERT) {
            try {
                Method setCreateTime = entity.getClass().getDeclaredMethod(AutoFillConstant.SET_CREATE_TIME, LocalDateTime.class);
                Method setUpdateTime = entity.getClass().getDeclaredMethod(AutoFillConstant.SET_UPDATE_TIME, LocalDateTime.class);

                // 通過反射為對象屬性賦值
                setCreateTime.invoke(entity, now);
                setUpdateTime.invoke(entity, now);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
