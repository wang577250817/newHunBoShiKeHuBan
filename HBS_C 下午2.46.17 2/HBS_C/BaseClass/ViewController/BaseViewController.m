//
//  BaseViewController.m
//  HBS_C
//
//  Created by wangzuowen on 16/9/10.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "BaseViewController.h"
#import "UIImage+GIF.h"
#import "Reachability.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)alertWithTitle:(NSString *)title message:(NSString *)message sure:(ACTION)sureAction  cancel:(ACTION)cancelAction
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        cancelAction();
    }];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (sureAction != nil) {
            sureAction();
        }
    }];
    if (cancelAction != nil) {
        [alert addAction:cancel];
    }
    [alert addAction:sure];
    [self presentViewController:alert animated:YES completion:nil];
}
UIView *bgView;
UIImageView  *gifview;

-(void)showLoadingViewWithMessage{
    //    if (gifview == nil) {
    CGPoint centerPoint=[APPDELEGATE window].center;
    UIImage *image=[UIImage sd_animatedGIFNamed:@"jiazai"];
    gifview =[[UIImageView alloc]initWithFrame:CGRectMake(50,80,70, 70)];
    gifview.center = centerPoint;
    //APPDELEGATE.window.userInteractionEnabled=NO;
    gifview.image=image;
    [self.view addSubview:gifview];
    //    }
}
-(void)removeLodingView{
    if (gifview !=nil) {
        [gifview removeFromSuperview];
    }
}
-(BOOL)checkWIFI
{
    Reachability *r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            return NO;
            // 没有网络连接
            break;
        case ReachableViaWWAN:
            return YES;
            // 使用3G网络
            break;
        case ReachableViaWiFi:
            return YES;
            // 使用WiFi网络
            break;
    }
    return nil;
}
@end
