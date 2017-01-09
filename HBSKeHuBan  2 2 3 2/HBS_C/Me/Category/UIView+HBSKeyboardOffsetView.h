//
//  UIView+HBSKeyboardOffsetView.h
//  HBS_C
//
//  Created by 王 世江 on 16/12/10.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *   键盘补偿视图协议
 */
@protocol CLKeyboardOffsetViewDelegate <NSObject>

/**
 *  弹出键盘时，自定义视图向上移动的高度
 *
 *  @param firstResponder 第一响应者
 *  @param keyboardHeight 当前弹出键盘的高度
 *  @param offsetHeight   默认偏移高度
 *
 *  @return 视图向上移动的高度
 */
- (CGFloat)offsetViewHeightWithFirstResponder:(UIView *)firstResponder
                               keyboardHeight:(CGFloat)keyboardHeight
                                 offsetHeight:(CGFloat)offsetHeight;

@end

@interface UIView (HBSKeyboardOffsetView)

/** 键盘与第一响应者的间隙，默认值为5.0 */
@property (nonatomic, assign) CGFloat keyboardGap;

/** 委托，用于设置视图偏移的高度 */
@property (nonatomic, weak) id<CLKeyboardOffsetViewDelegate> keyboardOffsetViewDelegate;

/** 打开键盘补偿视图 */
- (void)openKeyboardOffsetView;
/** 关闭键盘补偿视图 */
- (void)closeKeyboardOffsetView;


@end
