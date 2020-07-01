/*
Navicat MySQL Data Transfer

Source Server         : root
Source Server Version : 50527
Source Host           : localhost:3306
Source Database       : cb

Target Server Type    : MYSQL
Target Server Version : 50527
File Encoding         : 65001

Date: 2020-01-01 17:59:54
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '管理员id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '管理员用户名',
  `password` varchar(255) NOT NULL COMMENT '管理员密码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('1', '李燕玲', '123456789');

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一索引ID',
  `name` varchar(255) NOT NULL COMMENT '分类名',
  `img_url` varchar(255) NOT NULL COMMENT '分类详情图地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('1', '护肤', '../home/images/category/banner01.jpg');
INSERT INTO `category` VALUES ('2', '彩妆', '../home/images/category/banner02.jpg');
INSERT INTO `category` VALUES ('3', '香氛', '../home/images/category/banner03.jpg');
INSERT INTO `category` VALUES ('4', '美发', '../home/images/category/banner04.jpg');
INSERT INTO `category` VALUES ('5', '工具', '../home/images/category/banner05.jpg');
INSERT INTO `category` VALUES ('6', '套装', '../home/images/category/banner06.jpg');

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一索引id',
  `order_code` varchar(255) NOT NULL COMMENT '订单号',
  `address` varchar(255) NOT NULL COMMENT '收货地址',
  `receiver` varchar(255) NOT NULL COMMENT '收货人姓名',
  `phone` varchar(255) NOT NULL COMMENT '手机号码',
  `user_message` varchar(255) NOT NULL COMMENT '用户备注的信息',
  `create_date` datetime NOT NULL COMMENT '订单创建时间',
  `pay_date` datetime DEFAULT NULL COMMENT '订单支付时间',
  `delivery_date` datetime DEFAULT NULL COMMENT '发货日期',
  `confirm_date` datetime DEFAULT NULL COMMENT '确认收货日期',
  `user_id` int(11) DEFAULT NULL COMMENT '对应的用户id',
  `status` varchar(255) NOT NULL COMMENT '订单状态',
  PRIMARY KEY (`id`),
  KEY `fk_order_user` (`user_id`),
  CONSTRAINT `fk_order_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES ('1', '1534897682346689', '福建省泉州市鲤城区', '李燕玲', '15359988084', '希望快点发货', '2019-12-03 00:00:00', '2019-12-03 00:00:00', '2019-12-06 16:33:30', '2019-12-07 00:00:00', '1', '待收货');
INSERT INTO `orders` VALUES ('17', '20191225141325038', '福建省三明市安砂镇加福', '李燕玲', '15359988084', '东西好的话会推荐的', '2019-12-25 00:00:00', '2019-12-25 00:00:00', '2019-12-25 00:00:00', '2019-12-25 00:00:00', '8', 'delete');
INSERT INTO `orders` VALUES ('18', '20191225223906761', '福建省泉州市鲤城区媒人桥2号泉州师范学院软件学院', '李燕玲', '15359988084', '快点发货', '2019-12-25 00:00:00', '2019-12-25 00:00:00', '2019-12-25 00:00:00', '2019-12-25 00:00:00', '9', 'finish');
INSERT INTO `orders` VALUES ('19', '20191226145107280', '福建省永春县', '康玉娴', '15359988084', '希望好用', '2019-12-26 00:00:00', '2019-12-26 00:00:00', '2019-12-26 00:00:00', '2019-12-26 00:00:00', '9', 'delete');

-- ----------------------------
-- Table structure for order_item
-- ----------------------------
DROP TABLE IF EXISTS `order_item`;
CREATE TABLE `order_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一索引id',
  `product_id` int(11) NOT NULL COMMENT '对应产品id',
  `order_id` int(11) DEFAULT NULL COMMENT '对应订单id',
  `user_id` int(11) NOT NULL COMMENT '对应用户id',
  `number` int(11) DEFAULT NULL COMMENT '对应产品购买的数量',
  PRIMARY KEY (`id`),
  KEY `fk_order_item_product` (`product_id`),
  KEY `fk_order_item_order` (`order_id`),
  KEY `fk_order_item_user` (`user_id`),
  CONSTRAINT `fk_order_item_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `fk_order_item_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `fk_order_item_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of order_item
-- ----------------------------
INSERT INTO `order_item` VALUES ('1', '1', '1', '1', '4');
INSERT INTO `order_item` VALUES ('44', '4', '17', '8', '3');
INSERT INTO `order_item` VALUES ('45', '1', '17', '8', '1');
INSERT INTO `order_item` VALUES ('50', '5', '18', '9', '1');
INSERT INTO `order_item` VALUES ('52', '8', null, '9', '1');
INSERT INTO `order_item` VALUES ('53', '12', '19', '9', '1');
INSERT INTO `order_item` VALUES ('54', '9', null, '10', '1');

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一索引id',
  `name` varchar(255) NOT NULL COMMENT '产品的名称',
  `sub_title` varchar(255) DEFAULT NULL COMMENT '小标题',
  `price` float DEFAULT NULL COMMENT '价格',
  `sale` int(11) DEFAULT NULL COMMENT '销量',
  `stock` int(11) DEFAULT NULL COMMENT '库存',
  `description` varchar(2000) NOT NULL COMMENT '商品描述',
  `brand` varchar(255) NOT NULL COMMENT '品牌',
  `category_id` int(11) DEFAULT NULL COMMENT '对应的分类id',
  PRIMARY KEY (`id`),
  KEY `fk_product_category` (`category_id`),
  CONSTRAINT `fk_product_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES ('1', '探险家十二色动物眼影', '老虎盘小猪盘鳄鱼盘冰狼盘-彩妆', '129.9', '5664', '23', '有效提亮肤色', '完美日记', '2');
INSERT INTO `product` VALUES ('2', 'm3梦幻洁面乳', 'Dreamtimes洗面奶女深层清洁毛孔控油补水保湿-护肤', '80.9', '569', '55', '完美无瑕', 'Dreamtimes', '1');
INSERT INTO `product` VALUES ('3', '香水', '好闻-香氛', '56', '12321', '612', '完美无瑕', 'Dreamtimes', '3');
INSERT INTO `product` VALUES ('4', '黑人面膜', '保湿-护肤', '89', '123', '235', '完美无瑕', '迪奥', '1');
INSERT INTO `product` VALUES ('5', '圣罗兰弹润保湿精华水', '液态微粒 迅速补水-护肤', '600', '23', '235', '弹润一滴，肌肤嘭弹喝饱水<br> 橙花和维他命E&B3的组合有效抵御外界伤害<br> 维他命E帮助保护肌肤对抗自由基 <br>维他命B3帮助舒缓皮肤 <br>液态微粒科技 <br>迅速补充肌肤水分', 'YSL', '1');
INSERT INTO `product` VALUES ('7', '圣罗兰胜肽精华液', '深微渗透 立显紧致-护肤', '790', '56', '454', '深微渗透，5倍吸收，肌肤立显紧致 2种胜肽 <br> 一种促进胶原纤维环扣生成，使肌肤更紧致<br> 另一种增加胶原蛋白，帮助缓解各种皱纹<br> 微乳技术更深渗透肌肤，即刻带来紧致肤感', 'YSL', '1');
INSERT INTO `product` VALUES ('8', '圣罗兰先锋男士香水', '一支浓郁深沉的木质馥奇香调香水 馥奇香调 浓郁深沉-香氛', '1050', '235', '23', '圣罗兰先锋男士香水(浓香型) <br>一支浓郁深沉的木质馥奇香调香水<br> 馥奇香调 浓郁深沉 <br>前调 | 苹果 醛 生姜 佛手柑 榄香<br> 中调 | 鼠尾草 杜松 薰衣草 天竺葵 <br>基调 | 琥珀木 香根草 零陵香豆 乳香', 'YSL', '3');
INSERT INTO `product` VALUES ('9', '茶鲜水乳套装', '高保湿霜 清爽控油 绿茶补水-套装', '169', '563', '1924', '土家硒泥坊茶鲜护肤4件套补水保湿控油收缩毛孔精华水护肤品套装', '土家硒泥坊', '6');
INSERT INTO `product` VALUES ('10', '茶鲜洗面奶', '男女士补水保湿深层清洁毛孔控油洁面乳-护肤', '69', '126', '1679', '补水保湿 清洁毛孔 清爽控油 不紧绷', '土家硒泥坊', '1');
INSERT INTO `product` VALUES ('11', '绿豆小黄瓜爽肤水', '补水保湿水清爽控油-护肤', '75.9', '410', '6503', '清爽控油 补水保湿 舒缓不适', '土家硒泥坊', '1');
INSERT INTO `product` VALUES ('12', '美白烟酰胺面膜', '保湿补水淡斑收缩毛孔紧致淡化祛痘印男女专用-护肤', '59.9', '1532', '7998', '限量发30片烟酰胺面膜，送正装烟酰胺原液2瓶', '资莱皙', '1');

-- ----------------------------
-- Table structure for product_image
-- ----------------------------
DROP TABLE IF EXISTS `product_image`;
CREATE TABLE `product_image` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一索引id',
  `product_id` int(11) DEFAULT NULL COMMENT '产品ID',
  PRIMARY KEY (`id`),
  KEY `fk_product_image_product` (`product_id`),
  CONSTRAINT `fk_product_image_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of product_image
-- ----------------------------
INSERT INTO `product_image` VALUES ('1', '1');
INSERT INTO `product_image` VALUES ('2', '1');
INSERT INTO `product_image` VALUES ('3', '1');
INSERT INTO `product_image` VALUES ('5', '1');
INSERT INTO `product_image` VALUES ('6', '2');
INSERT INTO `product_image` VALUES ('7', '2');
INSERT INTO `product_image` VALUES ('8', '2');
INSERT INTO `product_image` VALUES ('9', '2');
INSERT INTO `product_image` VALUES ('10', '2');
INSERT INTO `product_image` VALUES ('11', '3');
INSERT INTO `product_image` VALUES ('12', '3');
INSERT INTO `product_image` VALUES ('13', '3');
INSERT INTO `product_image` VALUES ('14', '3');
INSERT INTO `product_image` VALUES ('15', '3');
INSERT INTO `product_image` VALUES ('16', '4');
INSERT INTO `product_image` VALUES ('17', '4');
INSERT INTO `product_image` VALUES ('18', '4');
INSERT INTO `product_image` VALUES ('19', '4');
INSERT INTO `product_image` VALUES ('20', '4');
INSERT INTO `product_image` VALUES ('21', '5');
INSERT INTO `product_image` VALUES ('22', '5');
INSERT INTO `product_image` VALUES ('23', '5');
INSERT INTO `product_image` VALUES ('24', '5');
INSERT INTO `product_image` VALUES ('25', '5');
INSERT INTO `product_image` VALUES ('31', '7');
INSERT INTO `product_image` VALUES ('32', '7');
INSERT INTO `product_image` VALUES ('33', '7');
INSERT INTO `product_image` VALUES ('34', '7');
INSERT INTO `product_image` VALUES ('35', '7');
INSERT INTO `product_image` VALUES ('36', '8');
INSERT INTO `product_image` VALUES ('37', '8');
INSERT INTO `product_image` VALUES ('38', '8');
INSERT INTO `product_image` VALUES ('39', '8');
INSERT INTO `product_image` VALUES ('40', '8');
INSERT INTO `product_image` VALUES ('41', '9');
INSERT INTO `product_image` VALUES ('42', '9');
INSERT INTO `product_image` VALUES ('43', '9');
INSERT INTO `product_image` VALUES ('44', '9');
INSERT INTO `product_image` VALUES ('45', '9');
INSERT INTO `product_image` VALUES ('46', '10');
INSERT INTO `product_image` VALUES ('47', '10');
INSERT INTO `product_image` VALUES ('48', '10');
INSERT INTO `product_image` VALUES ('49', '10');
INSERT INTO `product_image` VALUES ('50', '10');
INSERT INTO `product_image` VALUES ('51', '11');
INSERT INTO `product_image` VALUES ('52', '11');
INSERT INTO `product_image` VALUES ('53', '11');
INSERT INTO `product_image` VALUES ('54', '11');
INSERT INTO `product_image` VALUES ('55', '11');
INSERT INTO `product_image` VALUES ('56', '12');
INSERT INTO `product_image` VALUES ('57', '12');
INSERT INTO `product_image` VALUES ('58', '12');
INSERT INTO `product_image` VALUES ('59', '12');
INSERT INTO `product_image` VALUES ('60', '12');

-- ----------------------------
-- Table structure for property
-- ----------------------------
DROP TABLE IF EXISTS `property`;
CREATE TABLE `property` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一索引id',
  `name` varchar(255) DEFAULT NULL COMMENT '属性名称',
  `category_id` int(11) NOT NULL COMMENT '对应的分类id',
  PRIMARY KEY (`id`),
  KEY `fk_property_category` (`category_id`),
  CONSTRAINT `fk_property_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of property
-- ----------------------------
INSERT INTO `property` VALUES ('1', '颜色分类', '2');
INSERT INTO `property` VALUES ('2', '更多版本1.0', '2');
INSERT INTO `property` VALUES ('3', '化妆品净含量', '1');
INSERT INTO `property` VALUES ('4', '版本', '1');
INSERT INTO `property` VALUES ('5', '味道', '3');
INSERT INTO `property` VALUES ('6', '颜色', '5');
INSERT INTO `property` VALUES ('7', '香味', '4');
INSERT INTO `property` VALUES ('8', '作用', '4');
INSERT INTO `property` VALUES ('9', '作用1.0', '5');
INSERT INTO `property` VALUES ('10', '作用', '3');
INSERT INTO `property` VALUES ('11', '用处', '5');
INSERT INTO `property` VALUES ('12', '适用皮肤', '1');
INSERT INTO `property` VALUES ('13', '颜色分类', '3');
INSERT INTO `property` VALUES ('14', '净含量', '3');
INSERT INTO `property` VALUES ('15', '颜色分类', '6');
INSERT INTO `property` VALUES ('16', '功效', '6');
INSERT INTO `property` VALUES ('17', '限期使用日期范围', '6');
INSERT INTO `property` VALUES ('18', '化妆品保质期', '6');
INSERT INTO `property` VALUES ('19', '适合肤质', '6');
INSERT INTO `property` VALUES ('20', '产地', '6');

-- ----------------------------
-- Table structure for property_value
-- ----------------------------
DROP TABLE IF EXISTS `property_value`;
CREATE TABLE `property_value` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一索引id',
  `product_id` int(11) NOT NULL COMMENT '对应产品id',
  `property_id` int(11) NOT NULL COMMENT '对应属性id',
  `value` varchar(255) DEFAULT NULL COMMENT '具体的属性值',
  PRIMARY KEY (`id`),
  KEY `fk_property_value_property` (`property_id`),
  KEY `fk_property_value_product` (`product_id`),
  CONSTRAINT `fk_property_value_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `fk_property_value_property` FOREIGN KEY (`property_id`) REFERENCES `property` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of property_value
-- ----------------------------
INSERT INTO `property_value` VALUES ('1', '1', '1', '01小猪    02斑虎    03鳄鱼    04冰狼    05小熊猫');
INSERT INTO `property_value` VALUES ('6', '2', '3', '120ml');
INSERT INTO `property_value` VALUES ('7', '3', '10', '魅力');
INSERT INTO `property_value` VALUES ('11', '4', '12', '全部');
INSERT INTO `property_value` VALUES ('12', '5', '3', '120ml');
INSERT INTO `property_value` VALUES ('13', '7', '3', '30ml');
INSERT INTO `property_value` VALUES ('14', '8', '14', '40ml 60ml 100ml');
INSERT INTO `property_value` VALUES ('15', '8', '13', '淡香型 浓香型');
INSERT INTO `property_value` VALUES ('16', '9', '19', '任何肤质');
INSERT INTO `property_value` VALUES ('17', '9', '20', '中国');
INSERT INTO `property_value` VALUES ('18', '9', '18', '3年');
INSERT INTO `property_value` VALUES ('19', '9', '16', '补水 保湿 控油 收缩毛孔');
INSERT INTO `property_value` VALUES ('20', '10', '3', '100g');
INSERT INTO `property_value` VALUES ('21', '11', '3', '150g');
INSERT INTO `property_value` VALUES ('22', '12', '3', '30片');

-- ----------------------------
-- Table structure for review
-- ----------------------------
DROP TABLE IF EXISTS `review`;
CREATE TABLE `review` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一索引id',
  `content` varchar(4000) DEFAULT NULL COMMENT '评价内容',
  `user_id` int(11) NOT NULL COMMENT '对应的用户id',
  `product_id` int(11) NOT NULL COMMENT '对应的产品id',
  `createDate` datetime DEFAULT NULL COMMENT '评价时间',
  PRIMARY KEY (`id`),
  KEY `fk_review_product` (`product_id`),
  KEY `fk_review_user` (`user_id`),
  CONSTRAINT `fk_review_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `fk_review_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of review
-- ----------------------------
INSERT INTO `review` VALUES ('1', '眼影特别的好,舍友都说很好看，喜欢', '1', '1', '2019-12-06 12:56:45');
INSERT INTO `review` VALUES ('2', '非常的好！', '2', '1', '2019-12-18 01:08:45');
INSERT INTO `review` VALUES ('3', '东西很好', '5', '3', '2019-12-23 08:40:53');
INSERT INTO `review` VALUES ('4', '眼影真的很不错，爱了爱了', '8', '1', '2019-12-25 14:43:04');
INSERT INTO `review` VALUES ('5', '东西很好用呀', '9', '5', '2019-12-25 22:40:32');
INSERT INTO `review` VALUES ('6', '这个面膜非常的好用', '9', '12', '2019-12-26 14:55:52');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一索引id',
  `name` varchar(255) NOT NULL COMMENT '用户名称',
  `password` varchar(255) NOT NULL COMMENT '用户密码',
  `email` varchar(255) NOT NULL COMMENT '邮箱',
  `registTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '注册时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', '玲玲', '57689564', '574969575@qq.com', '2019-12-03 00:00:00');
INSERT INTO `user` VALUES ('2', '珊珊', '123456', '134678863@qq.com', '2019-12-05 23:29:54');
INSERT INTO `user` VALUES ('3', '小胖子', '123456', '574969575@qq.com', '2019-12-17 19:26:47');
INSERT INTO `user` VALUES ('4', '壮壮', '123456', '45413181@qq.com', '2019-12-17 22:06:04');
INSERT INTO `user` VALUES ('5', 'der', '456123', '574969575@qq.com', '2019-12-22 00:00:00');
INSERT INTO `user` VALUES ('6', '李燕玲', '123456', '574969575@qq.com', '2019-12-17 22:59:22');
INSERT INTO `user` VALUES ('7', '康康', '123456', '574969575@qq.com', '2019-12-17 23:29:21');
INSERT INTO `user` VALUES ('8', '我是一朵蘑菇', '123456', '574969575@qq.com', '2019-12-25 14:05:00');
INSERT INTO `user` VALUES ('9', '一朵欢快的蘑菇', '123456789', '574969575@qq.com', '2019-12-25 21:54:33');
INSERT INTO `user` VALUES ('10', '婷婷', '123', '574969575@qq.com', '2019-12-31 21:22:34');
