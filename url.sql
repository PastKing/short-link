/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80200
 Source Host           : localhost:3306
 Source Schema         : url

 Target Server Type    : MySQL
 Target Server Version : 80200
 File Encoding         : 65001

 Date: 18/05/2024 21:31:54
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '姓名',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色标识',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '电话',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '管理员' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'admin', 'admin', '管理员', 'http://localhost:9090/files/1697438073596-avatar.png', 'ADMIN', '13677889922', 'admin@xm.com');
INSERT INTO `admin` VALUES (2, 'asd', '123', '1', NULL, 'ADMIN', '1', '1');

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '标题',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '内容',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建时间',
  `user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '公告信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of notice
-- ----------------------------
INSERT INTO `notice` VALUES (1, '测试', '公告测试', '2023-09-05', 'admin');

-- ----------------------------
-- Table structure for url
-- ----------------------------
DROP TABLE IF EXISTS `url`;
CREATE TABLE `url`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `dwz` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `llurl` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `admin` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of url
-- ----------------------------
INSERT INTO `url` VALUES (2, '8b2ac2', 'www.baidu.cccccc', '2024-03-18 20:00:14', 1);
INSERT INTO `url` VALUES (3, '2dc718', 'www.google.com', '2024-03-18 20:04:46', 1);
INSERT INTO `url` VALUES (4, '1943af', 'www.abc.cn', '2024-03-18 20:08:55', 2);
INSERT INTO `url` VALUES (5, 'bdf27a', 'http://www.baidu.com', '2024-03-18 20:10:06', NULL);
INSERT INTO `url` VALUES (6, '3dce0a', 'http://www.baidu.com', '2024-03-18 20:10:13', NULL);
INSERT INTO `url` VALUES (7, 'cd0a23', 'http://www.baidu.com', '2024-03-18 20:10:14', NULL);
INSERT INTO `url` VALUES (8, 'cc8af2', 'http://www.baidu.com', '2024-03-18 20:10:14', NULL);
INSERT INTO `url` VALUES (9, 'cbeea8', 'http://www.baidu.com', '2024-03-18 20:10:15', NULL);
INSERT INTO `url` VALUES (11, 'c7362d', '123.com', '2024-03-18 20:23:37', NULL);
INSERT INTO `url` VALUES (13, 'b1e562', 'http://www.baidu.com', '2024-03-18 20:28:09', 1);
INSERT INTO `url` VALUES (14, '8a9ca7', 'http://www.zhihu.com', '2024-03-19 21:57:19', NULL);
INSERT INTO `url` VALUES (15, 'b96c7d', 'http://www.zhihu.com', '2024-03-19 21:57:38', NULL);
INSERT INTO `url` VALUES (16, '001a4a', 'http://www.baidu.com', '2024-05-18 21:25:31', NULL);
INSERT INTO `url` VALUES (17, '245f73', 'http://www.baidu.com', '2024-05-18 21:25:50', NULL);

SET FOREIGN_KEY_CHECKS = 1;
