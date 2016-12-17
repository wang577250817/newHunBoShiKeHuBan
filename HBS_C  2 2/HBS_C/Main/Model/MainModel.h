//
//  MainModel.h
//  HBS_C
//
//  Created by wangzuowen on 16/10/14.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "WZWModel.h"

@interface MainModel : WZWModel

@property (nonatomic, copy)NSString *adv_image;
@property (nonatomic, copy)NSString *adv_item_id;
@property (nonatomic, copy)NSString *adv_type;
@property (nonatomic, copy)NSString *adv_url;

@property (nonatomic, copy)NSString *tab_img;

@property (nonatomic, copy)NSString *goods_image;
@property (nonatomic, copy)NSString *goods_name;
@property (nonatomic, copy)NSString *goods_id;
@property (nonatomic, copy)NSString *goods_type;

@property (nonatomic, copy)NSString *cate_name;
@property (nonatomic, copy)NSString *cate_img;
@property (nonatomic, copy)NSString *cate_id;
//管家列表
@property (nonatomic, retain)NSArray *store_images;
@property (nonatomic, copy)NSString *store_logo;//logo图片地址;
@property (nonatomic, copy)NSString *store_description;//": "店铺简介"
@property (nonatomic, copy)NSString *store_collects;//": "粉丝数",;
@property (nonatomic, copy)NSString *store_comment;//": "评论数";
@property (nonatomic, copy)NSString *store_name;//": "店铺名称",;
@property (nonatomic, copy)NSString *store_id;//": "店铺名称",;
//婚品列表
@property (nonatomic, copy)NSString *goods_price;
@property (nonatomic, copy)NSString *goods_price_market;//image id name
@property (nonatomic, copy)NSString *goods_cate_name;

//猜你喜欢
@property (nonatomic, copy)NSString *rec_goods_name;
@property (nonatomic, copy)NSString *rec_goods_id;
@property (nonatomic, copy)NSString *rec_goods_price;
@property (nonatomic, copy)NSString *rec_goods_price_market;
@property (nonatomic, copy)NSString *rec_goods_image;
//地址列表
@property (nonatomic, copy)NSString *consignee;
@property (nonatomic, copy)NSString *region_name;
@property (nonatomic, copy)NSString *address;
@property (nonatomic, copy)NSString *phone_mob;
@property (nonatomic, copy)NSString *def_recive;
@property (nonatomic, copy)NSString *addr_id;
//car
@property (nonatomic, retain)NSArray *goods;
@end
