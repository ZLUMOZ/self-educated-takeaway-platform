package com.sky.context;

public class BaseContext {
    /*ThreadLocal为每个线程提供单独一份存储空间，具有线程隔离的效果，只有在线程内才能获取到对应的值，线程外则不
    能访问。*/

    public static ThreadLocal<Long> threadLocal = new ThreadLocal<>();

    //将id传入
    public static void setCurrentId(Long id) {
        threadLocal.set(id);
    }

    //获取id
    public static Long getCurrentId() {
        return threadLocal.get();
    }

    //删除id
    public static void removeCurrentId() {
        threadLocal.remove();
    }

}
