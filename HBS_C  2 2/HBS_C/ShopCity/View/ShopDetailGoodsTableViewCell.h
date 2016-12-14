//
//  ShopDetailGoodsTableViewCell.h
//  HBS_C
//
//  Created by wangzuowen on 16/11/1.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCityModel.h"

@interface ShopDetailGoodsTableViewCell : UITableViewCell

@property (nonatomic, strong)NSDictionary *dataDic;

@property (nonatomic, strong)ShopCityModel *model;

@end
