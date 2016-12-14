//
//  HBSShoppingCarHeadView.h
//  HBS_C
//
//  Created by 王 世江 on 16/11/13.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HBSMyCarHeaderModel;
@class HBSShoppingCarHeadView;

@protocol HBSShoppingCarHeaderViewDelegate <NSObject>

- (void)HBSShoppingCarHeaderViewDelegate:(UIButton *)btn WithHeadView:(HBSShoppingCarHeadView *)view;

@end
@interface HBSShoppingCarHeadView : UIView
//全选按钮
@property (nonatomic, strong) UIButton *selectAllBtn;

@property (nonatomic, strong) id<HBSShoppingCarHeaderViewDelegate>delegate;

//初始化
- (instancetype)initWithFrame:(CGRect)frame WithSection:(NSInteger)section HeadModel:(HBSMyCarHeaderModel *)model;
@end
