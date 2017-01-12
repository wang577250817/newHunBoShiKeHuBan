//
//  HBSServiceOrderCell.h
//  HBS_C
//
//  Created by 王 世江 on 16/11/9.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HBSServiceOrderCell;

@protocol HBSServiceOrderCellDelegate <NSObject>

- (void)HBSServiceOrderCell:(HBSServiceOrderCell *)cell WithPhoneUibutton:(UIButton *)btn;

- (void)talkCallDelegate:(HBSServiceOrderCell *)view WithclickTalk:(UIButton *)btn;

//确认完成服务
- (void)sureCompleteService:(HBSServiceOrderCell *)cell WithClickBtn:(UIButton *)btn;

@end


@interface HBSServiceOrderCell : UITableViewCell
@property (nonatomic, strong) NSDictionary *serviceDic;

@property (nonatomic, assign) id<HBSServiceOrderCellDelegate>delegate;

@end
