//
//  HBSFindPasswordController.m
//  HBS_C
//
//  Created by 王 世江 on 16/10/17.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSFindPasswordController.h"
#import "HBSRegisterController.h"

@interface HBSFindPasswordController ()<UITextFieldDelegate>
@property (nonatomic, strong) UILabel *findLabel;//找回密码label
@property (nonatomic, strong) UIButton *leftBtn;//返回image
@property (nonatomic, strong) UILabel *grayLabel;//灰线label
@property (nonatomic, strong) UITextField *phoneField;//手机号field
@property (nonatomic, strong) UILabel *phoneGrayLabel;//手机号下面的label
@property (nonatomic, strong) UITextField *messageField;//短信验证码field
@property (nonatomic, strong) UILabel *messageGrayLabel;//短信验证码下面的label
@property (nonatomic, strong) UITextField *passwordFied;//密码field
@property (nonatomic, strong) UILabel *passwordGrayLabel;//密码下面的label
@property (nonatomic, strong) UIButton *imageButton;//图片button
@property (nonatomic, strong) UILabel *shuLabel;//竖着的label
@property (nonatomic, strong) UILabel *send; //发送验证码
@property (nonatomic, strong) NSTimer *timer; // 定时器
@property (nonatomic, assign) NSInteger time;
@property (nonatomic, strong) UILabel *sureLabel;//后台返回的验证码
@end

@implementation HBSFindPasswordController
#pragma mark-----添加通知中心
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(goSave:) name:UITextFieldTextDidChangeNotification object:nil];
    
}
#pragma mark-----移除通知中心
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    self.time = 60;
    [self stopTimer];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BAISE;
    self.time = 60;
    [self setupFindPassword];
}

- (void)setupFindPassword{
    
   
    //导航栏左侧的返回箭头
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.leftBtn.frame = CGRectMake(0, 20, 30, 35);
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_fanhuijiantou"] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(clickImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.leftBtn];
    
    //登录的label
    self.findLabel = [[UILabel alloc]init];
    self.findLabel.text = @"找回密码";
//    self.findLabel.backgroundColor = HBSRandomColor;
    self.findLabel.font = FONT(18);
    self.findLabel.textColor = HBSColor(68, 68, 68);
    [self.view addSubview:self.findLabel];
    [self.findLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.view).offset(34);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(75, 20));
        
    }];
    
    //灰线label
    self.grayLabel = [[UILabel alloc]init];
    self.grayLabel.backgroundColor = HBSColor(229, 229, 229);
    [self.view addSubview:self.grayLabel];
    [self.grayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.view).offset(64);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 1));
        
    }];
    
    //输入手机号注册field
    self.phoneField = [[UITextField alloc]init];
//    self.phoneField.backgroundColor = HBSRandomColor;
    self.phoneField.delegate = self;
    [self.phoneField becomeFirstResponder ];
    self.phoneField.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName] = HBSColor(204, 204, 204);
    self.phoneField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"输入注册手机号" attributes:attributes];
    self.phoneField.font = FONT(14);
    self.phoneField.tintColor = HBSColor(102, 102, 102);
    self.phoneField.keyboardType = UIKeyboardTypeDecimalPad;
    [self.view addSubview:self.phoneField];
    [self.phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.grayLabel).offset(40);
        make.left.mas_equalTo(self.view).offset(52);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 80, 20));
        
    }];
    
    //手机号下面的灰色label
    self.phoneGrayLabel = [[UILabel alloc]init];
    self.phoneGrayLabel.backgroundColor = HBSColor(229, 229, 229);
    [self.view addSubview:self.phoneGrayLabel];
    [self.phoneGrayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.phoneField).offset(40);
        make.left.mas_equalTo(self.view).offset(40);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 80, 1));
        
    }];

    //输入短信验证码field
    self.messageField = [[UITextField alloc]init];
