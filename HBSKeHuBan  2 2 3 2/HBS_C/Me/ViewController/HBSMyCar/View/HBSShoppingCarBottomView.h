//
//  HBSShoppingCarBottomView.h
//  HBS_C
//
//  Created by 王 世江 on 16/11/14.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HBSMyCarBottomModel;
@class HBSShoppingCarBottomView;

@protocol HBSShoppingCarBottomViewDelegate <NSObject>

- (void)HBSShoppingCarBottomViewDelegate:(UIButton *)allselBtn;

@end

@interface HBSShoppingCarBottomView : UIView

//模型属性控制btn的状态
@property (nonatomic, strong) HBSMyCarBottomModel *bottomModel;
//全选按钮
@property (nonatomic, strong) UIButton *allSelectBtn;
//总价label
@property (nonatomic, strong) UILabel *resultPriceLabel;
//总价代理
@property(nonatomic, assign) id<HBSShoppingCarBottomViewDelegate>delegate;

//初始化
- (instancetype)initWithFrame:(CGRect)frame With:(HBSMyCarBottomModel *)bottomModel;
@end
