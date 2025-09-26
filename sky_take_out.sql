/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50703
 Source Host           : localhost:3306
 Source Schema         : sky_take_out

 Target Server Type    : MySQL
 Target Server Version : 50703
 File Encoding         : 65001

 Date: 26/09/2025 11:31:43
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for address_book
-- ----------------------------
DROP TABLE IF EXISTS `address_book`;
CREATE TABLE `address_book`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint(20) NOT NULL COMMENT '用户id',
  `consignee` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '收货人',
  `sex` varchar(2) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '性别',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '手机号',
  `province_code` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '省级区划编号',
  `province_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '省级名称',
  `city_code` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '市级区划编号',
  `city_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '市级名称',
  `district_code` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '区级区划编号',
  `district_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '区级名称',
  `detail` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '详细地址',
  `label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标签',
  `is_default` tinyint(1) NOT NULL DEFAULT 0 COMMENT '默认 0 否 1是',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '地址簿' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of address_book
-- ----------------------------
INSERT INTO `address_book` VALUES (1, 1, 'lu', '1', '13133466545', '63', '青海省', '6302', '海东市', '630222', '民和回族土族自治县', '11h ', '2', 1);

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `type` int(11) NULL DEFAULT NULL COMMENT '类型   1 菜品分类 2 套餐分类',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '分类名称',
  `sort` int(11) NOT NULL DEFAULT 0 COMMENT '顺序',
  `status` int(11) NULL DEFAULT NULL COMMENT '分类状态 0:禁用，1:启用',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `create_user` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `update_user` bigint(20) NULL DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_category_name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '菜品及套餐分类' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (11, 1, '酒水饮料', 10, 1, '2022-06-09 22:09:18', '2022-06-09 22:09:18', 1, 1);
INSERT INTO `category` VALUES (12, 1, '传统主食', 9, 1, '2022-06-09 22:09:32', '2022-06-09 22:18:53', 1, 1);
INSERT INTO `category` VALUES (13, 2, '人气套餐', 12, 1, '2022-06-09 22:11:38', '2022-06-10 11:04:40', 1, 1);
INSERT INTO `category` VALUES (15, 2, '商务套餐', 13, 1, '2022-06-09 22:14:10', '2022-06-10 11:04:48', 1, 1);
INSERT INTO `category` VALUES (16, 1, '蜀味烤鱼', 4, 1, '2022-06-09 22:15:37', '2022-08-31 14:27:25', 1, 1);
INSERT INTO `category` VALUES (17, 1, '蜀味牛蛙', 5, 1, '2022-06-09 22:16:14', '2024-08-20 17:28:21', 1, 1);
INSERT INTO `category` VALUES (18, 1, '特色蒸菜', 6, 1, '2022-06-09 22:17:42', '2022-06-09 22:17:42', 1, 1);
INSERT INTO `category` VALUES (19, 1, '新鲜时蔬', 7, 1, '2022-06-09 22:18:12', '2022-06-09 22:18:28', 1, 1);
INSERT INTO `category` VALUES (20, 1, '水煮鱼', 8, 1, '2022-06-09 22:22:29', '2022-06-09 22:23:45', 1, 1);
INSERT INTO `category` VALUES (21, 1, '汤类', 11, 1, '2022-06-09 22:22:29', '2022-06-09 22:22:29', 1, 1);

-- ----------------------------
-- Table structure for dish
-- ----------------------------
DROP TABLE IF EXISTS `dish`;
CREATE TABLE `dish`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '菜品名称',
  `category_id` bigint(20) NOT NULL COMMENT '菜品分类id',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '菜品价格',
  `image` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '图片',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '描述信息',
  `status` int(11) NULL DEFAULT 1 COMMENT '0 停售 1 起售',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `create_user` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `update_user` bigint(20) NULL DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_dish_name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 70 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '菜品' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of dish
