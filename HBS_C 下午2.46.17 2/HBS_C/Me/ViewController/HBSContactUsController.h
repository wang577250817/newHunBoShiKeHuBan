//
//  HBSContactUsController.h
//  HBS_C
//
//  Created by 王 世江 on 16/10/27.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "BaseViewController.h"

@interface HBSContactUsController : BaseViewController

+ (void)call:(NSString *)no inViewController:(UIViewController *)vc failBlock:(void(^)())failBlock;

@end
