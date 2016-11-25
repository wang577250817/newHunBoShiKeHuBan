//
//  HBSGoodModel.h
//  HBS_C
//
//  Created by 王 世江 on 16/11/10.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HBSGoodModel : NSObject
@property (nonatomic, copy) NSString *goods_image;
@property (nonatomic, copy) NSString *goods_name;
@property (nonatomic, copy) NSString *goods_spec;
@property (nonatomic, copy) NSString *goods_amount;
@property (nonatomic, copy) NSString *goods_quantity;
@property (nonatomic, copy) NSString *order_timestamp;//订单服务时间
@end
