//
//  UIViewController+Utilities.h
//  HBS_C
//
//  Created by 王 世江 on 16/12/13.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Utilities)

-(void)showAlertViewWithMessage:(NSString *)Message title:(NSString *)title tag:(int)tag delegate:(id)delegate leftBtnStr:(NSString *)leftBtnStr rightBtnStr:(NSString *)rightBtnStr;

@end
