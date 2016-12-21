//
//  HBSRegisterController.m
//  HBS_C
//
//  Created by 王 世江 on 16/10/17.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSRegisterController.h"
#import "HBSXieYiController.h"
#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "WXApi.h"

@interface HBSRegisterController ()

@property (nonatomic, strong) UILabel *findLabel;//找回密码label
@property (nonatomic, strong) UIButton *leftBtn;//返回image
@property (nonatomic, strong) UIButton *loginButton;//注册button
@property (nonatomic, strong) UILabel *grayLabel;//灰线label
@property (nonatomic, strong) UITextField *phoneField;//手机号field
@property (nonatomic, strong) UILabel *phoneGrayLabel;//手机号下面的label
@property (nonatomic, strong) UITextField *messageField;//短信验证码field
@property (nonatomic, strong) UILabel *messageGrayLabel;//短信验证码下面的label
@property (nonatomic, strong) UITextField *passwordFied;//密码field
@property (nonatomic, strong) UILabel *passwordGrayLabel;//密码下面的label
//@property (nonatomic, strong) UIImageView *sureImage;//确定image
@property (nonatomic, strong) UIButton *imageButton;//图片button
@property (nonatomic, strong) UILabel *shuLabel;//竖着的label
@property (nonatomic, strong) UILabel *send; //发送验证码
@property (nonatomic, strong) NSTimer *timer; // 定时器
@property (nonatomic, assign) NSInteger time;
@property (nonatomic, strong) UILabel *treeLabel;//同意label
@property (nonatomic, strong) UIButton *xieYiButton;//协议button
@property (nonatomic, strong) UIImageView *threeImage;
@property (nonatomic, strong) UILabel *sureLabel;//判断验证码label
@property (nonatomic, strong) UIImageView *weChatImage;//微信image
@property (nonatomic, strong) UIImageView *QQImage;//QQimage
@end

@implementation HBSRegisterController

#pragma mark-----添加通知
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(goSave:) name:UITextFieldTextDidChangeNotification object:nil];
}

#pragma mark----移除通知
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
    [self setupAtonceRegisterd];
}

- (void)setupAtonceRegisterd{
    
  
    //导航栏左侧的返回箭头
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.leftBtn.frame = CGRectMake(0, 20, 30, 35);
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_fanhuijiantou"] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(clickImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.leftBtn];
    
    //立即注册的label
    self.findLabel = [[UILabel alloc]init];
    self.findLabel.text = @"立即注册";
    //    self.findLabel.backgroundColor = HBSRandomColor;
    self.findLabel.font = FONT(18);
    self.findLabel.textColor = HBSColor(68, 68, 68);
    [self.view addSubview:self.findLabel];
    [self.findLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.view).offset(34);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(75, 20));
        
    }];
    
    //登录的button
    self.loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.loginButton setTitleColor:[UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0] forState:UIControlStateNormal];
    self.loginButton.titleLabel.font = FONT(15);
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.view).offset(34);
        make.right.mas_equalTo(self.view).offset(-15);
        make.size.mas_equalTo(CGSizeMake(40, 20));
        
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
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName] = HBSColor(204, 204, 204);
    self.phoneField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"输入手机号注册" attributes:attributes];
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
    
    //判断验证码真伪的label
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
    //    self.passwordFied.keyboardType = UIKeyboardTypeDecimalPad;
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
    
    //立即注册image
    self.imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.imageButton setBackgroundImage:[UIImage imageNamed:@"button_morenzhuce"] forState:UIControlStateNormal];
    [self.imageButton setBackgroundImage:[UIImage imageNamed:@"icon_1_xuanzhongzhuce"] forState:UIControlStateSelected];
    [self.imageButton addTarget:self action:@selector(clickSureImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.imageButton];
    [self.imageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.passwordGrayLabel).offset(30);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 42, 36));
        
    }];

    
    //注册同意label
    self.treeLabel = [[UILabel alloc]init];
    self.treeLabel.text = @"注册即同意";
    self.treeLabel.textColor = HBSColor(68, 68, 68);
    self.treeLabel.font = FONT(12);
//    self.treeLabel.backgroundColor = HBSRandomColor;
    [self.view addSubview:self.treeLabel];
    [self.treeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.imageButton).offset(45);
        make.left.mas_equalTo(self.view).offset(94);
        make.size.mas_equalTo(CGSizeMake(65, 15));
        
        
    }];
    
    //协议button
    self.xieYiButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.xieYiButton setTitle:@"《婚博士用户服务协议》" forState:UIControlStateNormal];
