//
//  HBSSystemSetController.m
//  HBS_C
//
//  Created by 王 世江 on 16/10/21.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSSystemSetController.h"
#import "HBSCachesHandle.h"
#import "HBSAboutController.h"
#import "HBSsecurityController.h"

@interface HBSSystemSetController ()
@property (weak, nonatomic) IBOutlet UIImageView *leftImage;
@property (weak, nonatomic) IBOutlet UIButton *accountButton;
@property (weak, nonatomic) IBOutlet UIButton *aboutButton;//关于我们


@end
@implementation HBSSystemSetController
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setHidden:YES];
    [self.tabBarController.tabBar setHidden:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BAISE;
    [self setupChildcontrols];
}
#pragma mark----设置所有的子控件
- (void)setupChildcontrols{
    //顶部返回箭头加手势
    UITapGestureRecognizer *tapImage = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImage)];
    [self.leftImage addGestureRecognizer:tapImage];
    
}
- (IBAction)btn:(UIButton *)sender {
    
    HBSsecurityController *securityCor = [[HBSsecurityController alloc]init];
    [self.navigationController pushViewController:securityCor animated:YES];
    
}
#pragma mark---关于我们的方法
- (IBAction)about:(UIButton *)sender {
    
    HBSAboutController *about = [[HBSAboutController alloc]init];
    [self.navigationController pushViewController:about animated:YES];
    
}
#pragma mark----清理缓存的方法
- (IBAction)CachesButton:(UIButton *)sender {
    
    HBSCachesHandle*caches = [HBSCachesHandle shareCachesHandle];
    
    NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *size = [NSString stringWithFormat:@"%.2fMB",[caches folderSizeAtPath:cachPath]];
    if ([size isEqualToString:@"0.00MB"]) {
        [self alertWithTitle:@"清理缓存" message:[NSString stringWithFormat:@"缓存为0MB"] sure:nil cancel:nil];
    }
    else{
        
        [self alertWithTitle:@"清理缓存" message:[NSString stringWithFormat:@"确定要清理缓存,缓存大小:%@",size] sure:^{
            [caches myClearCacheAction];
            
        } cancel:^{
            
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
            
        }];

    }
    
}
#pragma 箭头返回方法
- (void)clickImage{
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController.navigationBar setHidden:YES];
    self.tabBarController.tabBar.hidden = NO;
}
@end
