//
//  HBSLoginController.m
//  HBS_C
//
//  Created by 王 世江 on 16/10/17.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//
#import "HBSLoginController.h"
#import "HBSFindPasswordController.h"
#import "HBSRegisterController.h"
#import "MainViewController.h"
#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "WXApi.h"

@interface HBSLoginController ()
@property (nonatomic, strong) UILabel *loginLabel;//登录label
@property (nonatomic, strong) UIButton *leftBtn;//返回image
@property (nonatomic, strong) UIButton *registeredButton;//注册button
@property (nonatomic, strong) UILabel *grayLabel;//灰线label
@property (nonatomic, strong) UIImageView *logoImage;//logoImage
@property (nonatomic, strong) UITextField *phoneField;//手机号field
@property (nonatomic, strong) UILabel *phoneGrayLabel;//手机号下面的label
@property (nonatomic, strong) UITextField *passwordFied;//密码field
@property (nonatomic, strong) UILabel *passwordGrayLabel;//密码下面的label
@property (nonatomic, strong) UIButton *imageButton;//图片button
@property (nonatomic, strong) UIButton *passwordButton;//忘记密码button
@property (nonatomic, strong) UIImageView *threeImage;
@property (nonatomic, strong) UIImageView *weChatImage;//微信image
@property (nonatomic, strong) UIImageView *QQImage;//QQimage
@property (nonatomic, strong) NSString *weChatStr;//微信用户标识
@property (nonatomic,strong) NSString *QQStr;//QQ用户标识


@end

@implementation HBSLoginController
#pragma mark-----添加通知
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(goSave:) name:UITextFieldTextDidChangeNotification object:nil];
}
#pragma mark----移除通知
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
//    self.navigationController.navigationBar.hidden = NO;
//    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BAISE;
    [self setupTopTitle];
    
    
}
#pragma mark----顶部控件
- (void)setupTopTitle{
    
    //导航栏左侧的返回箭头
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.leftBtn.frame = CGRectMake(0, 20, 30, 35);
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_fanhuijiantou"] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(clickImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.leftBtn];
    

    //登录的label
    self.loginLabel = [[UILabel alloc]init];
    self.loginLabel.text = @"登录";
//    self.loginLabel.backgroundColor = HBSRandomColor;
    self.loginLabel.font = FONT(18);
    self.loginLabel.textColor = HBSColor(68, 68, 68);
    [self.view addSubview:self.loginLabel];
    [self.loginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.view).offset(34);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(40, 20));
        
    }];
    
    //注册的button
    self.registeredButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.registeredButton setTitleColor:[UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0] forState:UIControlStateNormal];
    self.registeredButton.titleLabel.font = FONT(15);
    [self.registeredButton setTitle:@"注册" forState:UIControlStateNormal];
    [self.registeredButton addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.registeredButton];
    [self.registeredButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
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
    
    //logoIamge
    self.logoImage = [[UIImageView alloc]init];
    [self.logoImage setImage:[UIImage imageNamed:@"logo"]];
    self.logoImage.layer.masksToBounds = YES;
    self.logoImage.layer.cornerRadius = 37.5;
    [self.view addSubview:self.logoImage];
    [self.logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.grayLabel).offset(50);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(75, 75));
        
    }];
    
    //手机号field
    self.phoneField = [[UITextField alloc]init];
//    self.phoneField.backgroundColor = HBSRandomColor;
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName] = HBSColor(204, 204, 204);
    self.phoneField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入手机号" attributes:attributes];
    self.phoneField.font = FONT(14);
    self.phoneField.tintColor = HBSColor(102, 102, 102);
    self.phoneField.keyboardType = UIKeyboardTypeDecimalPad;
    [self.view addSubview:self.phoneField];
    [self.phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.grayLabel).offset(162);
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
    
    //密码field
    self.passwordFied = [[UITextField alloc]init];
//    self.passwordFied.backgroundColor = HBSRandomColor;
    NSMutableDictionary *attribute = [NSMutableDictionary dictionary];
    attribute[NSForegroundColorAttributeName] = HBSColor(204, 204, 204);
    self.passwordFied.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入密码" attributes:attribute];
    self.passwordFied.secureTextEntry = YES;
    self.passwordFied.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordFied.font = FONT(14);
    self.passwordFied.tintColor = HBSColor(102, 102, 102);
