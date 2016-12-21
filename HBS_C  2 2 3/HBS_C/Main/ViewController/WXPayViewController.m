//
//  WXPayViewController.m
//  HBS_C
//
//  Created by wangzuowen on 16/10/14.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "WXPayViewController.h"
#import "WXApi.h"
#import <CommonCrypto/CommonDigest.h>


@interface WXPayViewController ()

@end

@implementation WXPayViewController

- (void)viewWillAppear:(BOOL)animated
{
    if([WXApi isWXAppInstalled]) // 判断 用户是否安装微信
    {
        // 监听一个通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderPayResult:) name:@"ORDER_PAY_NOTIFICATION" object:nil];
    }
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = WZWgrayColor;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.frame = CGRectMake(100, 100, 50, 50);
    button.backgroundColor = [UIColor magentaColor];
    [button addTarget:self action:@selector(wexin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button1.frame = CGRectMake(100, 250, 50, 50);
    button1.backgroundColor = [UIColor orangeColor];
    [button1 addTarget:self action:@selector(two) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
//    [ProjectCache saveLoginNameAndPassWord:@"wzw" passWord:@"123"];
//    NSLog(@"%@", [ProjectCache getLoginNameAndPassWord]);
}

- (void)two
{
//    ChatListViewController *cc = [[ChatListViewController alloc] init];
//    [self.navigationController pushViewController:cc animated:YES];
    //UIImageView *mm = [[UIImageView alloc] init];
    //[UIImage imageWithContentsOfFile:@""];//
}
- (void)wexin
{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:@"" forKey:@"sId"];
    [dic setObject:@"" forKey:@"sToken"];
    int random= (int)(1000 + (arc4random() % (9999 - 1000 + 1)));
    [dic setObject:[NSString stringWithFormat:@"%@-%d",@"211314",random] forKey:@"out_trade_no"];
    [dic setObject:[NSString stringWithFormat:@"【婚博士】-- %@",@"axiba"] forKey:@"body"];
    [dic setObject:@"0.01" forKey:@"total_fee"];
    [dic setObject:@"all" forKey:@"pay_type"];
    [dic setObject:@"" forKey:@"order_ids"];
    //    NSString *url=[ProjectCache returnUrl:@"index.php" action:@"Lct_HBS_GetPrePayId" sItem:dic];
    
    //    [get downloadFromGetUrl:url completionHandler:^(NSData *data, NSError *error) {
    //        [self removeLodingView];
    //        if (error) {
    //            NSLog(@"error=%@",[error localizedDescription]);
    //        }else{
    //            NSDictionary *json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
    //            NSLog(@"%@",json);
    //            if ([json[@"R"] intValue]>0) {
    NSDictionary  *ddPayInfo=@{@"wX_MCH_ID":@"1304509201",@"prepayId":@"wx2016091014090537314b1c460477881779",@"nonceStr":@"xMYt9cbSRAF4EnZP"};
    [self getTenpay:ddPayInfo];
}

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
- (void)getOrderPayResult:(NSNotification *)notification
{
    if ([notification.object isEqualToString:@"success"])
    {
        NSLog(@"支付成功！");
    }
    else
    {
        NSLog(@"支付失败！");
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