//    self.messageField.backgroundColor = HBSRandomColor;
    NSMutableDictionary *attributesM = [NSMutableDictionary dictionary];
    attributesM[NSForegroundColorAttributeName] = HBSColor(204, 204, 204);
    self.messageField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"输入短信的验证码" attributes:attributesM];
    self.messageField.font = FONT(14);
    self.messageField.tintColor = HBSColor(102, 102, 102);
    self.messageField.keyboardType = UIKeyboardTypeDecimalPad;
    [self.view addSubview:self.messageField];
    [self.messageField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.phoneGrayLabel).offset(20);
        make.left.mas_equalTo(self.view).offset(52);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 200, 20));
        
    }];
    
    //短信验证下面的灰色label
    self.messageGrayLabel = [[UILabel alloc]init];
    self.messageGrayLabel.backgroundColor = HBSColor(229, 229, 229);
    [self.view addSubview:self.messageGrayLabel];
    [self.messageGrayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.phoneGrayLabel).offset(54);
        make.left.mas_equalTo(self.view).offset(40);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 80, 1));
        
    }];
    
    //竖着的label
    self.shuLabel = [[UILabel alloc]init];
    self.shuLabel.backgroundColor = HBSColor(229, 229, 229);
    [self.view addSubview:self.shuLabel];
    [self.shuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.phoneGrayLabel).offset(0);
        make.left.mas_equalTo(self.messageField).offset(WIDTH - 180);
        make.size.mas_equalTo(CGSizeMake(1, 54));
        
    }];
    
    //短信验证的label
    self.send = [[UILabel alloc]init];
    self.send.text = @"获取验证码";
    self.send.textColor = HBSColor(71, 180, 184);
//    self.send.backgroundColor = HBSRandomColor;
    self.send.userInteractionEnabled = YES;
    self.send.font = FONT(14);
    [self.view addSubview:self.send];
    [self.send mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.phoneGrayLabel).offset(20);
        make.left.mas_equalTo(self.shuLabel).offset(12);
        make.size.mas_equalTo(CGSizeMake(100, 20));
        
    }];
    
    UITapGestureRecognizer *sendTap = [[UITapGestureRecognizer alloc] init];
    [sendTap addTarget:self action:@selector(sendTapAction)];
    [self.send addGestureRecognizer:sendTap];
    
    //接受验证码Label初始化(不能删啊)
    self.sureLabel = [[UILabel alloc]init];

    //密码field
    self.passwordFied = [[UITextField alloc]init];
//    self.passwordFied.backgroundColor = HBSRandomColor;
    NSMutableDictionary *attribute = [NSMutableDictionary dictionary];
    attribute[NSForegroundColorAttributeName] = HBSColor(204, 204, 204);
    self.passwordFied.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"输入密码(6~16数字、字母或符号)" attributes:attribute];
    self.passwordFied.secureTextEntry = YES;
    self.passwordFied.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordFied.font = FONT(14);
    self.passwordFied.tintColor = HBSColor(102, 102, 102);
    [self.view addSubview:self.passwordFied];
    [self.passwordFied mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.messageGrayLabel).offset(20);
        make.left.mas_equalTo(self.view).offset(52);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 100, 20));
        
    }];
    
    //密码下面的灰色label
    self.passwordGrayLabel = [[UILabel alloc]init];
    self.passwordGrayLabel.backgroundColor = HBSColor(229, 229, 229);
    [self.view addSubview:self.passwordGrayLabel];
    [self.passwordGrayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.messageGrayLabel).offset(54);
        make.left.mas_equalTo(self.view).offset(40);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 80, 1));
        
    }];

    //imageButton
    
    self.imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.imageButton setBackgroundImage:[UIImage imageNamed:@"button_1_morenqueding"] forState:UIControlStateNormal];
    [self.imageButton setBackgroundImage:[UIImage imageNamed:@"button_1_xuanzhongqueding"] forState:UIControlStateSelected];
    [self.imageButton addTarget:self action:@selector(clickSureImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.imageButton];
    [self.imageButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.passwordGrayLabel).offset(30);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 42, 36));
        
    }];
    
}
#pragma mark-----确定找回密码的方法
- (void)clickSureImage{
    
    if ([[self panduan][0]boolValue]) {
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"user_mobile"] = self.phoneField.text;
        params[@"user_code"] = self.messageField.text;
        params[@"user_password"] = self.passwordFied.text;
        
        
        [HBSNetWork putUrl:[NSString stringWithFormat:@"%@user/findpassword", HBSNetAdress] parame:params header:nil cookie:nil result:^(id result) {
            
            if ([result[@"code"]integerValue] == 200) {
                
                HBSLog(@"%@", result[@"result"]);
                
            }else if ([result[@"code"]integerValue] == 400){
                
                [self alertWithTitle:@"找回密码失败" message:nil sure:nil cancel:nil];
                
            }
        }];
        
    }else{
        
        [self alertWithTitle:[self panduan][1] message:nil sure:nil cancel:nil];
    }
    
}

