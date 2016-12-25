//
//  HBSOrderCell.h
//  HBS_C
//
//  Created by 王 世江 on 16/11/4.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HBSOrderCell;
@class HBSOrderModel;

@protocol serviceCancesOrderBtnDelegate <NSObject>
//取消订单
- (void)serviceCancesOrderBtnDelegate:(HBSOrderCell *)cell  WithCancesOrder:(UIButton *)btn;
//确认完成
- (void)serviceSureOrderBtnDelegate:(HBSOrderCell *)cell WithSureOrder:(UIButton *)btn;
//确认收货
//- (void)goodsSure


@end

@interface HBSOrderCell : UITableViewCell

@property (nonatomic, strong) HBSOrderModel *orderModel;
@property (nonatomic, strong) NSDictionary *pingDic;

@property (nonatomic, assign) id<serviceCancesOrderBtnDelegate>delegate;

@end
