//
//  HBSMyWalletController.m
//  HBS_C
//
//  Created by 王 世江 on 16/10/30.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSMyWalletController.h"

@interface HBSMyWalletController ()
@property (nonatomic, strong) UIButton *leftBtn;
@property (strong, nonatomic) IBOutlet UILabel *balanceLabel;//余额label
@property (strong, nonatomic) IBOutlet UILabel *integralLabel;//积分label
@property (strong, nonatomic) IBOutlet UIImageView *tiXianImage;//申请提现image
@property (strong, nonatomic) IBOutlet UIImageView *shouZhiImage;//收支明细image

@property (nonatomic, strong) NSDictionary *getDic;//接受数据
@end
@implementation HBSMyWalletController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BAISE;
    [self setUpChildControls];
    [self getupData];
    
}
#pragma mark----设置子控件
- (void)setUpChildControls{
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.leftBtn.frame = CGRectMake(0, 20, 30, 35);
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_fanhuijiantou"] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(clickImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.leftBtn];
    //申请提现image
    UITapGestureRecognizer *tiXianImage = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tiXianImageClick)];
    [self.tiXianImage addGestureRecognizer:tiXianImage];
    //收支明细image
    UITapGestureRecognizer *shouZhiImage = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shouZhiImageClick)];
    [self.shouZhiImage addGestureRecognizer:shouZhiImage];
    
}
#pragma mark----获取数据
- (void)getupData{
    
    NSMutableDictionary *paramas = [NSMutableDictionary dictionary];
    paramas[@"id"] = [ProjectCache getLoginMessage][@"user_id"];
    paramas[@"user_token"] = userToken;
    
    [HBSNetWork getUrl:[NSString stringWithFormat:@"%@user/%@/wallet",HBSNetAdress, [ProjectCache getLoginMessage][@"user_id"]] paramaters:paramas header:nil cookie:nil Result:^(id result) {
        
        if ([result[@"code"]integerValue] == 200) {
            
        HBSLog(@"%@", result[@"result"]);
        self.getDic = result[@"result"];
        self.balanceLabel.text = self.getDic[@"user_balances"];
        self.integralLabel.text = [NSString stringWithFormat:@"%@",self.getDic[@"user_integral"]];
            
        }else if ([result[@"code"]integerValue] == 400){
            
        }
        
    }];

}
#pragma mark----箭头image返回方法
- (void)clickImage{
    
    [self.navigationController popViewControllerAnimated:YES];
    [self.tabBarController.tabBar setHidden:NO];

}
#pragma mark----实现申请提现的方法
- (void)tiXianImageClick{
    
    [self alertWithTitle:@"即将上线 敬请期待" message:nil sure:nil cancel:nil];
    
}
#pragma mark----实现收支明细的方法
- (void)shouZhiImageClick{
    
    [self alertWithTitle:@"即将上线 敬请期待" message:nil sure:nil cancel:nil];
}
@end
