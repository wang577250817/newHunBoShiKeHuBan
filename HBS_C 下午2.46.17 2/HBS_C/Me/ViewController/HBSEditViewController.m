//
//  HBSEditViewController.m
//  HBS_C
//
//  Created by 王 世江 on 16/10/26.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSEditViewController.h"

@interface HBSEditViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *leftImage;//返回image

@end

@implementation HBSEditViewController
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BAISE;
    [self setUpChildControls];
}
#pragma mark----设置子控件
- (void)setUpChildControls{
    
    //返回image
    UITapGestureRecognizer *leftImage = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImage)];
    [self.leftImage addGestureRecognizer:leftImage];
    
}
#pragma mark----返回箭头
- (void)clickImage{
    
    [self.navigationController popViewControllerAnimated:YES];
    [self.tabBarController.tabBar setHidden:NO];
}
@end