-- ----------------------------
INSERT INTO `dish` VALUES (46, '王老吉', 11, 6.00, 'https://chqiwaimai.oss-cn-guangzhou.aliyuncs.com/1.png', '', 1, '2022-06-09 22:40:47', '2022-06-09 22:40:47', 1, 1);
INSERT INTO `dish` VALUES (47, '北冰洋', 11, 4.00, 'https://chqiwaimai.oss-cn-guangzhou.aliyuncs.com/2.png', '还是小时候的味道', 1, '2022-06-10 09:18:49', '2022-06-10 09:18:49', 1, 1);
INSERT INTO `dish` VALUES (48, '雪花啤酒', 11, 4.00, 'https://chqiwaimai.oss-cn-guangzhou.aliyuncs.com/3.png', '', 1, '2022-06-10 09:22:54', '2022-06-10 09:22:54', 1, 1);
INSERT INTO `dish` VALUES (49, '米饭', 12, 2.00, 'https://chqiwaimai.oss-cn-guangzhou.aliyuncs.com/4.png', '精选五常大米', 1, '2022-06-10 09:30:17', '2024-08-29 10:53:07', 1, 1);
INSERT INTO `dish` VALUES (50, '馒头', 12, 1.00, 'https://chqiwaimai.oss-cn-guangzhou.aliyuncs.com/5.png', '优质面粉', 1, '2022-06-10 09:34:28', '2022-06-10 09:34:28', 1, 1);
INSERT INTO `dish` VALUES (51, '老坛酸菜鱼', 20, 56.00, 'https://chqiwaimai.oss-cn-guangzhou.aliyuncs.com/6.png', '原料：汤，草鱼，酸菜', 1, '2022-06-10 09:40:51', '2022-06-10 09:40:51', 1, 1);
INSERT INTO `dish` VALUES (52, '经典酸菜鮰鱼', 20, 66.00, 'https://chqiwaimai.oss-cn-guangzhou.aliyuncs.com/7.png', '原料：酸菜，江团，鮰鱼', 1, '2022-06-10 09:46:02', '2022-06-10 09:46:02', 1, 1);
INSERT INTO `dish` VALUES (53, '蜀味水煮草鱼', 20, 38.00, 'https://chqiwaimai.oss-cn-guangzhou.aliyuncs.com/8.png', '原料：草鱼，汤', 1, '2022-06-10 09:48:37', '2022-06-10 09:48:37', 1, 1);
INSERT INTO `dish` VALUES (54, '清炒小油菜', 19, 18.00, 'https://chqiwaimai.oss-cn-guangzhou.aliyuncs.com/9.png', '原料：小油菜', 1, '2022-06-10 09:51:46', '2022-06-10 09:51:46', 1, 1);
INSERT INTO `dish` VALUES (55, '蒜蓉娃娃菜', 19, 18.00, 'https://chqiwaimai.oss-cn-guangzhou.aliyuncs.com/10.png', '原料：蒜，娃娃菜', 1, '2022-06-10 09:53:37', '2022-06-10 09:53:37', 1, 1);
INSERT INTO `dish` VALUES (56, '清炒西兰花', 19, 18.00, 'https://chqiwaimai.oss-cn-guangzhou.aliyuncs.com/11.png', '原料：西兰花', 1, '2022-06-10 09:55:44', '2022-06-10 09:55:44', 1, 1);
INSERT INTO `dish` VALUES (57, '炝炒圆白菜', 19, 18.00, 'https://chqiwaimai.oss-cn-guangzhou.aliyuncs.com/12.png', '原料：圆白菜', 1, '2022-06-10 09:58:35', '2022-06-10 09:58:35', 1, 1);
INSERT INTO `dish` VALUES (58, '清蒸鲈鱼', 18, 98.00, 'https://chqiwaimai.oss-cn-guangzhou.aliyuncs.com/13.png', '原料：鲈鱼', 1, '2022-06-10 10:12:28', '2022-06-10 10:12:28', 1, 1);
INSERT INTO `dish` VALUES (59, '东坡肘子', 18, 138.00, 'https://chqiwaimai.oss-cn-guangzhou.aliyuncs.com/14.png', '原料：猪肘棒', 1, '2022-06-10 10:24:03', '2022-06-10 10:24:03', 1, 1);
INSERT INTO `dish` VALUES (60, '梅菜扣肉', 18, 58.00, 'https://chqiwaimai.oss-cn-guangzhou.aliyuncs.com/15.png', '原料：猪肉，梅菜', 1, '2022-06-10 10:26:03', '2022-06-10 10:26:03', 1, 1);
INSERT INTO `dish` VALUES (61, '剁椒鱼头', 18, 66.00, 'https://chqiwaimai.oss-cn-guangzhou.aliyuncs.com/16.png', '原料：鲢鱼，剁椒', 1, '2022-06-10 10:28:54', '2022-06-10 10:28:54', 1, 1);
INSERT INTO `dish` VALUES (62, '金汤酸菜牛蛙', 17, 88.00, 'https://chqiwaimai.oss-cn-guangzhou.aliyuncs.com/17.png', '原料：鲜活牛蛙，酸菜', 1, '2022-06-10 10:33:05', '2022-06-10 10:33:05', 1, 1);
INSERT INTO `dish` VALUES (63, '香锅牛蛙', 17, 88.00, 'https://chqiwaimai.oss-cn-guangzhou.aliyuncs.com/18.png', '配料：鲜活牛蛙，莲藕，青笋', 1, '2022-06-10 10:35:40', '2022-06-10 10:35:40', 1, 1);
INSERT INTO `dish` VALUES (64, '馋嘴牛蛙', 17, 88.00, 'https://chqiwaimai.oss-cn-guangzhou.aliyuncs.com/19.png', '配料：鲜活牛蛙，丝瓜，黄豆芽', 1, '2022-06-10 10:37:52', '2022-06-10 10:37:52', 1, 1);
INSERT INTO `dish` VALUES (65, '草鱼2斤', 16, 68.00, 'https://chqiwaimai.oss-cn-guangzhou.aliyuncs.com/20.png', '原料：草鱼，黄豆芽，莲藕', 1, '2022-06-10 10:41:08', '2022-06-10 10:41:08', 1, 1);
INSERT INTO `dish` VALUES (66, '江团鱼2斤', 16, 100.00, 'https://chqiwaimai.oss-cn-guangzhou.aliyuncs.com/21.png', '配料：江团鱼，黄豆芽，莲藕', 1, '2022-06-10 10:42:42', '2024-09-03 15:54:00', 1, 1);
INSERT INTO `dish` VALUES (67, '鮰鱼3斤', 16, 80.00, 'https://chqiwaimai.oss-cn-guangzhou.aliyuncs.com/22.png', '原料：鮰鱼，黄豆芽，莲藕，豆芽菜', 1, '2022-06-10 10:43:56', '2024-09-03 16:07:12', 1, 1);
INSERT INTO `dish` VALUES (68, '鸡蛋汤', 21, 6.00, 'https://chqiwaimai.oss-cn-guangzhou.aliyuncs.com/23.png', '配料：鸡蛋，紫菜', 1, '2022-06-10 10:54:25', '2024-09-03 15:53:35', 1, 1);
INSERT INTO `dish` VALUES (69, '平菇豆腐汤', 21, 6.00, 'https://chqiwaimai.oss-cn-guangzhou.aliyuncs.com/24.png', '配料：豆腐，平菇', 1, '2022-06-10 10:55:02', '2022-06-10 10:55:02', 1, 1);