//    self.xieYiButton.backgroundColor = HBSRandomColor;
    [self.xieYiButton setTitleColor:[UIColor colorWithRed:233/255.0 green:81/255.0 blue:84/255.0 alpha:1.0] forState:UIControlStateNormal];
    self.xieYiButton.titleLabel.font = FONT(12);
    [self.xieYiButton addTarget:self action:@selector(xieYiClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.xieYiButton];
    [self.xieYiButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.imageButton).offset(45);
        make.left.mas_equalTo(self.treeLabel).offset(60);
        make.size.mas_equalTo(CGSizeMake(135, 15));
        
    }];
    
    //三方登录图片
    self.threeImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"img_difanfangdengklu"]];
    [self.view addSubview:self.threeImage];
    [self.threeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(self.view).offset(-95);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 40, 20));
        
    }];
    
    //微信登录图片
    self.weChatImage = [[UIImageView alloc]init];
    [self.weChatImage setImage:[UIImage imageNamed:@"icon_shanfangweixin"]];
    self.weChatImage.userInteractionEnabled = YES;
    [self.view addSubview:self.weChatImage];
    [self.weChatImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(self.view).offset(-25);
        make.left.mas_equalTo(self.view).offset(WIDTH / 4+20);
        make.size.mas_equalTo(CGSizeMake(45, 45));
        
    }];
    
    UITapGestureRecognizer *weChatTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(weChatClick)];
    [self.weChatImage addGestureRecognizer:weChatTap];
    
    //QQ登录图片
    self.QQImage = [[UIImageView alloc]init];
    [self.QQImage setImage:[UIImage imageNamed:@"icon_sanfangQQ"]];
    self.QQImage.userInteractionEnabled = YES;
    [self.view addSubview:self.QQImage];
    [self.QQImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(self.view).offset(-25);
        make.left.mas_equalTo(self.view).offset(WIDTH / 2+20);
        make.size.mas_equalTo(CGSizeMake(45, 45));
        
    }];
    
    UITapGestureRecognizer *QQChatTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(QQClick:)];
    [self.QQImage addGestureRecognizer:QQChatTap];

    
}
- (void)clickSureImage{
    
    if ([[self judgeLoginBtn][0] boolValue]) {
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"user_mobile"] = self.phoneField.text;
        params[@"user_password"] = self.passwordFied.text;
        params[@"user_type"] = @"0";
        params[@"user_code"] = self.messageField.text;
        params[@"user_device"] = @"0";
        
        [HBSNetWork postUrl:[NSString stringWithFormat:@"%@user", HBSNetAdress] parame:params header:nil cookie:nil result:^(id result) {
            
            if ([result[@"code"]integerValue] == 200) {
                
                HBSLog(@"注册成功");
                
                [self.navigationController popViewControllerAnimated:YES];
            }else if ([result[@"code"]integerValue] == 400){
                
                [self alertWithTitle:@"注册失败 请重新注册" message:nil sure:nil cancel:nil];
            }
        }];
        
    }else{
        
        [self alertWithTitle:[self judgeLoginBtn][1] message:nil sure:nil cancel:nil];
    }
    
}

- (void)sendTapAction{
    
    if ([self phoneProve]) {
        
        [self alertWithTitle:[NSString stringWithFormat:@"我们将发送验证码到%@", self.phoneField.text] message:nil sure:^{
            [self starTimer];
            
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"token"] = @"城祥傻逼";
            params[@"mobile"] = self.phoneField.text;
            params[@"iClass"] = @"0";
            
            [HBSNetWork postUrl:[NSString stringWithFormat:@"%@service/sms", HBSNetAdress] parame:params header:nil cookie:nil result:^(id result) {
                
                if ([result[@"code"]integerValue] == 200) {
                    
                    self.sureLabel.text = result[@"result"][@"smscode"];
                    HBSLog(@"%@", result);
                    
                }
                
            }];
            
        } cancel:nil];
        
    }else{
        
        // 手机号错误
        [self alertWithTitle:@"请输入正确的手机号" message:nil sure:nil cancel:nil];
    }
    
}
#pragma mark - 开始定时器
- (void)starTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [self.timer fire];
}
#pragma mark - 结束定时器
- (void)stopTimer
{
    [self.timer invalidate];
}
#pragma mark - 定时器方法
- (void)timerAction
{
    if (self.time < 0) {
        self.send.text = @"发送验证码";
        self.time = 60;
        [self stopTimer];
        self.send.userInteractionEnabled = YES;
    } else {
        self.send.text = [NSString stringWithFormat:@"%lds", (long)self.time--];
        self.send.userInteractionEnabled = NO;
    }
}


