//
//  PayMoneyViewController.m
//  Dr.hun
//
//  Created by wangzuowen on 16/7/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PayMoneyViewController.h"
#include <netdb.h>
#include <net/if.h>
#include <ifaddrs.h>
#include <dlfcn.h>
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>

#import "WXApi.h"
#import <CommonCrypto/CommonDigest.h>
#import "PaySucceedViewController.h"

@interface PayMoneyViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UILabel *numLabel;
@property (nonatomic, strong)UILabel *num1Label;
@property (nonatomic, strong)UILabel *moneyLabel;
@property (nonatomic, strong)UILabel *money1Label;
@property (nonatomic, strong)UILabel *timeLabel;
@property (nonatomic, strong)UILabel *time1Label;
@property (nonatomic, strong)UILabel *serverLabel;
@property (nonatomic, strong)UILabel *server1Label;
@property (nonatomic, strong)UIView *view1;
@property (nonatomic, strong)UIView *view2;
@property (nonatomic, strong)UIView *view3;
@property (nonatomic, strong)UIView *view4;
@property (nonatomic, strong)UILabel *chooseLabel;

@property (nonatomic, strong)UIView *view5;
@property (nonatomic, strong)UILabel *priceLabel;
@property (nonatomic, strong)UIButton *payNowButton;

@property (nonatomic, assign)NSInteger PayType;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, copy)NSString *freshPrice;
@property (nonatomic, assign)BOOL isFreshPrice;
@end

@implementation PayMoneyViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    if([WXApi isWXAppInstalled]) // 判断 用户是否安装微信
    {
        // 监听一个通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderPayResult:) name:@"ORDER_PAY_NOTIFICATION" object:nil];
    }
}
- (void)dealloc
{
    self.tableView.delegate = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RANDOMCOLOR(244, 244, 243);
    self.title = @"收银台";
    
    [self creatSubViews];
    [self creatTableVIew];
    
    UIButton *shareButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(WIDTH - 35, 10, 70, 20);
    [shareButton addTarget:self action:@selector(releaseInfo:) forControlEvents:UIControlEventTouchUpInside];
    shareButton.titleLabel.font = FONT(15);
    [shareButton setTitleColor:FENSE forState:UIControlStateNormal];
    [shareButton setTitle:@"刷新价格" forState:UIControlStateNormal];
    shareButton.tintColor = FENSE;
    UIBarButtonItem *sendButtonItem = [[UIBarButtonItem alloc] initWithCustomView:shareButton];
    self.navigationItem.rightBarButtonItem = sendButtonItem;
    
    _isFreshPrice = NO;
    
}

