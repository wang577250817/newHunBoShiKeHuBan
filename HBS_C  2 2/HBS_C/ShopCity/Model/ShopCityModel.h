//
//  ShopCityModel.h
//  HBS_C
//
//  Created by wangzuowen on 16/10/18.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "WZWModel.h"

@interface ShopCityModel : WZWModel

@property (nonatomic, copy)NSString *cate_name;
@property (nonatomic, copy)NSString *cate_img;
@property (nonatomic, copy)NSString *cate_id;
///店铺
@property (nonatomic, copy)NSString *store_banner;
@property (nonatomic, copy)NSString *store_logo;
@property (nonatomic, copy)NSString *store_tel;
@property (nonatomic, copy)NSString *store_state;
@property (nonatomic, copy)NSString *store_im;

@property (nonatomic, copy)NSString *cases_count;
@property (nonatomic, copy)NSString *articles_count;
@property (nonatomic, copy)NSString *goods_count;
@property (nonatomic, strong)NSArray *goods_info;
@property (nonatomic, strong)NSArray *articles_info;
@property (nonatomic, strong)NSArray *cases_info;
@property (nonatomic, copy)NSString *cate_url;
//header
@property (nonatomic, copy)NSString *store_name;
@property (nonatomic, copy)NSString *store_cateName;
@property (nonatomic, copy)NSString *store_description;
@property (nonatomic, copy)NSString *store_address;
@property (nonatomic, copy)NSString *store_views;
@property (nonatomic, copy)NSString *store_collects;
//评价分区
@property (nonatomic, copy)NSString *comment_count;
@property (nonatomic, copy)NSString *comment_star;
@property (nonatomic, copy)NSString *comment_time;
@property (nonatomic, copy)NSString *comment;
@property (nonatomic, copy)NSString *comment_name;
@property (nonatomic, copy)NSString *comment_head;
@property (nonatomic, copy)NSString *comment_url;
//商铺详情传到下一页的参数
@property (nonatomic, copy)NSString *store_id;
@property (nonatomic, copy)NSString *store_cateId;

//case列表
@property (nonatomic, copy)NSString *goods_store_id;
@property (nonatomic, copy)NSString *goods_name;
@property (nonatomic, copy)NSString *goods_id;
@property (nonatomic, copy)NSString *goods_image;
@property (nonatomic, copy)NSString *goods_price;
@property (nonatomic, copy)NSString *goods_price_market;

@end
