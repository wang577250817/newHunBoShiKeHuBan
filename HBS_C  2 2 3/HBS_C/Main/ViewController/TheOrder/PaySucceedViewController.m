//
//  PaySucceedViewController.m
//  HBS_C
//
//  Created by wangzuowen on 2016/12/21.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "PaySucceedViewController.h"

@interface PaySucceedViewController ()

@end

@implementation PaySucceedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BAISE;
    
//    UIBarButtonItem *releaseButon=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(rightAction)];
//    releaseButon.tintColor = HEISE;
//    self.navigationItem.rightBarButtonItem=releaseButon;
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.backgroundColor = WZWgrayColor;
    bt.frame = CGRectMake(200, 30, 100, 20);
    [self.view addSubview:bt];
    [bt addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIImageView *backImage = ImageAlloc(0, 64, WIDTH, HEIGHT);
    backImage.image = [UIImage imageNamed:@"paysuccess"];
//    backImage.backgroundColor = WZWmagentaColor;
    [self.view addSubview:backImage];
    
    UILabel *payType = LabelAlloc(0, HEIGHT / 2 + 10, WIDTH, 20);
    payType.textColor = yilingerColor;
    payType.font = FONT(15);
    payType.textAlignment = NSTextAlignmentCenter;
    payType.text = @"支付方式:alipay";
    [self.view addSubview:payType];
    
    UILabel *moneyLabel = LabelAlloc(0, HEIGHT / 2 + 30 + 5, WIDTH, 20);
    payType.text = [NSString stringWithFormat:@"支付方式:%@", self.typeStr];
    moneyLabel.textColor = yilingerColor;
    moneyLabel.font = FONT(15);
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    moneyLabel.text = [NSString stringWithFormat:@"支付金额:¥%@", self.moneyStr];
    [self.view addSubview:moneyLabel];
}
- (void)rightAction
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
//    PaySucceedViewController *payVC = [PaySucceedViewController new];
//    BaseNavigationViewController *loginNavi = [[BaseNavigationViewController alloc] initWithRootViewController:payVC];
//    [loginNavi popToRootViewControllerAnimated:YES];
//    self.tabBarController.selectedIndex = 2;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController popToRootViewControllerAnimated:YES];
    self.tabBarController.selectedIndex = 0;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
