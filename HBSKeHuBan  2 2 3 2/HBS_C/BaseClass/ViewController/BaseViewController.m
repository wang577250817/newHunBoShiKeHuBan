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
    self.view.backgroundColor = WZWwhiteColor;
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:FENSE}];
    
}
//UIView *bgView;
UIImageView  *gifview;

-(void)showLoadingViewWithMessage{
        CGPoint centerPoint=[APPDELEGATE window].center;
        UIImage *image=[UIImage sd_animatedGIFNamed:@"jiazai"];
        gifview =[[UIImageView alloc]initWithFrame:CGRectMake(50,80,70, 70)];
        gifview.center = centerPoint;
        //APPDELEGATE.window.userInteractionEnabled=NO;
        gifview.image=image;
        [self.view addSubview:gifview];
}
-(void)removeLodingView{
    if (gifview !=nil) {
        [gifview removeFromSuperview];
    }
}
- (void)noNetWorkView:(UIView *)fatherView
{
    _errorImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, WIDTH , HEIGHT - 64)];
    _errorImage.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"img_wangluoyichang@2x" ofType:@"png"]];
    [fatherView addSubview:_errorImage];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(freshAction)];
    [self.errorImage addGestureRecognizer:tap];

}
- (void)freshAction
{
    self.freshBlock();
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
- (void)creatAlertView:(NSString *)title message:(NSString *)message sureStr:(NSString *)sureStr cancelStr:(NSString *)cancelStr sureAction:(ALERTLOCK)block cancelAction:(ALERTLOCK)cancelBlock
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:sureStr style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        block(action);
    }];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:cancelStr style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        cancelBlock(action);
        
    }];
    [alertController addAction:otherAction];
    // Add the actions.
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)creatAlertWithTimer:(NSString *)message fatherView:(UIView *)fView
{
    UILabel * tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH / 2 - 60 * WSHIPEI, HEIGHT / 2 - 25, 120 * WSHIPEI, 50)];
    tipLabel.text = message;
    tipLabel.font = FONT(14);
    tipLabel.numberOfLines = 0;
    tipLabel.backgroundColor = [UIColor blackColor];
    tipLabel.layer.cornerRadius = 5;
    tipLabel.layer.masksToBounds = YES;
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.textColor = [UIColor whiteColor];
    [fView addSubview:tipLabel];
    // 设置时间和动画效果
    [UIView animateWithDuration:2 animations:^{
        tipLabel.alpha = 0.0;
    } completion:^(BOOL finished) {
        // 动画完毕从父视图移除
        [tipLabel removeFromSuperview];
    }];

}
- (void)creatAlertViewOne:(NSString *)title message:(NSString *)message sureStr:(NSString *)sureStr sureAction:(ALERTLOCK)block
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:sureStr style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        block(action);
    }];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
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
- (NSInteger)convertToInt:(NSString*)strtemp
{
    NSInteger strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
        
    }
    return strlength / 2;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
