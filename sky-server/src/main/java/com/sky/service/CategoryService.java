package com.sky.service;

import com.sky.dto.CategoryDTO;
import com.sky.dto.CategoryPageQueryDTO;
import com.sky.entity.Category;
import com.sky.result.PageResult;

import java.util.List;

public interface CategoryService {
    /**
     * 分类管理分页查询
     * @param categoryPageQueryDTO
     * @return
     */
    PageResult pageQuery(CategoryPageQueryDTO categoryPageQueryDTO);

    /**
     * 编辑分类信息
     * @param categoryDTO
     */
    void update(CategoryDTO categoryDTO);

    /**
     * 添加分类信息
     * @param categoryDTO
     */
    void save(CategoryDTO categoryDTO);

    /**
     * 删除分类
     * @param id
     */
    void deleteByid(Long id);

    /**
     * 启用禁用分类
     * @param status
     * @param id
     */
    void startOrStop(Integer status, Long id);


    /**
     * 根据类型查询
     *
     * @param type
     * @return
     */
    List<Category> selectByCategoryId(Integer type);
}