- (void)releaseInfo:(UIButton *)sender
{
    
//    self.view.userInteractionEnabled = NO;
    if ([self checkWIFI]) {
        if ([ProjectCache isLogin]) {
            [self showLoadingViewWithMessage];
            NSDictionary *dic = @{@"sId":[ProjectCache getLoginMessage][@"user_id"]
                                  };
            [HBSNetWork getUrl:[NSString stringWithFormat:@"%@order/%@/price", HBSNetAdress, self.dicInfo[@"order_ids"]] paramaters:dic header:@"dcx" cookie:nil Result:^(id result) {
                if ([result[@"code"] integerValue] == 200) {
                    _priceLabel.text = [NSString stringWithFormat:@"合计:¥%@", result[@"result"][@"amount"]];
                    _isFreshPrice = YES;
                    _freshPrice = result[@"result"][@"amount"];
                }
                [self removeLodingView];
            }];
        }else{
            [self presentViewController:[[HBSLoginController alloc] init] animated:YES completion:^{
                
            }];
        }

    }else{
//        [self noNetWorkView:self.view];
    }
}
- (void)creatSubViews
{
    self.view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 74, WIDTH, 40)];
    self.view1.backgroundColor = BAISE;
    [self.view addSubview:self.view1];
    self.numLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
    self.numLabel.textColor = HEISE;
    self.numLabel.text = @"订单编号";
    self.numLabel.font = FONT(15);
    [self.view1 addSubview:self.numLabel];
    self.num1Label = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, WIDTH - 110, 40)];
    self.num1Label.textColor = HEISE;
    self.num1Label.textAlignment = NSTextAlignmentRight;
    self.num1Label.font = FONT(15);
    [self.view1 addSubview:self.num1Label];
    
    self.view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 115, WIDTH, 40)];
    self.view2.backgroundColor = BAISE;
    [self.view addSubview:self.view2];
    self.moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
    self.moneyLabel.text = @"订单总额";
    self.moneyLabel.textColor = HEISE;
    self.moneyLabel.font = FONT(15);
    [self.view2 addSubview:self.moneyLabel];
    self.money1Label = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, WIDTH - 110, 40)];
    self.money1Label.textAlignment = NSTextAlignmentRight;
    self.money1Label.textColor = FENSE;
    self.money1Label.font = FONT(15);
    [self.view2 addSubview:self.money1Label];
    
    self.view3 = [[UIView alloc] initWithFrame:CGRectMake(0, 156, WIDTH, 40)];
    self.view3.backgroundColor = BAISE;
    [self.view addSubview:self.view3];
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
    self.timeLabel.text = @"时间";
    self.timeLabel.textColor = HEISE;
    
    self.timeLabel.font = FONT(15);
    [self.view3 addSubview:self.timeLabel];
    self.time1Label = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, WIDTH - 110, 40)];
    self.time1Label.textColor = HEISE;
    self.time1Label.font = FONT(15);
    self.time1Label.textAlignment = NSTextAlignmentRight;
    [self.view3 addSubview:self.time1Label];
    
    self.view4 = [[UIView alloc] initWithFrame:CGRectMake(0, 197, WIDTH, 40)];
    self.view4.backgroundColor = BAISE;
    [self.view addSubview:self.view4];
    self.serverLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
    
    self.serverLabel.textColor = HEISE;
    self.serverLabel.text = @"对象";
    self.serverLabel.font = FONT(15);
    [self.view4 addSubview:self.serverLabel];
    self.server1Label = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, WIDTH - 110, 40)];
    self.server1Label.textColor = HEISE;
    self.server1Label.font = FONT(15);
    self.server1Label.textAlignment = NSTextAlignmentRight;
    [self.view4 addSubview:self.server1Label];
    
    self.chooseLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 247, WIDTH - 20, 30)];
    self.chooseLabel.text = @"请选择支付方式";
    self.chooseLabel.font = FONT(14);
    self.chooseLabel.textColor = BEIJINGSE;
    [self.view addSubview:self.chooseLabel];
    
    self.view5 = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT - (64*HSHIPEI), WIDTH, 64 * HSHIPEI)];
    self.view5.backgroundColor = BAISE;
    [self.view addSubview:self.view5];
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(100 * WSHIPEI, 0, 150 * WSHIPEI, 64 * HSHIPEI)];
    
    self.priceLabel.textColor = HEISE;
    [self.view5 addSubview:self.priceLabel];
    self.payNowButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.payNowButton.frame = CGRectMake(255 * WSHIPEI, 0, 120 * WSHIPEI, 64 * HSHIPEI);
    self.payNowButton.backgroundColor = FENSE;
    [self.payNowButton addTarget:self action:@selector(payNow) forControlEvents:UIControlEventTouchUpInside];
    [self.payNowButton setTitle:@"立即支付" forState:UIControlStateNormal];
    [self.view5 addSubview:self.payNowButton];
    
    if (![self.dicInfo isEqual:[NSNull null]]) {
        self.num1Label.text = self.dicInfo[@"order_sn"];
        self.money1Label.text = [NSString stringWithFormat:@"¥%@",self.dicInfo[@"order_amount"]];
        self.time1Label.text = self.dicInfo[@"order_date"];
        self.server1Label.text = self.dicInfo[@"order_title"];
        self.priceLabel.text = [NSString stringWithFormat:@"合计:¥%@", self.dicInfo[@"order_amount"]];
    }
}

