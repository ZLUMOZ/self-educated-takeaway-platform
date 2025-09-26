package com.sky.controller.admin;

import com.sky.dto.CategoryDTO;
import com.sky.dto.CategoryPageQueryDTO;
import com.sky.entity.Category;
import com.sky.result.PageResult;
import com.sky.result.Result;
import com.sky.service.CategoryService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 分类管理
 */
@RestController
@RequestMapping("/admin/category")
@Slf4j
@Api(tags = "分类管理相关接口")
public class CategoryController {

    @Autowired
    private CategoryService categoryService;
    /**
     * 分类管理分页查询
     * @param categoryPageQueryDTO
     * @return
     */
    @GetMapping("/page")
    @ApiOperation(value = "分类管理分页查询")
    public Result<PageResult> page(CategoryPageQueryDTO categoryPageQueryDTO){
        log.info("分类管理分页查询:{}",categoryPageQueryDTO);
        PageResult pageResult = categoryService.pageQuery(categoryPageQueryDTO);
        return Result.success(pageResult);
    }

    /**
     * 编辑分类信息
     * @param categoryDTO
     * @return
     */
    @PutMapping
    @ApiOperation(value = "编辑分类信息")
    public Result update(@RequestBody CategoryDTO categoryDTO){
        categoryService.update(categoryDTO);
        return Result.success();
    }

    /**
     * 添加分类信息
     * @param categoryDTO
     * @return
     */
    @PostMapping
    @ApiOperation(value = "添加分类信息")
    public Result save(@RequestBody CategoryDTO categoryDTO){
        categoryService.save(categoryDTO);
        return Result.success();
    }

    /**
     * 删除分类
     * @param id
     * @return
     */
    @DeleteMapping
    @ApiOperation(value = "删除分类")
    public Result delete(Long id){
        categoryService.deleteByid(id);
        return Result.success();
    }

    /**
     * 启用禁用分类
     * @param status
     * @param id
     * @return
     */
    @PostMapping("/status/{status}")
    @ApiOperation(value = "启用禁用分类")
    public Result startOrstop(@PathVariable Integer status,Long id){
        categoryService.startOrStop(status,id);
        return Result.success();
    }

    /**
     * 根据类型查询
     * @param type
     * @return
     */
    @GetMapping("/list")
    @ApiOperation(value = "根据类型查询")
    public Result<List<Category>> categoryList(Integer type){
        List<Category> category = categoryService.selectByCategoryId(type);
        return Result.success(category);
    }
}
