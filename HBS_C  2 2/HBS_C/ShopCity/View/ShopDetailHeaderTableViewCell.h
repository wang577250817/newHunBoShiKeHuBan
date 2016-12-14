//
//  ShopDetailHeaderTableViewCell.h
//  HBS_C
//
//  Created by wangzuowen on 16/11/1.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCityModel.h"

@interface ShopDetailHeaderTableViewCell : UITableViewCell

@property (nonatomic, strong)UIButton *moreButton;

@property (nonatomic, strong)ShopCityModel *model;
@property (nonatomic, assign)BOOL isMore;

@end
