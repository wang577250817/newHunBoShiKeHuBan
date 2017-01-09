//
//  HBSServiceModel.h
//  HBS_C
//
//  Created by 王 世江 on 16/11/2.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HBSServiceModel : NSObject

@property (nonatomic, copy) NSString *goods_name;//商品名字
@property (nonatomic, copy) NSString *goods_image;//商品图片
@property (nonatomic, copy) NSString *goods_price;//现价
@property (nonatomic, copy) NSString *goods_price_market;//原价
@property (nonatomic, copy) NSString *goods_id;//服务ID

@end
