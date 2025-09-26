package com.sky.controller.admin;

import com.sky.dto.SetmealDTO;
import com.sky.dto.SetmealPageQueryDTO;
import com.sky.result.PageResult;
import com.sky.result.Result;
import com.sky.service.SetmealService;
import com.sky.vo.SetmealVO;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 套餐管理
 */
@RestController
@RequestMapping("/admin/setmeal")
@Slf4j
@Api(tags = "套餐管理相关接口")
public class SetmealController {

    @Autowired
    private SetmealService setmealService;

    @GetMapping("/page")
    @ApiOperation(value = "套餐管理分页查询")
    public Result<PageResult> page(SetmealPageQueryDTO setmealPageQueryDTO){
        PageResult pageResult = setmealService.pageQuery(setmealPageQueryDTO);
        return Result.success(pageResult);
    }

    /**
     * 添加套餐信息
     * @param setmealDTO
     * @return
     */
    @PostMapping
    @ApiOperation(value = "添加套餐信息")
    @CacheEvict(cacheNames = "setmealCache" , key = "#setmealDTO.categoryId")
    public Result save(@RequestBody SetmealDTO setmealDTO){
        setmealService.save(setmealDTO);
        return Result.success();
    }

    /**
     * 套餐的启用与禁用
     * @param status
     * @return
     */
    @PostMapping("/status/{status}")
    @ApiOperation("套餐的启用与禁用")
    @CacheEvict(cacheNames = "setmealCache" , allEntries = true)
    public Result OpenWithStop(@PathVariable Integer status,Long id){
        setmealService.OpenWithStop(status,id);
        return Result.success();
    }

    /**
     * 修改套餐
     * @param setmealDTO
     * @return
     */
    @PutMapping
    @ApiOperation("修改套餐")
    @CacheEvict(cacheNames = "setmealCache" , allEntries = true)
    public Result update(@RequestBody SetmealDTO setmealDTO){
        setmealService.update(setmealDTO);
        return Result.success();
    }

    /**
     * 根据id查询套餐
     * @return
     */
    @GetMapping("/{id}")
    @ApiOperation("根据id查询套餐")
    public Result<SetmealVO> getById(@PathVariable Long id){
        SetmealVO setmealVO = setmealService.getById(id);
        return Result.success(setmealVO);
    }

    /**
     * 批量删除
     * @param ids
     * @return
     */
    @DeleteMapping
    @ApiOperation("批量删除")
    @CacheEvict(cacheNames = "setmealCache" , allEntries = true)
    public Result delete(@RequestParam List<Long> ids){
        setmealService.delete(ids);
        return Result.success();
    }
}
