//
//  UIViewController+Utilities.m
//  HBS_C
//
//  Created by 王 世江 on 16/12/13.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "UIViewController+Utilities.h"

@implementation UIViewController (Utilities)

-(void)showAlertViewWithMessage:(NSString *)Message title:(NSString *)title tag:(int)tag delegate:(id)delegate leftBtnStr:(NSString *)leftBtnStr rightBtnStr:(NSString *)rightBtnStr{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:title message:Message delegate:delegate cancelButtonTitle:leftBtnStr otherButtonTitles:rightBtnStr, nil];
    [alert show];
    if (tag!=0) {
        alert.tag=tag;
    }
}

@end
