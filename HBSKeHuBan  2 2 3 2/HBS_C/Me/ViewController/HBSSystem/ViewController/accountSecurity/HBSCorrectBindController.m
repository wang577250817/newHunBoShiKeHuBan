//
//  HBSCorrectBindController.m
//  HBS_C
//
//  Created by 王 世江 on 16/10/27.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSCorrectBindController.h"
#import "HBSSystemSetController.h"
@interface HBSCorrectBindController ()<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *phoneFeild;//手机号textField
@property (strong, nonatomic) IBOutlet UITextField *messageField;//输入验证码textField
@property (strong, nonatomic) IBOutlet UILabel *sendLabel;//发送验证码label
@property (strong, nonatomic) IBOutlet UITextField *loginField;//登录密码textField
@property (strong, nonatomic) IBOutlet UIButton *sureButton;//确定Button
@property (nonatomic, strong) UILabel *sureLabel;//后台返回的验证码
@property (nonatomic, strong) NSTimer *timer; // 定时器
@property (nonatomic, assign) NSInteger time;
@property (nonatomic, strong) UIButton *leftBtn;

@end
@implementation HBSCorrectBindController
#pragma mark----添加通知中心
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(goSave:) name:UITextFieldTextDidChangeNotification object:nil];
    self.time = 60;
    [self stopTimer];
    
}
#pragma mark-----移除通知中心
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BAISE;
    [self setUpChildControls];
    self.time = 60;
    
}
#pragma mark----设置子控件
- (void)setUpChildControls{
    
    //返回箭头
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.leftBtn.frame = CGRectMake(0, 20, 30, 35);
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_fanhuijiantou"] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(clickImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.leftBtn];
    self.phoneFeild.delegate = self;
    self.phoneFeild.tintColor = [UIColor grayColor];
    [self.phoneFeild becomeFirstResponder ];
    self.phoneFeild.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    //发送验证码
    UITapGestureRecognizer *sendTap = [[UITapGestureRecognizer alloc] init];
    [sendTap addTarget:self action:@selector(sendTapAction)];
    [self.sendLabel addGestureRecognizer:sendTap];
    //接受验证码Label初始化(不能删啊)
    self.sureLabel = [[UILabel alloc]init];
    
}
#pragma mark----确定登录方法
- (IBAction)sureBtn:(UIButton *)sender {
    
//    NSString *passworrdStr = user_password_find;
    NSString *passworrdStr = [ProjectCache getLoginMessage][@"user_password"];;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"id"] = [ProjectCache getLoginMessage][@"user_id"];
    params[@"user_newmobile"] = self.phoneFeild.text;
    params[@"user_token"] = userToken;
    params[@"user_password"] = self.loginField.text;
    params[@"user_code"] = self.sureLabel.text;
    
    if ([self checkWIFI]) {
        [self showLoadingViewWithMessage];
        if ([[self panduan][0]boolValue]) {
            [HBSNetWork putUrl:[NSString stringWithFormat:@"%@user/%@/mobile", HBSNetAdress, params[@"id"]] parame:params header:nil cookie:nil result:^(id result) {
                if ([result[@"code"]integerValue] == 200) {
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }else if ([result[@"code"]integerValue] == 201){
                      [self alertWithTitle:@"手机号码不正确" message:nil sure:nil cancel:nil];
                    
                }else if ([result[@"code"]integerValue] == 202){
                    [self alertWithTitle:@"密码错误，请重新输入" message:nil sure:nil cancel:nil];
                    
                }else if ([result[@"code"]integerValue] == 203){
                    [self alertWithTitle:@"验证码获取失败,请重新获取！" message:nil sure:nil cancel:nil];
                    
                }else if ([result[@"code"]integerValue] == 204){
                    [self alertWithTitle:@"验证码错误,请重新输入" message:nil sure:nil cancel:nil];
                    
                }else if ([result[@"code"]integerValue] == 205){
                    [self alertWithTitle:@"验证码已过期,请重新获取" message:nil sure:nil cancel:nil];
                    
                }else if ([result[@"code"]integerValue] == 206){
                    [self alertWithTitle:@"该手机号已绑定账号" message:nil sure:nil cancel:nil];
                    
                }else if ([result[@"code"]integerValue] == 400){
                    
                    if ([self phoneProve]) {
                        [self alertWithTitle:@"请输入正确的手机号" message:nil sure:nil cancel:nil];
                        
                    }else if (self.phoneFeild.text != result[@"result"][@"mobile"]){
                    }else if (params[@"user_code"] != self.sureLabel.text) {
                        
                        [self alertWithTitle:@"验证码错误, 请重新输入" message:nil sure:nil cancel:nil];
                    }else if (passworrdStr != self.loginField.text){
                        
                        [self alertWithTitle:@"密码错误，请重新输入" message:nil sure:nil cancel:nil];
                    }
                }
            }];
            
        }else{
            [self alertWithTitle:[self panduan][1] message:nil sure:nil cancel:nil];
        }
        
        [self removeLodingView];

    }
}
#pragma mark----发送验证码手势
- (void)sendTapAction{
    
     if (self.phoneFeild.text.length == 0){
        
        [self alertWithTitle:@"手机号不能为空" message:nil sure:nil cancel:nil];
    }else if (self.phoneFeild.text.length != 11){
    
        [self alertWithTitle:@"请输入正确的手机号" message:nil sure:nil cancel:nil];
    }else{
        
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = userToken;
    params[@"mobile"] = self.phoneFeild.text;
    params[@"iClass"] = @"2";
    
    if ([self checkWIFI]) {
        [self showLoadingViewWithMessage];
       
        [HBSNetWork postUrl:[NSString stringWithFormat:@"%@service/sms", HBSNetAdress] parame:params header:nil cookie:nil result:^(id result) {
            
            if ([result[@"code"]integerValue] == 200) {
                
                self.sureLabel.text = result[@"result"][@"smscode"];
                HBSLog(@"12346%@", result[@"result"]);
                [self alertWithTitle:@"验证码已经发送到您的手机" message:nil sure:nil cancel:nil];
                 [self starTimer];
                
            }else if ([result[@"code"]integerValue] == 201){
                [self alertWithTitle:@"该账户不存在,请先注册" message:nil sure:nil cancel:nil];
            }else if ([result[@"code"]integerValue] == 201){
                [self alertWithTitle:@"发送失败" message:nil sure:nil cancel:nil];
            }
            else if ([result[@"code"]integerValue] == 400){
                
                [self alertWithTitle:@"请求失败" message:nil sure:^{
                    
                } cancel:^{
                    
                }];
            }
        }];
        [self removeLodingView];
    }else{
        
        // 手机号错误
        [self alertWithTitle:@"请输入正确的手机号" message:nil sure:nil cancel:nil];
    }
    }
}
#pragma mark---开始计时
- (void)starTimer{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [self.timer fire];
    
}
- (void)timerAction{
    
    if (self.time < 0) {
        self.sendLabel.text = @"获取验证码";
        self.time = 60;
        [self stopTimer];
        self.sendLabel.userInteractionEnabled = YES;
        
    }else{
        
        self.sendLabel.text = [NSString stringWithFormat:@"%lds", (long)self.time--];
        self.sendLabel.userInteractionEnabled = NO;
    }
}
#pragma mark----结束定时
- (void)stopTimer{
    
    [self.timer invalidate];
}
#pragma mark----通知中心的实现方法
- (void)goSave:(NSNotification *)Notification{
    
    if (self.phoneFeild.text.length == 11 && self.messageField.text.length == 6 && self.loginField.text.length <= 16 && self.loginField.text.length >= 6) {
        self.sureButton.selected = YES;
        self.sureButton.userInteractionEnabled = YES;
    }else{
        
        self.sureButton.selected = NO;
    }
    
}
#pragma mark----判断方法
- (NSArray *)panduan{
    
    NSArray *arr = [NSArray array];
    if ([self.messageField.text rangeOfString:@""].location != NSNotFound) {
        arr = @[@0, @"请输入验证码"];
    }else if (self.phoneFeild.text.length == 0){
        arr = @[@0, @"请输入手机号"];
    }else if (self.messageField.text.length == 0){
        arr = @[@0, @"请输入验证码"];
    }else if (self.phoneFeild.text.length == 0){
        arr = @[@0, @"手机号不能为空"];
    }else if (self.phoneFeild.text.length != 11){
        arr = @[@0, @"请输入正确的手机号"];
    }else if (self.messageField.text.length != 6){
        arr = @[@0, @"验证码错误"];
        
    }
//    else if (self.messageField.text != self.sureLabel.text){
//        arr = @[@0, @"验证码错误"];
//    }
    else if (self.loginField.text.length < 6 || self.loginField.text.length > 16){
        arr = @[@0, @"密码是6—16位哦"];
    }
    else{
        arr = @[@1, @""];
    }
    return arr;
}
#pragma mark----箭头image返回方法
- (void)clickImage{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - TextField协议方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}
#pragma mark----手机号验证
- (BOOL)phoneProve{
    
    NSString * MOBILE = @"^1(3[4-9]|47|5[0-27-9]|78|8[2-4|7|8])\\d{8}$";
    /**
     10      * 中国移动：China Mobile
     11      * 134 135 136 137 138 139 147 150 151 152 157 158 159 178 182 183 184 187 188
     12      */
    NSString * CM = @"^1(3[0-2]|45|55|56|71|76|8[5-6])\\d{8}$";
    /**
     15      * 中国联通：China Unicom
     16      * 130 131 132 145 155 156 171 175 176 185 186
     17      */
    NSString * CU = @"^1(33|49|53|73|77|80|81|89)\\d{8}$";
    /**
     20      * 中国电信：China Telecom
     21      * 133 149 153 173 177 180 181 189
     22      */
    NSString * CT = @"^1(70)\\d{8}$";
    /**
     25         * 虚拟运营商
     */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:self.phoneFeild.text] == YES)
        || ([regextestcm evaluateWithObject:self.phoneFeild.text] == YES)
        || ([regextestct evaluateWithObject:self.phoneFeild.text] == YES)
        || ([regextestcu evaluateWithObject:self.phoneFeild.text] == YES))
    {
        if([regextestcm evaluateWithObject:self.phoneFeild.text] == YES) {
            NSLog(@"China Mobile");
        } else if([regextestct evaluateWithObject:self.phoneFeild.text] == YES) {
            NSLog(@"China Telecom");
        } else if ([regextestcu evaluateWithObject:self.phoneFeild.text] == YES) {
            NSLog(@"China Unicom");
        } else {
            NSLog(@"Unknow");
        }
        //
        return YES;
    }
    else
    {
        return NO;
    }
    
}
@end
