//
//  HBSGiftController.m
//  HBS_C
//
//  Created by 王 世江 on 16/11/2.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSGiftController.h"
#import "HBSNewFriendController.h"

@interface HBSGiftController ()
@property (nonatomic, strong) UIButton *leftBtn;
@property (strong, nonatomic) IBOutlet UIImageView *friendImage;//新友image

@end

@implementation HBSGiftController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BAISE;
    [self setUpChildControls];
    
}
#pragma mark----设置子控件
- (void)setUpChildControls{
    
    //返回箭头
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.leftBtn.frame = CGRectMake(0, 20, 30, 35);
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_fanhuijiantou"] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(clickImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.leftBtn];
    
    //邀请好友
    UITapGestureRecognizer *giftImage = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickFriendImage)];
    [self.friendImage addGestureRecognizer:giftImage];
}
#pragma mark----邀请好友跳转方法
- (void)clickFriendImage{
    
    HBSNewFriendController *friend = [[HBSNewFriendController alloc]init];
    [self.navigationController pushViewController:friend animated:YES];
    
}

#pragma mark----箭头image返回方法
- (void)clickImage{
    
    [self.navigationController popViewControllerAnimated:YES];
    [self.tabBarController.tabBar setHidden:NO];
}

@end
