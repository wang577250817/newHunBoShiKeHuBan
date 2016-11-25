//
//  BaseTabBarViewController.h
//  HBS_C
//
//  Created by wangzuowen on 16/9/10.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "BaseNavigationViewController.h"
#import "MainViewController.h"
#import "HunBaViewController.h"
#import "MeViewController.h"

@interface BaseTabBarViewController : UITabBarController<UINavigationControllerDelegate>

{
    BaseNavigationViewController *navi;
}
+ (instancetype)instance;
-(NSArray *)tabBars;
- (void)setUpSubNav;

@end