//    self.passwordFied.keyboardType = UIKeyboardTypeDecimalPad;
    [self.view addSubview:self.passwordFied];
    [self.passwordFied mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.phoneGrayLabel).offset(20);
        make.left.mas_equalTo(self.view).offset(52);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 100, 20));
        
    }];
    
    //密码下面的灰色label
    self.passwordGrayLabel = [[UILabel alloc]init];
    self.passwordGrayLabel.backgroundColor = HBSColor(229, 229, 229);
    [self.view addSubview:self.passwordGrayLabel];
    [self.passwordGrayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.passwordFied).offset(40);
        make.left.mas_equalTo(self.view).offset(40);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 80, 1));
        
    }];
    
    //登录button
    self.imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.imageButton setBackgroundImage:[UIImage imageNamed:@"button_1_morendenglu"] forState:UIControlStateNormal];
    [self.imageButton setBackgroundImage:[UIImage imageNamed:@"button_1_xuanzhongdenglu"] forState:UIControlStateSelected];
    [self.imageButton addTarget:self action:@selector(imageClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.imageButton];
    [self.imageButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.passwordGrayLabel).offset(30);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 42, 36));
        
    }];
    
    
    //忘记密码button
    self.passwordButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.passwordButton setTitleColor:[UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0] forState:UIControlStateNormal];
    self.passwordButton.titleLabel.font = FONT(12);
    [self.passwordButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
//    self.passwordButton.backgroundColor = HBSRandomColor;
    [self.passwordButton addTarget:self action:@selector(forgetClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.passwordButton];
    [self.passwordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.imageButton).offset(51);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(60, 15));
        
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
#pragma mark----登录的方法
- (void)imageClick{
    
    if ([self checkWIFI]) {
        
        [self showLoadingViewWithMessage];
    
    if ([[self panduan][0]boolValue]) {
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"user_mobile"] = self.phoneField.text;
        params[@"user_password"] = self.passwordFied.text;
        params[@"user_type"] = @"0";
        
        
        [HBSNetWork postUrl:[NSString stringWithFormat:@"%@user/login", HBSNetAdress] parame:params header:nil cookie:nil result:^(id result) {
            
            
            if ([result[@"code"] integerValue] == 200) {
                
                [ProjectCache saveLoginMessage:result[@"result"]];
                
                if ([EMClient sharedClient].isLoggedIn) {
                    
                }else{
                    
                    [[EMClient sharedClient] asyncLoginWithUsername:[ProjectCache getLoginMessage][@"user_im"] password:@"123456" success:^{
                        
                    } failure:^(EMError *aError) {
                        NSLog(@"%@", aError.errorDescription);
                    }];

                }
                
                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];

               
            }else if ([result[@"code"]integerValue] == 201){
                
                [self alertWithTitle:@"手机号不正确" message:nil sure:nil cancel:nil];
                
            }else if ([result[@"code"]integerValue] == 202){
                
                [self alertWithTitle:@"该账户不存在，请先注册" message:nil sure:nil cancel:nil];
                
            }else if ([result[@"code"]integerValue] == 203){
                
                [self alertWithTitle:@"账户类型不匹配: 商家帐号不能登录客户版" message:nil sure:nil cancel:nil];
                
            }
            else if ([result[@"code"]integerValue] == 204){
                
                [self alertWithTitle:@"账户类型不匹配: 买家帐号不能登录商户版" message:nil sure:nil cancel:nil];
                
            }else if ([result[@"code"]integerValue] == 205){
                
                [self alertWithTitle:@"密码错误 请重新输入" message:nil sure:nil cancel:nil];
                
            }  else if ([result[@"code"] integerValue] == 400){
                
                [self alertWithTitle:@"亲 请输入正确的手机号" message:nil sure:nil cancel:nil];
                
                HBSLog(@"该账户不存在,  请先注册");
            }
            
             [self removeLodingView];
            
        }];
        
    }else{
        
        [self alertWithTitle:[self panduan][1] message:nil sure:nil cancel:nil];
    }
        
    }else{
        
      [self alertWithTitle:@"您当前处于无网状态" message:nil sure:nil cancel:nil];  
        
    }
}

#pragma mark----注册的跳转方法
- (void)registerClick{
    
   
    HBSRegisterController * registered = [[HBSRegisterController alloc]init];
    BaseNavigationViewController *loginNavi = [[BaseNavigationViewController alloc] initWithRootViewController:registered];
    [self presentViewController:loginNavi animated:YES completion:^{
        
    }];

}
#pragma mark----忘记密码的跳转方法
- (void)forgetClick{
    
    HBSFindPasswordController *find = [[HBSFindPasswordController alloc]init];
    BaseNavigationViewController *loginFind = [[BaseNavigationViewController alloc] initWithRootViewController:find];
    [self presentViewController:loginFind animated:YES completion:^{
        
    }];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}
