//
//  HBSMyCarModel.h
//  HBS_C
//
//  Created by 王 世江 on 16/11/10.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HBSMyCarModel : NSObject

@property (nonatomic, copy) NSString *goods_image;//商品图片
@property (nonatomic, copy) NSString *goods_name;//商品名字
@property (nonatomic, copy) NSString *goods_specification;//商品规格
@property (nonatomic, copy) NSString *goods_price;//商品价格
@property (nonatomic, copy) NSString *goods_quantity;//商品数量
@property (nonatomic, copy) NSString *rec_id;//删除id
@property (nonatomic, strong, readonly) NSMutableArray *goods;

//选中状态
@property (nonatomic, assign) BOOL isSelect;
@end
