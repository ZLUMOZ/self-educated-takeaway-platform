package com.sky.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.sky.constant.MessageConstant;
import com.sky.constant.StatusConstant;
import com.sky.dto.DishDTO;
import com.sky.dto.DishPageQueryDTO;
import com.sky.entity.Dish;
import com.sky.entity.DishFlavor;
import com.sky.exception.DeletionNotAllowedException;
import com.sky.mapper.CategoryMapper;
import com.sky.mapper.DishFlavorMapper;
import com.sky.mapper.DishMapper;
import com.sky.mapper.SetmealDishMapper;
import com.sky.result.PageResult;
import com.sky.service.DishService;
import com.sky.vo.DishVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@Slf4j
public class DishServiceImpl implements DishService {

    @Autowired
    private DishMapper dishMapper;

    @Autowired
    private DishFlavorMapper dishFlavorMapper;

    @Autowired
    private SetmealDishMapper setmealDishMapper;

    @Autowired
    private CategoryMapper categoryMapper;

    /**
     * 新增菜品和对应的口味
     * @param dishDTO
     */
    @Override
    @Transactional//创建事务
    public void savewhitFlavor(DishDTO dishDTO) {

        Dish dish = new Dish();

        BeanUtils.copyProperties(dishDTO,dish);

        //向菜品表插入1条数据
        dishMapper.insert(dish);
        //dish中还在创建id没法传给口味的创建方法，要手动提取dishid，
        // 在dishmapper中的insert中添加useGeneratedKeys="true" 意思是需要返回主键值
        // keyProperty="id"获得新生成的id
        Long dishId = dish.getId();

        List<DishFlavor> flavors = dishDTO.getFlavors();
        if (flavors != null && flavors.size() > 0){
            //批量遍历，批量赋值给id，用于新增口味对应的外键
            flavors.forEach(dishFlavor -> {
                dishFlavor.setDishId(dishId);
            });
            //向口味表插入n条数据
            dishFlavorMapper.insertBatch(flavors);
        }
    }

    /**
     * 分页查询
     * @param dishPageQueryDTO
     * @return
     */
    @Override
    public PageResult pageQuery(DishPageQueryDTO dishPageQueryDTO) {
        PageHelper.startPage(dishPageQueryDTO.getPage(),dishPageQueryDTO.getPageSize());

        Page<DishVO> page = dishMapper.pageQuery(dishPageQueryDTO);

        long total = page.getTotal();
        List<DishVO> records = page.getResult();

        return new PageResult(total,records);
    }

    /**
     * 菜品批量删除
     * @param ids
     */
    @Transactional
    @Override
    public void deleteBatch(List<Long> ids) {
        //当前菜品是否起售中
        for (Long id : ids){
           Dish dish = dishMapper.getById(id);
           if (dish.getStatus() == StatusConstant.ENABLE){
               //起售中不可删除
               throw new DeletionNotAllowedException(MessageConstant.DISH_ON_SALE);
           }
        }
        //判断当前菜品是否有套餐关联
        List<Long> setmealIds = setmealDishMapper.getSetmealIdsByDishIds(ids);
        if (setmealIds != null && setmealIds.size() >0){
            throw new DeletionNotAllowedException(MessageConstant.CATEGORY_BE_RELATED_BY_DISH);
        }
        //删除菜品
        /*for (Long id : ids) {
            dishMapper.deleteById(id);
            //删除菜品关联的口味
            dishFlavorMapper.deleteByDishId(id);
        }*/

        //根据菜品id集合批量删除菜品数据
        //sql: delete from dish where id in (?,?,?)
        dishMapper.deleteByIds(ids);

        //根据菜品id集合批量删除关联的口味数据
        //sql: delete from dish_flavor where dish_id in (?,?,?)
        dishFlavorMapper.deleteByDishIds(ids);
    }

    /**
     * 根据id查询菜品
     * @param id
     * @return
     */
    @Override
    public DishVO getByIdWithFlavor(Long id) {
        //根据id查询菜品数据
        Dish dish = dishMapper.getById(id);
        //根据菜品id查询口味数据
        List<DishFlavor> dishFlavors = dishFlavorMapper.getByDishId(id);
        //返回查询的数据
        DishVO dishVO = new DishVO();
        BeanUtils.copyProperties(dish,dishVO);
        dishVO.setFlavors(dishFlavors);
        return dishVO;
    }

    /**
     * 修改菜品
     */
    @Override
    public void updateWithFlavor(DishDTO dishDTO) {
        Dish dish = new Dish();
        BeanUtils.copyProperties(dishDTO,dish);

         //修改菜品信息
        dishMapper.update(dish);
         //删除原有的口味
        dishFlavorMapper.deleteByDishId(dishDTO.getId());
         //重新插入口味
        List<DishFlavor> flavors = dishDTO.getFlavors();
        if (flavors != null && flavors.size() > 0){
            //批量遍历，批量赋值给id，用于新增口味对应的外键
            flavors.forEach(dishFlavor -> {
                dishFlavor.setDishId(dishDTO.getId());
            });
            //向口味表插入n条数据
            dishFlavorMapper.insertBatch(flavors);
        }
    }

    /**
     * 菜品的起售和停售
     * @param id
     */
    @Override
    public void OpenWithStop(Integer status ,Long id) {
        Dish dish = Dish.builder()
                .status(status)
                .id(id)
                .build();

        dishMapper.update(dish);
    }

    /**
     * 根据分类id查询菜品
     * @param categoryId
     */
    @Override
    public List<Dish> list(Long categoryId) {
        //根据分类id查询菜品
        List<Dish> dishes = categoryMapper.getById(categoryId);
        return dishes;
    }

    /**
     * 条件查询菜品和口味
     * @param dish
     * @return
     */
    public List<DishVO> listWithFlavor(Dish dish) {
        List<Dish> dishList = dishMapper.list(dish);

        List<DishVO> dishVOList = new ArrayList<>();

        for (Dish d : dishList) {
            DishVO dishVO = new DishVO();
            BeanUtils.copyProperties(d,dishVO);

            //根据菜品id查询对应的口味
            List<DishFlavor> flavors = dishFlavorMapper.getByDishId(d.getId());

            dishVO.setFlavors(flavors);
            dishVOList.add(dishVO);
        }

        return dishVOList;
    }

}
