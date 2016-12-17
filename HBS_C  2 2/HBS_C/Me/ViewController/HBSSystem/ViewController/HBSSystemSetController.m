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
#import "HBSLoginController.h"

@interface HBSSystemSetController ()
@property (weak, nonatomic) IBOutlet UIButton *accountButton;
@property (weak, nonatomic) IBOutlet UIButton *aboutButton;//关于我们
@property (strong, nonatomic) IBOutlet UIButton *returnBtn;//退出登录按钮

@property (nonatomic, strong) UIButton *leftBtn;
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
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.leftBtn.frame = CGRectMake(0, 20, 30, 35);
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_fanhuijiantou"] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(clickImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.leftBtn];
    
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
#pragma mark----退出登录的方法
- (IBAction)clickBtn:(id)sender {
    
    [self alertWithTitle:@"亲* 您真的要退出吗?" message:nil sure:^{
        
        HBSLoginController *loginVC = [[HBSLoginController alloc]init];
        
        [self.navigationController pushViewController:loginVC animated:YES];
        
    } cancel:^{
        
    }];
}
#pragma 箭头返回方法
- (void)clickImage{
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController.navigationBar setHidden:YES];
    self.tabBarController.tabBar.hidden = NO;
}
@end
