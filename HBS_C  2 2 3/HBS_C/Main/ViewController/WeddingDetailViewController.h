//
//  WeddingDetailViewController.h
//  HBS_C
//
//  Created by wangzuowen on 16/10/26.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSUInteger, DetailType) {
    DetailTypeWedding = 0,//婚品
    DetailTypeGoods,//服务
    DetailTypeCase,//案例
};

@interface WeddingDetailViewController : BaseViewController

@property (nonatomic, copy)NSString *goods_id;
@property (nonatomic, assign)DetailType type;

@end