#if 1

- (void)payNow
{
    if (self.PayType==0) {
        [self showLoadingViewWithMessage];
        NSDictionary *dic = @{@"order_sn":self.dicInfo[@"order_sn"],
                         @"order_amount":_isFreshPrice?_freshPrice:self.dicInfo[@"order_amount"],
                         @"order_title":self.dicInfo[@"order_title"],
                         @"order_ids":self.dicInfo[@"order_ids"],
                         @"paytype":@"alipay",};
        [HBSNetWork postUrl:[NSString stringWithFormat:@"%@order/pay", HBSNetAdress] parame:dic header:nil cookie:nil result:^(id result) {
            if ([result[@"code"] integerValue] == 200) {
                
                    
                NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"@\""];
                NSString *trimmedString = [result[@"result"][@"PayString"] stringByTrimmingCharactersInSet:set];
                
                [self getAlipay:[NSString stringWithFormat:@"%@\"", trimmedString]];
                
                
            }
            [self removeLodingView];
        }];
        
    }else if(self.PayType == 1){
        [self showLoadingViewWithMessage];
        NSDictionary *dic = @{@"order_sn":self.dicInfo[@"order_sn"],
                               @"order_amount":_isFreshPrice?_freshPrice:self.dicInfo[@"order_amount"],
                              @"order_title":self.dicInfo[@"order_title"],
                              @"order_ids":self.dicInfo[@"order_ids"],
                              @"paytype":@"wxpay",};
        [HBSNetWork postUrl:[NSString stringWithFormat:@"%@order/pay", HBSNetAdress] parame:dic header:nil cookie:nil result:^(id result) {
            if ([result[@"code"] integerValue] == 200) {
               
                    NSDictionary *ddPayInfo=@{
                                              @"wX_MCH_ID":result[@"result"][@"mch_id"],
                                              @"prepayId":result[@"result"][@"prepay_id"],
                                              @"nonceStr":result[@"result"][@"nonce_str"]
                                              };
                    [self getTenpay:ddPayInfo];
            }
            [self removeLodingView];
        }];
    }

}
#endif
- (void)getTenpay:(NSDictionary *)dict{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%f", a];
    //调起微信支付
    PayReq* req             = [[PayReq alloc] init];
    req.partnerId           = [dict objectForKey:@"wX_MCH_ID"];
    req.prepayId            = [dict objectForKey:@"prepayId"];
    req.nonceStr            = [dict objectForKey:@"nonceStr"];
    req.timeStamp           = timeString.intValue;
    req.package             = @"Sign=WXPay";
    
    NSString *strSign=[NSString stringWithFormat:@"appid=%@&noncestr=%@&package=%@&partnerid=%@&prepayid=%@&timestamp=%ld&key=%@",@"wx8ece83b5cc3c48a4",req.nonceStr,req.package,req.partnerId,req.prepayId,(long)req.timeStamp,@"0a758c8dbb4f58aefbc348c9d66cd802"];
    
    strSign = [self md5:strSign];
    req.sign                = strSign;
    [WXApi sendReq:req];
    //日志输出
}
- (NSString *)md5:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    /*
     extern unsigned char *CC_MD5(const void *data, CC_LONG len, unsigned char *md)官方封装好的加密方法
     把cStr字符串转换成了32位的16进制数列（这个过程不可逆转） 存储到了result这个空间中
     */
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2],result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
    /*
     x表示十六进制，%02X  意思是不足两位将用0补齐，如果多余两位则不影响
     NSLog("%02X", 0x888);  //888
     NSLog("%02X", 0x4); //04
     */
}
- (void)creatTableVIew
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 280, WIDTH, HEIGHT - 270 - 64) style:UITableViewStylePlain];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = RANDOMCOLOR(244, 244, 243);
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.PayType=(int)indexPath.row;
    [_tableView reloadData];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
    }else{
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
    }
    UIButton *btnSelect=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnSelect setFrame:CGRectMake(WIDTH-60, 12, 20, 20)];
    [btnSelect setImage:[UIImage imageNamed:@"icon_hun@2x"] forState:UIControlStateNormal];
    [btnSelect setImage:[UIImage imageNamed:@"icon_xuanzhong@2x"] forState:UIControlStateSelected];
    if (indexPath.row==0) {
        [cell.imageView setImage:[UIImage imageNamed:@"icon_zhifubao@2x"]];
        cell.textLabel.text=@"支付宝支付";
    }else if(indexPath.row == 1){
        [cell.imageView setImage:[UIImage imageNamed:@"icon_weixin@2x"]];
        cell.textLabel.text=@"微信支付";
    }else{
        [cell.imageView setImage:[UIImage imageNamed:@"icon_yuezhifu@2x"]];
        cell.textLabel.text=@"余额支付";
    }
    [cell.contentView setBackgroundColor:[UIColor whiteColor]];
    [btnSelect setUserInteractionEnabled:NO];
    [cell.contentView addSubview:btnSelect];
    if (indexPath.row == self.PayType) {
        btnSelect.selected=YES;
    }else
        btnSelect.selected=NO;
    return cell;
}
-(void)getAlipay:(NSString *)orderString
{
//    [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    
    NSString *appScheme = @"DrHAPPURL";
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        if ([[[resultDic objectForKey:@"resultStatus"] description] isEqualToString:@"6001"]) {
            //取消支付
            [self creatAlertViewOne:@"温馨提示" message:@"用户取消支付" sureStr:@"确定" sureAction:^(id result) {
                
            }];
        }
        else if ([[[resultDic objectForKey:@"resultStatus"] description] isEqualToString:@"4000"]){
            //支付失败
            [self creatAlertViewOne:@"温馨提示" message:@"支付失败" sureStr:@"确定" sureAction:^(id result) {
                
            }];
        }
        else if ([[[resultDic objectForKey:@"resultStatus"] description] isEqualToString:@"6002"]){
            //网络链接出错
            [self creatAlertViewOne:@"温馨提示" message:@"网络链接出错" sureStr:@"确定" sureAction:^(id result) {
                
            }];
        }
        else if ([[[resultDic objectForKey:@"resultStatus"] description] isEqualToString:@"8000"]){
            //正在处理中
            [self creatAlertViewOne:@"温馨提示" message:@"正在处理中" sureStr:@"确定" sureAction:^(id result) {
                
            }];
        }
        else if ([[[resultDic objectForKey:@"resultStatus"] description] isEqualToString:@"9000"]){
            //订单支付成功
            
            PaySucceedViewController *success = [[PaySucceedViewController alloc] init];
            success.moneyStr = _isFreshPrice?_freshPrice:self.dicInfo[@"order_amount"];
            success.typeStr = @"支付宝支付";
//            [self.navigationController pushViewController:success animated:YES];
                [self presentViewController:success animated:YES completion:^{
                    
                }];
            return ;
            
        }
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
}
#pragma mark - wxblock
- (void)getOrderPayResult:(NSNotification *)notification
{
    if ([notification.object isEqualToString:@"success"])
    {
        PaySucceedViewController *success = [[PaySucceedViewController alloc] init];
        success.moneyStr = _isFreshPrice?_freshPrice:self.dicInfo[@"order_amount"];
        success.typeStr = @"微信支付";
        [self.navigationController pushViewController:success animated:YES];
    }
    else
    {
        [self creatAlertWithTimer:@"支付失败" fatherView:self.view];
    }
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
