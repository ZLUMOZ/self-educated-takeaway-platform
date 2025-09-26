package com.sky.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.sky.constant.MessageConstant;
import com.sky.constant.StatusConstant;
import com.sky.dto.CategoryDTO;
import com.sky.dto.CategoryPageQueryDTO;
import com.sky.entity.Category;
import com.sky.exception.DeletionNotAllowedException;
import com.sky.mapper.CategoryMapper;
import com.sky.mapper.DishMapper;
import com.sky.mapper.SetmealMapper;
import com.sky.result.PageResult;
import com.sky.service.CategoryService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoryServiceImpl implements CategoryService {

    @Autowired
    private CategoryMapper categoryMapper;

    @Autowired
    private DishMapper dishMapper;

    @Autowired
    private SetmealMapper setmealMapper;

    /**
     * 分类管理分页查询
     * @param categoryPageQueryDTO
     * @return
     */
    @Override
    public PageResult pageQuery(CategoryPageQueryDTO categoryPageQueryDTO) {
        PageHelper.startPage(categoryPageQueryDTO.getPage(),categoryPageQueryDTO.getPageSize());

        Page<Category> page = categoryMapper.pageQuery(categoryPageQueryDTO);

        long total = page.getTotal();
        List<Category> records = page.getResult();

        return new PageResult(total,records);
    }

    /**
     * 编辑分类信息
     * @param categoryDTO
     */
    @Override
    public void update(CategoryDTO categoryDTO) {
        Category category = new Category();
        //对象的属性拷贝
        BeanUtils.copyProperties(categoryDTO,category);
        //添加更新时间
        //category.setUpdateTime(LocalDateTime.now());
        //添加修改人
        //category.setUpdateUser(BaseContext.getCurrentId());

        categoryMapper.update(category);
    }

    /**
     * 添加分类信息
     * @param categoryDTO
     */
    @Override
    public void save(CategoryDTO categoryDTO) {
        Category category = new Category();
        //对象属性拷贝
        BeanUtils.copyProperties(categoryDTO,category);
        //设置账号的状态
        category.setStatus(StatusConstant.DISABLE);
        //设置当前记录的创建时间和修改时间
        /*category.setCreateTime(LocalDateTime.now());
        category.setUpdateTime(LocalDateTime.now());*/
        //设置当前记录创建人的id和修改人的id
        /*category.setCreateUser(BaseContext.getCurrentId());
        category.setUpdateUser(BaseContext.getCurrentId());*/
        //插入分类数据
        categoryMapper.insert(category);
    }

    /**
     * 删除分类
     * @param id
     */
    @Override
    public void deleteByid(Long id) {
        //查询当前分类是否关联了菜品，如果有关联就抛出业务异常
        Integer count = dishMapper.countByCategoryId(id);
        if (count > 0){
            //当前分类下有彩屏，不能删除
            throw new DeletionNotAllowedException(MessageConstant.CATEGORY_BE_RELATED_BY_DISH);
        }

        //查询当前分类是否有关联了套餐，如果关联了就抛出异常
        count = setmealMapper.countByCategoryId(id);
        if (count > 0){
            throw new DeletionNotAllowedException(MessageConstant.CATEGORY_BE_RELATED_BY_DISH);
        }

        //删除分类数据
        categoryMapper.deleteByid(id);
    }

    /**
     * 启用禁用分类
     * @param status
     * @param id
     */
    @Override
    public void startOrStop(Integer status, Long id) {
        Category category = Category.builder()
                .status(status)
                .id(id)
                .build();

        categoryMapper.update(category);
    }

    /**
     * 根据类型查询
     *
     * @param type
     * @return
     */
    @Override
    public List<Category> selectByCategoryId(Integer type) {
        return categoryMapper.selectByCategoryId(type);
    }
}