#pragma mark - 手机号验证
- (BOOL)phoneProve
{
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

#pragma mark---- 登录方法
- (void)loginClick{
    
    HBSLoginController *loginIn = [[HBSLoginController alloc]init];
    BaseNavigationViewController *loginNavi = [[BaseNavigationViewController alloc] initWithRootViewController:loginIn];
    [self presentViewController:loginNavi animated:YES completion:^{
        self.tabBarController.selectedIndex = 0;
    }];

}
#pragma mark---微信三方登录
- (void)weChatClick{
    
    [SSEThirdPartyLoginHelper loginByPlatform:SSDKPlatformTypeWechat onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
        NSLog(@"微信%@",user.rawData);
        NSLog(@"微信%@",user.credential);
        NSLog(@"%@", user.icon);
        
        NSString *strWXOp = user.rawData[@"openid"];
        NSString *strWXNickName = user.rawData[@"nickname"];
        NSString *strWXSex = user.rawData[@"sex"];
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:user.rawData[@"headimgurl"]]];
        NSString *strWXHeadImg = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        if (user!=nil) {
            
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"wxopenID"] = strWXOp;
            params[@"nick_name"] = strWXNickName;
            params[@"user_head"] = strWXHeadImg;
            params[@"gender"] = strWXSex;
    
            [HBSNetWork postUrl:[NSString stringWithFormat:@"%@user/tpart_login", HBSNetAdress] parame:params header:nil cookie:nil result:^(id result) {
                
                
                if ([result[@"code"]integerValue] == 200) {

                    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:^{
                        
                    }];
                    [ProjectCache saveLoginMessage:result[@"result"]];
                    
                    if ([EMClient sharedClient].isLoggedIn) {
                        
                    }else{
                        
                        [[EMClient sharedClient] asyncLoginWithUsername:[ProjectCache getLoginMessage][@"user_im"] password:@"123456" success:^{
                            
                        } failure:^(EMError *aError) {
                            NSLog(@"%@", aError.errorDescription);
                        }];
                        
                    }
                    
                    
                }else if ([result[@"code"]integerValue] == 201){
                    
                    [self alertWithTitle:@"手机号未注册， 请去注册" message:nil sure:^{
                        
                        HBSRegisterController * registered = [[HBSRegisterController alloc]init];
                        BaseNavigationViewController *loginNavi = [[BaseNavigationViewController alloc] initWithRootViewController:registered];
                        [self presentViewController:loginNavi animated:YES completion:^{
                            
                        }];
                        
                    } cancel:^{
                        
                    }];
                    
                }else if ([result[@"code"]integerValue] == 202){
                    
                    [self alertWithTitle:@"手机号未注册， 请去注册" message:nil sure:^{
                        
                        HBSRegisterController * registered = [[HBSRegisterController alloc]init];
                        BaseNavigationViewController *loginNavi = [[BaseNavigationViewController alloc] initWithRootViewController:registered];
                        [self presentViewController:loginNavi animated:YES completion:^{
                            
                        }];
                        
                    } cancel:^{
                        
                    }];
                    
                }else if ([result[@"code"]integerValue] == 203){
                    
                    [self alertWithTitle:@"头像上传失败" message:nil sure:nil cancel:nil];
                    
                }else{
                    
                    [self alertWithTitle:@"请求失败" message:nil sure:nil cancel:nil];
                }
                
            }];
            
            
        }
        
    } onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
        if (state ==SSDKResponseStateSuccess)
        {
            NSLog(@"微信登陆成功");
            
        }
    }];
    
}
#pragma mark----QQ三方登录
- (void)QQClick:(UITapGestureRecognizer *)QQ{
    
    [SSEThirdPartyLoginHelper loginByPlatform:SSDKPlatformTypeQQ onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
        
        NSLog(@"qq%@",user.rawData);
        NSLog(@"qq%@",user.credential);
        NSLog(@"用户头像%@", user.icon);
        NSLog(@"%@", user.uid);
        
        NSString *strWXOp = user.uid;
        NSString *strWXNickName = user.rawData[@"nickname"];
        NSString *strWXSex = user.rawData[@"gender"];
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:user.rawData[@"figureurl_qq_2"]]];
        NSString *strWXHeadImg = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        
        if (user != nil) {
            
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"qqopenID"] = strWXOp;
            params[@"nick_name"] = strWXNickName;
            params[@"user_head"] = strWXHeadImg;
            params[@"gender"] = strWXSex;
            
            [HBSNetWork postUrl:[NSString stringWithFormat:@"%@user/tpart_login", HBSNetAdress] parame:params header:nil cookie:nil result:^(id result) {
                
                if ([result[@"code"]integerValue] == 200) {
                    
                    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:^{
                        
                    }];
                    
                    [ProjectCache saveLoginMessage:result[@"result"]];
                    
                    if ([EMClient sharedClient].isLoggedIn) {
                        
                    }else{
                        
                        [[EMClient sharedClient] asyncLoginWithUsername:[ProjectCache getLoginMessage][@"user_im"] password:@"123456" success:^{
                            
                        } failure:^(EMError *aError) {
                            NSLog(@"%@", aError.errorDescription);
                        }];
                        
                    }
                    
                    
                }else if ([result[@"code"]integerValue] == 201){
                    
                    [self alertWithTitle:@"手机号未注册， 请去注册" message:nil sure:^{
                        
                        HBSRegisterController * registered = [[HBSRegisterController alloc]init];
                        BaseNavigationViewController *loginNavi = [[BaseNavigationViewController alloc] initWithRootViewController:registered];
                        [self presentViewController:loginNavi animated:YES completion:^{
                            
                        }];
                        
                    } cancel:^{
                        
                    }];
                    
                }else if ([result[@"code"]integerValue] == 202){
                    
                    [self alertWithTitle:@"手机号未注册， 请去注册" message:nil sure:^{
                        
                        HBSRegisterController * registered = [[HBSRegisterController alloc]init];
                        BaseNavigationViewController *loginNavi = [[BaseNavigationViewController alloc] initWithRootViewController:registered];
                        [self presentViewController:loginNavi animated:YES completion:^{
                            
                        }];
                        
                    } cancel:^{
                        
                    }];
                    
                }else if ([result[@"code"]integerValue] == 203){
                    
                    [self alertWithTitle:@"头像上传失败" message:nil sure:nil cancel:nil];
                    
                }else{
                    
                    [self alertWithTitle:@"请求失败" message:nil sure:nil cancel:nil];
                }
                
                
                
                
            }];
            
        }
        
        
    } onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
        if (state == SSDKResponseStateSuccess)
        {
            HBSLog(@"QQ登录成功");
        }
    }];
}
#pragma mark----协议链接
- (void)xieYiClick{
    
    HBSXieYiController *xieYiWeb = [[HBSXieYiController alloc]init];
    [self.navigationController pushViewController:xieYiWeb animated:YES];
    
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
#pragma mark - 判断能否点击注册按钮
- (NSArray *)judgeLoginBtn
{
    NSArray *judge;
    if (![self phoneProve]) {
        judge = @[@0, @"请输入正确的手机号"];
    } else if ([self.phoneField.text rangeOfString:@" "].location != NSNotFound) {
        judge = @[@0, @"手机号中不能添加空格"];
    }else if (self.messageField.text.length == 0){
        judge = @[@0, @"验证码不能为空"];
    }else if (self.messageField.text.length != 6) {
        judge = @[@0, @"请输入正确的验证码"];
    }else if (self.messageField.text != self.sureLabel.text){
        judge = @[@0, @"验证码错误 请输入正确的验证码"];

    } else if (self.passwordFied.text.length == 0) {
        judge = @[@0, @"密码不能为空"];
    }else if (self.passwordFied.text.length < 6 || self.passwordFied.text.length >= 17) {
        judge = @[@0, @"密码应大于5位并小于17位"];
    } else if ([self.passwordFied.text rangeOfString:@" "].location != NSNotFound) {
        judge = @[@0, @"密码中不能添加空格"];
    }
    else {
        judge = @[@1, @""];
    }
    return judge;
}
#pragma mark ---箭头返回方法
- (void)clickImage{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

@end
