//
//  BaseTabBarViewController.m
//  HBS_C
//
//  Created by wangzuowen on 16/9/10.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "BaseTabBarViewController.h"

#define TabbarVC    @"vc"
#define TabbarTitle @"title"
#define TabbarImage @"image"
#define TabbarSelectedImage @"selectedImage"
#define TabbarItemBadgeValue @"badgeValue"

@interface BaseTabBarViewController ()

@property (nonatomic, strong)MainViewController *mainVC;
@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic, assign)NSInteger unreadCount;

@end

@implementation BaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self.tabBar setTintColor:[ProjectCache returnColorWithRGB:@"255,81,101"]];
    self.mainVC = [[MainViewController alloc] init];
    [self setUpSubNav];
}
#pragma mark -  实例化tabbar列表
- (void)setUpSubNav{
    NSMutableArray * array = [[NSMutableArray alloc] init];
    
    [self.tabBars enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary * item = obj;
        NSString * vcName = item[TabbarVC];
        NSString * title  = item[TabbarTitle];
        NSString * imageName = item[TabbarImage];
        NSString * imageSelected = item[TabbarSelectedImage];
        Class clazz = NSClassFromString(vcName);
        UIViewController * vc = [[clazz alloc] initWithNibName:nil bundle:nil];
        vc.hidesBottomBarWhenPushed = NO;
        
        navi = [[BaseNavigationViewController alloc] initWithRootViewController:vc];
        navi.delegate = self;
        
        navi.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[UIImage imageNamed:imageName]selectedImage:[UIImage imageNamed:imageSelected]];
        navi.tabBarItem.tag = idx;
        NSInteger badge = [item[TabbarItemBadgeValue] integerValue];
        if (badge) {
            navi.tabBarItem.badgeValue = [NSString stringWithFormat:@"%zd",badge];
        }
        [array addObject:navi];
    }];
    
    self.viewControllers = array;
}
-(NSArray *)tabBars{
    NSArray *item = @[
                      @{
                          TabbarVC           : @"MainViewController",
                          TabbarTitle        : @"主页",
                          TabbarImage        : @"",
                          TabbarSelectedImage: @"",
                          TabbarItemBadgeValue: @(0)
                          },
                      @{
                          TabbarVC           : @"HunBaViewController",
                          TabbarTitle        : @"婚吧",
                          TabbarImage        : @"",
                          TabbarSelectedImage: @"",
                          TabbarItemBadgeValue: @(0)
                          },
                      @{
                          TabbarVC           : @"MeViewController",
                          TabbarTitle        : @"我的",
                          TabbarImage        : @"",
                          TabbarSelectedImage: @"",
                          TabbarItemBadgeValue: @(0)
                          },
                      ];
    
    return item;
    
}

+ (instancetype)instance{
    AppDelegate *delegete = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UITabBarController *vc = (UITabBarController *)delegete.window.rootViewController;
    
    if ([vc isKindOfClass:[MainViewController class]]) {
        return (BaseTabBarViewController *)vc;
    }else{
        return nil;
    }
}
-(void)viewWillLayoutSubviews
{
    self.view.frame = [UIScreen mainScreen].bounds;
}
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES];
}
#pragma mark -  重设statusbar为 系统默认(黑色)
- (void)setUpStatusBar{
    UIStatusBarStyle style = UIStatusBarStyleDefault;
    [[UIApplication sharedApplication] setStatusBarStyle:style animated:NO];
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
