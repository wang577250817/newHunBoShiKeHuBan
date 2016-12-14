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
@property (strong, nonatomic) IBOutlet UIImageView *leftImage;//返回image

@property (strong, nonatomic) IBOutlet UIButton *modifyPhoneButton;//修改手机号button
@property (strong, nonatomic) IBOutlet UIButton *modifyPwdBtn;//修改密码button

@end

@implementation HBSsecurityController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BAISE;
    [self setUpChildControls];
    
}
#pragma mark----设置子控件
- (void)setUpChildControls{
    
    //返回箭头
    UITapGestureRecognizer *tapImage = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImage)];
    [self.leftImage addGestureRecognizer:tapImage];
    
    
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
