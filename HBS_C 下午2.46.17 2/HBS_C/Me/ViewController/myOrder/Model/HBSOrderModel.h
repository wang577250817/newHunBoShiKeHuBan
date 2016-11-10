//
//  HBSOrderModel.h
//  HBS_C
//
//  Created by 王 世江 on 16/11/4.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HBSOrderModel : NSObject
@property (nonatomic, copy) NSString *order_store_name;//店名
@property (nonatomic, copy) NSString *order_status;//状态
@property (nonatomic, copy) NSString *order_type;//类型
@property (nonatomic, copy) NSString *goods_image;//服务image
@property (nonatomic, copy) NSMutableArray *order_goods_info;//服务数组
@property (nonatomic, assign) CGFloat goods_num;//商品数量
@property (nonatomic, copy) NSString *order_amount;//钱数
@property (nonatomic, copy) NSString *goods_name;//商品名字
@property (nonatomic, copy) NSString *goods_spec;//商品规格
@property (nonatomic, copy) NSString *goods_quantity;//商品数量

//重写cell的高度
@property (nonatomic, assign) CGFloat cellHeight;
//中间内容的高度
@property (nonatomic, assign) CGRect contentF;
@property (nonatomic, assign) CGRect contentG;
@end