-- ----------------------------
-- Table structure for dish_flavor
-- ----------------------------
DROP TABLE IF EXISTS `dish_flavor`;
CREATE TABLE `dish_flavor`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `dish_id` bigint(20) NOT NULL COMMENT '菜品',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '口味名称',
  `value` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '口味数据list',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 112 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '菜品口味关系表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of dish_flavor
-- ----------------------------
INSERT INTO `dish_flavor` VALUES (40, 10, '甜味', '[\"无糖\",\"少糖\",\"半糖\",\"多糖\",\"全糖\"]');
INSERT INTO `dish_flavor` VALUES (41, 7, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]');
INSERT INTO `dish_flavor` VALUES (42, 7, '温度', '[\"热饮\",\"常温\",\"去冰\",\"少冰\",\"多冰\"]');
INSERT INTO `dish_flavor` VALUES (45, 6, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]');
INSERT INTO `dish_flavor` VALUES (46, 6, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]');
INSERT INTO `dish_flavor` VALUES (47, 5, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]');
INSERT INTO `dish_flavor` VALUES (48, 5, '甜味', '[\"无糖\",\"少糖\",\"半糖\",\"多糖\",\"全糖\"]');
INSERT INTO `dish_flavor` VALUES (49, 2, '甜味', '[\"无糖\",\"少糖\",\"半糖\",\"多糖\",\"全糖\"]');
INSERT INTO `dish_flavor` VALUES (50, 4, '甜味', '[\"无糖\",\"少糖\",\"半糖\",\"多糖\",\"全糖\"]');
INSERT INTO `dish_flavor` VALUES (51, 3, '甜味', '[\"无糖\",\"少糖\",\"半糖\",\"多糖\",\"全糖\"]');
INSERT INTO `dish_flavor` VALUES (52, 3, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]');
INSERT INTO `dish_flavor` VALUES (86, 52, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]');
INSERT INTO `dish_flavor` VALUES (87, 52, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]');
INSERT INTO `dish_flavor` VALUES (88, 51, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]');
INSERT INTO `dish_flavor` VALUES (89, 51, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]');
INSERT INTO `dish_flavor` VALUES (92, 53, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]');
INSERT INTO `dish_flavor` VALUES (93, 53, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]');
INSERT INTO `dish_flavor` VALUES (94, 54, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\"]');
INSERT INTO `dish_flavor` VALUES (95, 56, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]');
INSERT INTO `dish_flavor` VALUES (96, 57, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]');
INSERT INTO `dish_flavor` VALUES (97, 60, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]');
INSERT INTO `dish_flavor` VALUES (103, 65, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]');
INSERT INTO `dish_flavor` VALUES (109, 66, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]');
INSERT INTO `dish_flavor` VALUES (110, 67, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]');
INSERT INTO `dish_flavor` VALUES (111, 67, '甜味', '[\"无糖\",\"少糖\",\"半糖\",\"多糖\",\"全糖\"]');

-- ----------------------------
-- Table structure for employee
-- ----------------------------
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '姓名',
  `username` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '用户名',
  `password` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '密码',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '手机号',
  `sex` varchar(2) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '性别',
  `id_number` varchar(18) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '身份证号',
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '状态 0:禁用，1:启用',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `create_user` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `update_user` bigint(20) NULL DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '员工信息' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of employee
-- ----------------------------
INSERT INTO `employee` VALUES (1, '管理员', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '13812312312', '1', '110101199001010047', 1, '2022-02-15 15:51:20', '2022-02-17 09:16:20', 10, 1);
INSERT INTO `employee` VALUES (2, 'wo', 'daddad', 'e10adc3949ba59abbe56e057f20f883e', '13143212321', '1', '112345566776554433', 1, '2024-08-15 14:50:29', '2024-08-17 18:57:58', 10, 3);
INSERT INTO `employee` VALUES (3, '露露', 'lumo', 'e10adc3949ba59abbe56e057f20f883e', '13178747827', '0', '440321313123312313', 1, '2024-08-15 15:20:45', '2024-08-15 15:20:45', 10, 10);
INSERT INTO `employee` VALUES (15, '五五', 'aa111', 'e10adc3949ba59abbe56e057f20f883e', '13131131332', '1', '313131131331313', 1, '2024-08-15 16:54:57', '2024-08-22 15:43:34', 10, 1);
INSERT INTO `employee` VALUES (16, '的撒大', 'aaaa', 'e10adc3949ba59abbe56e057f20f883e', '13131313131', '1', '333444555566778899', 1, '2024-08-15 17:03:46', '2024-08-22 15:43:29', 1, 1);

-- ----------------------------
-- Table structure for order_detail
-- ----------------------------
DROP TABLE IF EXISTS `order_detail`;
CREATE TABLE `order_detail`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '名字',
  `image` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '图片',
  `order_id` bigint(20) NOT NULL COMMENT '订单id',
  `dish_id` bigint(20) NULL DEFAULT NULL COMMENT '菜品id',
  `setmeal_id` bigint(20) NULL DEFAULT NULL COMMENT '套餐id',
  `dish_flavor` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '口味',
  `number` int(11) NOT NULL DEFAULT 1 COMMENT '数量',
  `amount` decimal(10, 2) NOT NULL COMMENT '金额',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '订单明细表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of order_detail
-- ----------------------------
INSERT INTO `order_detail` VALUES (1, '江团鱼2斤', 'https://chqiwaimai.oss-cn-guangzhou.aliyuncs.com/21.png', 2, 66, NULL, '不辣', 1, 100.00);
INSERT INTO `order_detail` VALUES (2, '江团鱼2斤', 'https://chqiwaimai.oss-cn-guangzhou.aliyuncs.com/21.png', 2, 66, NULL, '中辣', 1, 100.00);
INSERT INTO `order_detail` VALUES (3, '经典酸菜鮰鱼', 'https://chqiwaimai.oss-cn-guangzhou.aliyuncs.com/7.png', 2, 52, NULL, '中辣,不要蒜', 1, 66.00);
INSERT INTO `order_detail` VALUES (4, '香锅牛蛙', 'https://chqiwaimai.oss-cn-guangzhou.aliyuncs.com/18.png', 2, 63, NULL, NULL, 1, 88.00);

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `number` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '订单号',
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '订单状态 1待付款 2待接单 3已接单 4派送中 5已完成 6已取消 7退款',
  `user_id` bigint(20) NOT NULL COMMENT '下单用户',
  `address_book_id` bigint(20) NOT NULL COMMENT '地址id',
  `order_time` datetime(0) NOT NULL COMMENT '下单时间',
  `checkout_time` datetime(0) NULL DEFAULT NULL COMMENT '结账时间',
  `pay_method` int(11) NOT NULL DEFAULT 1 COMMENT '支付方式 1微信,2支付宝',
  `pay_status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '支付状态 0未支付 1已支付 2退款',
  `amount` decimal(10, 2) NOT NULL COMMENT '实收金额',
  `remark` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '备注',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '手机号',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '地址',
  `user_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '用户名称',
  `consignee` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '收货人',
  `cancel_reason` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '订单取消原因',
  `rejection_reason` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '订单拒绝原因',
  `cancel_time` datetime(0) NULL DEFAULT NULL COMMENT '订单取消时间',
  `estimated_delivery_time` datetime(0) NULL DEFAULT NULL COMMENT '预计送达时间',
  `delivery_status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '配送状态  1立即送出  0选择具体时间',
  `delivery_time` datetime(0) NULL DEFAULT NULL COMMENT '送达时间',
  `pack_amount` int(11) NULL DEFAULT NULL COMMENT '打包费',
  `tableware_number` int(11) NULL DEFAULT NULL COMMENT '餐具数量',
  `tableware_status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '餐具数量状态  1按餐量提供  0选择具体数量',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '订单表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (2, '1725528432144', 1, 1, 1, '2024-09-05 17:27:12', NULL, 1, 1, 364.00, '', '13133466545', NULL, NULL, 'lu', NULL, NULL, NULL, '2024-09-05 18:27:00', 0, NULL, 4, 0, 0);

-- ----------------------------
-- Table structure for setmeal
-- ----------------------------
DROP TABLE IF EXISTS `setmeal`;
CREATE TABLE `setmeal`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `category_id` bigint(20) NOT NULL COMMENT '菜品分类id',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '套餐名称',
  `price` decimal(10, 2) NOT NULL COMMENT '套餐价格',
  `status` int(11) NULL DEFAULT 1 COMMENT '售卖状态 0:停售 1:起售',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '描述信息',
  `image` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '图片',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `create_user` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `update_user` bigint(20) NULL DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_setmeal_name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '套餐' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of setmeal
-- ----------------------------
INSERT INTO `setmeal` VALUES (3, 13, '人气套餐A', 100.00, 1, '好次', 'https://chqiwaimai.oss-cn-guangzhou.aliyuncs.com/4d4dea40-10b0-4313-8455-f10dd392c799.png', '2024-08-30 16:02:54', '2024-08-30 16:02:54', 1, 1);
INSERT INTO `setmeal` VALUES (4, 15, '商务套餐B', 50.00, 1, '便宜', 'https://chqiwaimai.oss-cn-guangzhou.aliyuncs.com/cb214ffd-735b-45d5-b4be-e5bfc707a31e.jpg', '2024-08-30 16:03:54', '2024-08-30 16:03:54', 1, 1);

-- ----------------------------
-- Table structure for setmeal_dish
-- ----------------------------
DROP TABLE IF EXISTS `setmeal_dish`;
CREATE TABLE `setmeal_dish`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `setmeal_id` bigint(20) NULL DEFAULT NULL COMMENT '套餐id',
  `dish_id` bigint(20) NULL DEFAULT NULL COMMENT '菜品id',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '菜品名称 （冗余字段）',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '菜品单价（冗余字段）',
  `copies` int(11) NULL DEFAULT NULL COMMENT '菜品份数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '套餐菜品关系' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of setmeal_dish
-- ----------------------------
INSERT INTO `setmeal_dish` VALUES (9, 3, 68, '鸡蛋汤', 4.00, 1);
INSERT INTO `setmeal_dish` VALUES (10, 3, 46, '王老吉', 6.00, 1);
INSERT INTO `setmeal_dish` VALUES (11, 3, 49, '米饭', 2.00, 1);
INSERT INTO `setmeal_dish` VALUES (12, 3, 54, '清炒小油菜', 18.00, 1);
INSERT INTO `setmeal_dish` VALUES (13, 3, 61, '剁椒鱼头', 66.00, 1);
INSERT INTO `setmeal_dish` VALUES (14, 3, 64, '馋嘴牛蛙', 88.00, 1);
INSERT INTO `setmeal_dish` VALUES (15, 3, 67, '鮰鱼3斤', 70.00, 1);
INSERT INTO `setmeal_dish` VALUES (16, 4, 69, '平菇豆腐汤', 6.00, 1);
INSERT INTO `setmeal_dish` VALUES (17, 4, 49, '米饭', 2.00, 1);
INSERT INTO `setmeal_dish` VALUES (18, 4, 54, '清炒小油菜', 18.00, 1);
INSERT INTO `setmeal_dish` VALUES (19, 4, 58, '清蒸鲈鱼', 98.00, 1);
INSERT INTO `setmeal_dish` VALUES (20, 4, 64, '馋嘴牛蛙', 88.00, 1);

-- ----------------------------
-- Table structure for shopping_cart
-- ----------------------------
DROP TABLE IF EXISTS `shopping_cart`;
CREATE TABLE `shopping_cart`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '商品名称',
  `image` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '图片',
  `user_id` bigint(20) NOT NULL COMMENT '主键',
  `dish_id` bigint(20) NULL DEFAULT NULL COMMENT '菜品id',
  `setmeal_id` bigint(20) NULL DEFAULT NULL COMMENT '套餐id',
  `dish_flavor` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '口味',
  `number` int(11) NOT NULL DEFAULT 1 COMMENT '数量',
  `amount` decimal(10, 2) NOT NULL COMMENT '金额',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '购物车' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `openid` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '微信用户唯一标识',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '姓名',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '手机号',
  `sex` varchar(2) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '性别',
  `id_number` varchar(18) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '身份证号',
  `avatar` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '头像',
  `create_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '用户信息' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'oMmZv7VKp62vVOmXtCiGRVUIpZeE', NULL, NULL, NULL, NULL, NULL, '2024-09-02 17:57:30');

SET FOREIGN_KEY_CHECKS = 1;
