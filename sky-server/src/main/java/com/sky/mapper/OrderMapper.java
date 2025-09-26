package com.sky.mapper;

import com.sky.dto.GoodsSalesDTO;
import com.sky.entity.Orders;
import org.apache.ibatis.annotations.Mapper;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@Mapper
public interface OrderMapper {

    void insert(Orders orders);

    /**
     * 统计营业额
     * @param map
     * @return
     */
    Double sumByMap(Map map);

    /**
     * 订单统计
     * @param map
     * @return
     */
    Integer countByMap(Map map);

    /**
     * 销量排名
     * @param begin
     * @param end
     * @return
     */
    List<GoodsSalesDTO> getSalesTop(LocalDateTime begin,LocalDateTime end);
}