#pragma mark----通知中心的实现方法
- (void)goSave:(NSNotification *)Notification{
    
    if (self.phoneField.text.length == 11 && self.passwordFied.text.length <= 16 && self.passwordFied.text.length >= 6) {
        self.imageButton.selected = YES;
        self.imageButton.userInteractionEnabled = YES;
    }else{
        
        self.imageButton.selected = NO;
    }
   
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
       
//        NSURL *url = [NSURL URLWithString:user.rawData[@"headimgurl"]];
//        NSData *data = [NSData dataWithContentsOfURL:url];
//         NSString *strWXHeadImg = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        
//        NSString *headStr = [user.rawData[@"headimgurl"] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
//        NSString *headStr = [user.rawData[@"headimgurl"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        NSData *data =[headStr dataUsingEncoding:NSUTF8StringEncoding];
//        NSString *strWXHeadImg = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        
        self.weChatStr = user.rawData[@"openid"];
        
        if (user!=nil) {
         
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"wxopenID"] = strWXOp;
            params[@"nick_name"] = strWXNickName;
//            params[@"user_head"] = strWXHeadImg;
            params[@"gender"] = strWXSex;
            
            [HBSNetWork postUrl:[NSString stringWithFormat:@"%@user/tpart_login", HBSNetAdress] parame:params header:nil cookie:nil result:^(id result) {
                
                
                if ([result[@"code"]integerValue] == 200) {
                    
                    [self dismissViewControllerAnimated:YES completion:^{
                        
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
                    
                    [self alertWithTitle:@"请先注册账号" message:nil sure:^{
                        
                        HBSRegisterController * registered = [[HBSRegisterController alloc]init];
                        BaseNavigationViewController *loginNavi = [[BaseNavigationViewController alloc] initWithRootViewController:registered];
                        registered.weChatStr = self.weChatStr;

                        [self presentViewController:loginNavi animated:YES completion:^{
                            
                        }];
                        
                    } cancel:^{
                        
                    }];
                    
                }else if ([result[@"code"]integerValue] == 202){
                    
                    [self alertWithTitle:@"请先注册账号" message:nil sure:^{
                        
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
        NSLog(@"用户标识%@", user.uid);
        
//        NSLog(@"%ld", user.credential[@"openid"]);
        //qq用户标识A47751AC933E5981F91C3B9610F3D6CF
        //qq用户标识DC774951C10AD03EDD72827F69C0FAC2
        
        NSString *strWXOp = user.uid;
        NSString *strWXNickName = user.rawData[@"nickname"];
        NSString *strWXSex = user.rawData[@"gender"];
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:user.rawData[@"figureurl_qq_2"]]];
        NSString *strWXHeadImg = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        self.QQStr = user.uid;
        if (user != nil) {
            
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"qqopenID"] = strWXOp;
            params[@"nick_name"] = strWXNickName;
            params[@"user_head"] = strWXHeadImg;
            params[@"gender"] = strWXSex;
            
            [HBSNetWork postUrl:[NSString stringWithFormat:@"%@user/tpart_login", HBSNetAdress] parame:params header:nil cookie:nil result:^(id result) {
               
                if ([result[@"code"]integerValue] == 200) {
                    
                    
                    
                    [self dismissViewControllerAnimated:YES completion:^{
                        
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
                    
                    [self alertWithTitle:@"请先注册账号" message:nil sure:^{
                        
                        HBSRegisterController * registered = [[HBSRegisterController alloc]init];
                        BaseNavigationViewController *loginNavi = [[BaseNavigationViewController alloc] initWithRootViewController:registered];
                            registered.QQStr = self.QQStr;
                        
                        [self presentViewController:loginNavi animated:YES completion:^{
                            
                        }];
                        
                    } cancel:^{
                        
                    }];
                    
                }else if ([result[@"code"]integerValue] == 202){
                    
                    [self alertWithTitle:@"请先注册账号" message:nil sure:^{
                        
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
#pragma 箭头返回方法
- (void)clickImage{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (NSArray *)panduan
{
    NSArray *arr = [NSArray array];
    if (self.phoneField.text.length == 0) {
        arr = @[@0, @"手机号不能为空"];
    }else if (self.phoneField.text.length != 11){
        arr = @[@0, @"手机号输入错误, 请重新输入"];
    }else if ([self.phoneField.text rangeOfString:@" "].location != NSNotFound){
        arr = @[@0, @"手机号中不能包含空格, 请重新输入"];
    }else if (self.passwordFied.text.length == 0){
        arr = @[@0, @"密码不能为空"];
    }else if (self.passwordFied.text.length < 6){
        arr = @[@0, @"密码输入错误, 请重新输入"];
    } else if ([self.passwordFied.text rangeOfString:@" "].location != NSNotFound){
        arr = @[@0, @"密码中不能包含空格, 请重新输入"];
    } else {
        arr = @[@1, @""];
    }
    return arr;
}
@end
