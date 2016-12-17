//
//  BaseViewController.h
//  HBS_C
//
//  Created by wangzuowen on 16/9/10.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ACTION)(void);
typedef void(^ALERTLOCK)(id result);
@interface BaseViewController : UIViewController

-(void)showLoadingViewWithMessage;
- (void)removeLodingView;
-(BOOL)checkWIFI;

- (void)noNetWorkView:(UIView *)fatherView;

- (void)creatAlertWithTimer:(NSString *)message fatherView:(UIView *)fView;
- (void)creatAlertView:(NSString *)title message:(NSString *)message sureStr:(NSString *)sureStr cancelStr:(NSString *)cancelStr sureAction:(ALERTLOCK)block cancelAction:(ALERTLOCK)cancelBlock;
- (void)creatAlertViewOne:(NSString *)title message:(NSString *)message sureStr:(NSString *)sureStr sureAction:(ALERTLOCK)block;
- (void)alertWithTitle:(NSString *)title message:(NSString *)message  sure:(ACTION)sureAction  cancel:(ACTION)cancelAction;
//判断字符数(非数字)
- (NSInteger)convertToInt:(NSString*)strtemp;


@end
