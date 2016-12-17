//
//  HBSsecurityController.m
//  HBS_C
//
//  Created by 王 世江 on 16/10/27.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSsecurityController.h"
#import "HBSCorrectPWDController.h"
#import "HBSCorrectBindController.h"

@interface HBSsecurityController ()

@property (strong, nonatomic) IBOutlet UIButton *modifyPhoneButton;//修改手机号button
@property (strong, nonatomic) IBOutlet UIButton *modifyPwdBtn;//修改密码button
@property (nonatomic, strong) UIButton *leftBtn;

@end

@implementation HBSsecurityController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BAISE;
    [self setUpChildControls];
    
}
#pragma mark----设置子控件
- (void)setUpChildControls{
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.leftBtn.frame = CGRectMake(0, 20, 30, 35);
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_fanhuijiantou"] forState:UIControlStateNormal];
//    [self.leftBtn setBackgroundColor:[UIColor blueColor]];
    [self.leftBtn addTarget:self action:@selector(clickImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.leftBtn];

    
}
#pragma mark----修改手机号方法
- (IBAction)clickModify:(UIButton *)sender {
    
    HBSCorrectBindController *correctBind = [[HBSCorrectBindController alloc]init];
    [self.navigationController pushViewController:correctBind animated:YES];
    
}
#pragma mark----修改密码方法
- (IBAction)clickModifyPhone:(UIButton *)sender {
    
    HBSCorrectPWDController *correctPWD = [[HBSCorrectPWDController alloc]init];
    [self.navigationController pushViewController:correctPWD animated:YES];
    
}
#pragma mark----箭头image返回方法
- (void)clickImage{
   
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
