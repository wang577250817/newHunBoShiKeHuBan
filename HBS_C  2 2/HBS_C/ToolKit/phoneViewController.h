//
//  phoneViewController.h
//  Dr.hun
//
//  Created by 王 世江 on 16/7/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface phoneViewController : UIViewController

+ (void)call:(NSString *)no inViewController:(UIViewController *)vc failBlock:(void(^)())failBlock;

@end
