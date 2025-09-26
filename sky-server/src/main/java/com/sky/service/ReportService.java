package com.sky.service;

import com.sky.vo.OrderReportVO;
import com.sky.vo.SalesTop10ReportVO;
import com.sky.vo.TurnoverReportVO;
import com.sky.vo.UserReportVO;

import java.time.LocalDate;

public interface ReportService {

    /**
     * 统计营业额
     * @param begin
     * @param end
     * @return
     */
    TurnoverReportVO getTurnoverStatics(LocalDate begin, LocalDate end);

    /**
     * 统计用户
     * @param begin
     * @param end
     * @return
     */
    UserReportVO getUserStatics(LocalDate begin, LocalDate end);

    /**
     * 订单统计
     * @param begin
     * @param end
     * @return
     */
    OrderReportVO getordersStatistics(LocalDate begin, LocalDate end);

    /**
     * 销量排名top10
     * @param begin
     * @param end
     * @return
     */
    SalesTop10ReportVO getSalesTop10(LocalDate begin, LocalDate end);
}
