//
//  HBSOrderCell.h
//  HBS_C
//
//  Created by 王 世江 on 16/11/4.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HBSOrderModel;
@interface HBSOrderCell : UITableViewCell

@property (nonatomic, strong) HBSOrderModel *orderModel;
@property (nonatomic, strong) NSDictionary *pingDic;
@end
