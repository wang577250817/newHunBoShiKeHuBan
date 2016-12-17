//
//  HBSCorrectPWDController.m
//  HBS_C
//
//  Created by 王 世江 on 16/10/21.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSCorrectPWDController.h"
#import "HBSsecurityController.h"

@interface HBSCorrectPWDController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *oldPwdField;//旧的textField
@property (weak, nonatomic) IBOutlet UITextField *passwordField;//新的textField
@property (weak, nonatomic) IBOutlet UITextField *againPwdField;//再次输入textField
@property (weak, nonatomic) IBOutlet UIButton *sureButton;//确定按钮

@property (nonatomic, strong) UITextField *oldPwdFd;
@property (nonatomic, strong) UIButton *leftBtn;

@end
@implementation HBSCorrectPWDController
#pragma mark-----添加通知
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(goSave:) name:UITextFieldTextDidChangeNotification object:nil];
}
#pragma mark----移除通知
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    [self alertWithTitle:@"修改成功" message:nil sure:nil cancel:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BAISE;
    [self setupChildcontrols];
    
}
#pragma mark----设置所有的子控件
- (void)setupChildcontrols{
    
    //顶部返回箭头加手势
    //返回箭头
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.leftBtn.frame = CGRectMake(0, 20, 30, 35);
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_fanhuijiantou"] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(clickImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.leftBtn];
    
    //页面出现键盘出现
    self.oldPwdField.delegate = self;
    [self.oldPwdField becomeFirstResponder];
    self.oldPwdField.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    
    
}

- (IBAction)btn:(UIButton *)sender {
    
//    NSString *pwdStr = user_password_find;
    NSString *userMobileStr = user_mobile_find
    
    
    if (self.oldPwdField.text.length == 0 && self.passwordField.text.length == 0 && self.againPwdField.text.length == 0) {
        [self alertWithTitle:@"密码不能为空" message:nil sure:nil cancel:nil];
        
    }else if (self.passwordField.text.length < 6 && self.againPwdField.text.length > 16){
        
        [self alertWithTitle:@"请输入6-16位数字、字母或符号" message:nil sure:nil cancel:nil];
    
    }else if (self.passwordField.text.length > 16 && self.againPwdField.text.length > 16){
        
        [self alertWithTitle:@"请输入6-16位数字、字母或符号" message:nil sure:nil cancel:nil];
    
    }else if ([self.passwordField.text isEqualToString:@"" ]){
        
        [self alertWithTitle:@"密码不能为空" message:nil sure:nil cancel:nil];
        
    }else if ([self.againPwdField.text isEqualToString:@"" ]){
        
        [self alertWithTitle:@"密码不能为空" message:nil sure:nil cancel:nil];
        
    
    }else if (self.passwordField.text != self.againPwdField.text) {
        
        [self alertWithTitle:@"两次密码不一致，请重新输入" message:nil sure:nil cancel:nil];
        
    }else if (self.passwordField.text.length < 6 && self.againPwdField.text.length > 16){
        
        [self alertWithTitle:@"请输入6-16位数字、字母或符号" message:nil sure:nil cancel:nil];
        
    }else if (self.passwordField.text.length > 16 && self.againPwdField.text.length > 16){
        
        [self alertWithTitle:@"请输入6-16位数字、字母或符号" message:nil sure:nil cancel:nil];
    }
    

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"user_mobile"] = userMobileStr;
    params[@"user_old_password"] = self.oldPwdField.text;
    params[@"user_new_password_1"] = self.passwordField.text;
    params[@"user_new_password_2"] = self.againPwdField.text;
    
    if ([self checkWIFI]) {
        [self showLoadingViewWithMessage];
        
        [HBSNetWork putUrl:[NSString stringWithFormat:@"%@user/password", HBSNetAdress] parame:params header:nil cookie:nil result:^(id result) {
            
            if ([result[@"code"]integerValue] == 200) {
                
                HBSsecurityController *security = [[HBSsecurityController alloc]init];
                [self.navigationController pushViewController:security animated:YES];
                
                
            }
            else if ([result[@"code"]integerValue] == 203){
                
                [self alertWithTitle:@"原密码不正确" message:nil sure:nil cancel:nil];
            
            }
            else if ([result[@"code"]integerValue] == 400){
                
                [self alertWithTitle:@"密码修改失败 请重新修改" message:nil sure:nil cancel:nil];
            }

        }];
        [self removeLodingView];
    }
    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.securityPolicy.validatesDomainName = YES;
//    [manager PUT:@"http://192.168.0.82:10081/user/password" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        if ([responseObject[@"code"]integerValue] == 200) {
//            
//            [self.navigationController popViewControllerAnimated:YES];
//        }else if ([responseObject[@"code"]integerValue] == 400){
//            
//            [self alertWithTitle:@"密码修改失败 请重新修改" message:nil sure:nil cancel:nil];
//        }
//        
//        HBSLog(@"%@", responseObject);
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//        HBSLog(@"密码修改失败%@", error);
//        
//    }];
    
}
#pragma mark----实现通知的方法
- (void)goSave:(NSNotification *)Notification{
    
    if (self.oldPwdField.text.length <= 16 && self.oldPwdField.text.length >= 6 && self.passwordField.text.length <= 16 && self.passwordField.text.length >= 6 && self.againPwdField.text.length <= 16 && self.againPwdField.text.length >= 6) {
        self.sureButton.selected = YES;
        self.sureButton.userInteractionEnabled = YES;
    }else{
        
        self.sureButton.selected = NO;
    }
    
}
//回收键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}
#pragma mark----返回按钮
- (void)clickImage{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - TextField协议方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
    
}
@end
