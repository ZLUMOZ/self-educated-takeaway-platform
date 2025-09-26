package com.sky.aspect;

import com.sky.annotation.AutoFill;
import com.sky.constant.AutoFillConstant;
import com.sky.context.BaseContext;
import com.sky.enumeration.OperationType;
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
 * 自定义切面，实现公共字段自动填充处理器
 */
@Aspect
@Component
@Slf4j
public class AutoFillAspect {
    /**
     * 切入点
     */
    @Pointcut("execution(* com.sky.mapper.*.*(..)) " +
              "&& @annotation(com.sky.annotation.AutoFill)")
    public void autoFillPointCut(){}

    /**
     * 使用前置通知增强通知,对公共字段进行赋值
     */
    @Before("autoFillPointCut()")
    public void autoFill(JoinPoint joinPoint){
        log.info("开始公共字段开始自动填充。。。。");

        //获取到当前被拦截的方法上的数据库操作类型
        MethodSignature signature = (MethodSignature) joinPoint.getSignature();//方法签名对象
        AutoFill autoFill = signature.getMethod().getAnnotation(AutoFill.class);//获得自定义的AutoFill注解
        OperationType operationType = autoFill.value();//获得数据库操作类型

        //获取到当前被拦截的方法的参数
        Object[] args = joinPoint.getArgs();
        if (args == null || args.length == 0){
            return;
        }

        Object entilty = args[0];

        //准备赋值的数据
        LocalDateTime now = LocalDateTime.now();
        Long currentId = BaseContext.getCurrentId();

        //根据当前不同的操作类型、为对应的属性赋值
        if(operationType == OperationType.INSERT){
            try {
                Method setCreateTime = entilty.getClass().getDeclaredMethod(AutoFillConstant.SET_CREATE_TIME,LocalDateTime.class);
                Method setCreateUser = entilty.getClass().getDeclaredMethod(AutoFillConstant.SET_CREATE_USER,Long.class);
                Method setUpdateTime = entilty.getClass().getDeclaredMethod(AutoFillConstant.SET_UPDATE_TIME,LocalDateTime.class);
                Method setUpdateUser = entilty.getClass().getDeclaredMethod(AutoFillConstant.SET_UPDATE_USER,Long.class);
                //通过反射为对象属性赋值
                setCreateTime.invoke(entilty,now);
                setCreateUser.invoke(entilty,currentId);
                setUpdateTime.invoke(entilty,now);
                setUpdateUser.invoke(entilty,currentId);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }

        }else if (operationType == OperationType.UPDATE){
            try {
                Method setUpdateTime = entilty.getClass().getDeclaredMethod(AutoFillConstant.SET_UPDATE_TIME,LocalDateTime.class);
                Method setUpdateUser = entilty.getClass().getDeclaredMethod(AutoFillConstant.SET_UPDATE_USER,Long.class);
                //通过反射为对象属性赋值
                setUpdateTime.invoke(entilty,now);
                setUpdateUser.invoke(entilty,currentId);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }
    }
}
