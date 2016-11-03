//
//  BaseViewController.h
//  HBS_C
//
//  Created by wangzuowen on 16/9/10.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ACTION)(void);
@interface BaseViewController : UIViewController
- (void)alertWithTitle:(NSString *)title message:(NSString *)message  sure:(ACTION)sureAction  cancel:(ACTION)cancelAction;
-(BOOL)checkWIFI;
-(void)showLoadingViewWithMessage;
- (void)removeLodingView;
@end