#pragma mark----判断方法
- (NSArray *)panduan{
    
    NSArray *arr = [NSArray array];
    if ([self.messageField.text rangeOfString:@""].location != NSNotFound) {
        arr = @[@0, @"请输入验证码"];
    }else if (self.phoneField.text.length == 0){
        arr = @[@0, @"手机号不能为空"];
    }else if (self.phoneField.text.length != 11){
        arr = @[@0, @"请输入正确的手机号"];
    }else if (self.messageField.text != self.sureLabel.text){
        arr = @[@0, @"验证码输入错误 请重新输入"];
    }else if (self.messageField.text.length != 6){
        arr = @[@0, @"请输入正确的验证码"];
    
    }else if (self.passwordFied.text.length < 6 || self.passwordFied.text.length > 11){
            arr = @[@0, @"密码是6—16位哦"];
        }
    
    else{
        
        arr = @[@1, @""];
    }
    
    return arr;

}

#pragma mark----发送验证码手势
- (void)sendTapAction{
    if ([self phoneProve]) {
        
        [self starTimer];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"token"] = userToken;
        params[@"mobile"] = self.phoneField.text;
        params[@"iClass"] = @"0";
        
        [HBSNetWork postUrl:[NSString stringWithFormat:@"%@service/sms", HBSNetAdress] parame:params header:nil cookie:nil result:^(id result) {
            
            if ([result[@"code"]integerValue] == 200) {
                
                self.sureLabel.text = result[@"result"][@"smscode"];
                
            }else if ([result[@"code"]integerValue] == 202){
                
                [self alertWithTitle:@"发送失败" message:nil sure:nil cancel:nil];
                
            }
            else if ([result[@"code"]integerValue] == 400){
                
                [self alertWithTitle:@"请求失败" message:nil sure:nil cancel:nil];
                
            }else if ([result[@"code"]integerValue] == 201){
                
                [self alertWithTitle:@"该账户不存在,请先注册" message:nil sure:^{
                    
                    HBSRegisterController *registerd = [[HBSRegisterController alloc]init];
                    [self.navigationController pushViewController:registerd animated:YES];
                    
                } cancel:^{
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }];
            }
            
        }];
        
    }else{
        
        // 手机号错误
        [self alertWithTitle:@"请输入正确的手机号" message:nil sure:nil cancel:nil];
    }
    
}
#pragma mark---开始计时
- (void)starTimer{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [self.timer fire];
    
}
- (void)timerAction{
    
    if (self.time < 0) {
        self.send.text = @"获取验证码";
        self.time = 60;
        [self stopTimer];
        self.send.userInteractionEnabled = YES;
        
    }else{
        
        self.send.text = [NSString stringWithFormat:@"%lds", (long)self.time--];
        self.send.userInteractionEnabled = NO;
    }
    
    
}
#pragma mark----结束定时
- (void)stopTimer{
    
    [self.timer invalidate];
}

#pragma 箭头返回方法
- (void)clickImage{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];

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
    
    if (([regextestmobile evaluateWithObject:self.phoneField.text] == YES)
        || ([regextestcm evaluateWithObject:self.phoneField.text] == YES)
        || ([regextestct evaluateWithObject:self.phoneField.text] == YES)
        || ([regextestcu evaluateWithObject:self.phoneField.text] == YES))
    {
        if([regextestcm evaluateWithObject:self.phoneField.text] == YES) {
            NSLog(@"China Mobile");
        } else if([regextestct evaluateWithObject:self.phoneField.text] == YES) {
            NSLog(@"China Telecom");
        } else if ([regextestcu evaluateWithObject:self.phoneField.text] == YES) {
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

#pragma mark----通知中心的实现方法
- (void)goSave:(NSNotification *)Notification{
    
    if (self.phoneField.text.length == 11 && self.messageField.text.length == 6 && self.passwordFied.text.length <= 16 && self.passwordFied.text.length >= 6) {
        self.imageButton.selected = YES;
        self.imageButton.userInteractionEnabled = YES;
    }else{
        
        self.imageButton.selected = NO;
    }
    
}
#pragma mark - TextField协议方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

@end
