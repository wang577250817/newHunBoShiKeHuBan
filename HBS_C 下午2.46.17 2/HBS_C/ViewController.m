//
//  ViewController.m
//  HBS_C
//
//  Created by wangzuowen on 16/9/9.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "ViewController.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>

@implementation Product


@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor orangeColor];
    self.navigationItem.title = @"支付宝支付";
    [self generateData];
    self.productTableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.productTableView.delegate = self;
    self.productTableView.dataSource = self;
    [self.view addSubview:self.productTableView];
}
#pragma mark -
#pragma mark   ==============产生随机订单号==============


- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}



#pragma mark -
#pragma mark   ==============产生订单信息==============

- (void)generateData{
    NSArray *subjects = @[@"1",
                          @"2",@"3",@"4",
                          @"5",@"6",@"7",
                          @"8",@"9",@"10"];
    NSArray *body = @[@"我是测试数据",
                      @"我是测试数据",
                      @"我是测试数据",
                      @"我是测试数据",
                      @"我是测试数据",
                      @"我是测试数据",
                      @"我是测试数据",
                      @"我是测试数据",
                      @"我是测试数据",
                      @"我是测试数据"];
    
    if (nil == self.productList) {
        self.productList = [[NSMutableArray alloc] init];
    }
    else {
        [self.productList removeAllObjects];
    }
    
    for (int i = 0; i < [subjects count]; ++i) {
        Product *product = [[Product alloc] init];
        product.subject = [subjects objectAtIndex:i];
        product.body = [body objectAtIndex:i];
        
        product.price = 0.01;
        [self.productList addObject:product];
    }
}


#pragma mark -
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.0f;
}

#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.productList count];
}




//
//用TableView呈现测试数据,外部商户不需要考虑
//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                                   reuseIdentifier:@"Cell"];
    
    Product *product = [self.productList objectAtIndex:indexPath.row];
    
    cell.textLabel.text = product.body;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"一口价：%.2f",product.price];
    return cell;
}


#pragma mark -
#pragma mark   ==============点击订单模拟支付行为==============
//
//选中商品调用支付宝极简支付
//
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//
//    /*
//     *点击获取prodcut实例并初始化订单信息
//     */
//    Product *product = [self.productList objectAtIndex:indexPath.row];
//    
//    /*
//     *商户的唯一的parnter和seller。
//     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
//     */
//    
//    /*============================================================================*/
//    /*=======================需要填写商户app申请的===================================*/
//    /*============================================================================*/
//    NSString *partner = @"2088121450548413";
//    NSString *seller = @"pay@hunboshi.com.cn";
//    NSString *privateKey = @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAK1uXer13CsgGDt6ooSVgifVCEJOK6mMoh0c55gZmOtwT9LYcW9Rg0TWdj0Xazbbt8wSLpMnomUAiM3pfE9eQqCIwYAcAWntyElgPBRHcGfg6AAW9o2RIA7EU8dOH5EEDAEgbaHbEaHulzxLQxTGCwCVQBey7oSV6HBXw+0sJ+ZRAgMBAAECgYBBx3+Vs4S7UqP+Q0hK004Xf4RvaajD2RRPyHvKw8KtYd7U0MVNfHQ2csVL7Ir8tp9ipm7F352Hg4lf2DQPAmhwTJzUrzqNXIYDfyw44Rk41A+uo/d0mZxlVdbEZhfyyrdiNYxwmSv/tB20tC8Vf4+c3QLrJ7TrU1zj9hGGQ6BSQQJBAOXaL4+whHVfGZJvc+yHzPhXsJWb9hh6+erlscFqoEQnyDpgzyRIO+6QijNJwrQMOGVLbDEE1OUsMOZ8IYIMnmkCQQDBKRHzYpLSIZFiV+iGzTCuvYlBQKHxz8K71HPwybwv+QQ7D5eM/3VtO0ik7U4WmQObCScbyb/A9tXBaUjA5FupAkEAtXTMO2mlCGvtajdmkwKahCvmEhYv8B+VkSWIcSNWJrgpUD0BCqmj9rBRCjBe73j+RKmIXiJsWAfNCwhQA7UmkQJBAJ8/i/Qbja4+TI1GqocQfhViX9lzPtCMmCCg/GFFAKiQZYOHzEtLhXVjzfVjS+DnkAhumFaZk0S0e/B0K64T1tkCQQDjK99KLo/MqgDY4OWF1mgMhbYODXuQd7jTrJZfby4nEmkbBDa3x5vftPGRcOsmmxlx9fPq6CNTG2Mh1TqedOZ+";
//    /*============================================================================*/
//    /*============================================================================*/
//    /*============================================================================*/
//    
//    //partner和seller获取失败,提示
//    if ([partner length] == 0 ||
//        [seller length] == 0 ||
//        [privateKey length] == 0)
//    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                        message:@"缺少partner或者seller或者私钥。"
//                                                       delegate:self
//                                              cancelButtonTitle:@"确定"
//                                              otherButtonTitles:nil];
//        [alert show];
//        [tableView deselectRowAtIndexPath:indexPath animated:YES];
//        return;
//    }
//    
//    /*
//     *生成订单信息及签名
//     */
//    //将商品信息赋予AlixPayOrder的成员变量
//    Order *order = [[Order alloc] init];
//    order.partner = partner;
//    order.sellerID = seller;
//    order.outTradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
//    order.subject = product.subject; //商品标题
//    order.body = product.body; //商品描述
//    order.totalFee = [NSString stringWithFormat:@"%.2f",product.price]; //商品价格
//    order.notifyURL =  @"http://www.xxx.com"; //回调URL
//    
//    order.service = @"mobile.securitypay.pay";
//    order.paymentType = @"1";
//    order.inputCharset = @"utf-8";
//    order.itBPay = @"30m";
//    order.showURL = @"m.alipay.com";
//    
//    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
//    NSString *appScheme = @"alisdkdemo";
//    
//    //将商品信息拼接成字符串
//    NSString *orderSpec = [order description];
//    NSLog(@"orderSpec = %@",orderSpec);
//    
//    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
//    id<DataSigner> signer = CreateRSADataSigner(privateKey);
//    NSString *signedString = [signer signString:orderSpec];
//    
//    //将签名成功字符串格式化为订单字符串,请严格按照该格式
//    NSString *orderString = nil;
//    if (signedString != nil) {
//        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
//                       orderSpec, signedString, @"RSA"];
//        
//        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//            NSLog(@"reslut = %@",resultDic);
//        }];
//    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self getAlipay:@"13680" ProjectName:@"wzw" Des:@"name" Amount:@"0.01" payType:@"" ids:@"211314"];
}

-(void)getAlipay:(NSString *)tradeNo ProjectName:(NSString *)ProjectName Des:(NSString *)Des Amount:(NSString *)Amount payType:(NSString *)payType ids:(NSString *)ids{
    NSString *partner = @"2088121450548413";
    NSString *seller = @"pay@hunboshi.com.cn";
    NSString *privateKey = @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAK1uXer13CsgGDt6ooSVgifVCEJOK6mMoh0c55gZmOtwT9LYcW9Rg0TWdj0Xazbbt8wSLpMnomUAiM3pfE9eQqCIwYAcAWntyElgPBRHcGfg6AAW9o2RIA7EU8dOH5EEDAEgbaHbEaHulzxLQxTGCwCVQBey7oSV6HBXw+0sJ+ZRAgMBAAECgYBBx3+Vs4S7UqP+Q0hK004Xf4RvaajD2RRPyHvKw8KtYd7U0MVNfHQ2csVL7Ir8tp9ipm7F352Hg4lf2DQPAmhwTJzUrzqNXIYDfyw44Rk41A+uo/d0mZxlVdbEZhfyyrdiNYxwmSv/tB20tC8Vf4+c3QLrJ7TrU1zj9hGGQ6BSQQJBAOXaL4+whHVfGZJvc+yHzPhXsJWb9hh6+erlscFqoEQnyDpgzyRIO+6QijNJwrQMOGVLbDEE1OUsMOZ8IYIMnmkCQQDBKRHzYpLSIZFiV+iGzTCuvYlBQKHxz8K71HPwybwv+QQ7D5eM/3VtO0ik7U4WmQObCScbyb/A9tXBaUjA5FupAkEAtXTMO2mlCGvtajdmkwKahCvmEhYv8B+VkSWIcSNWJrgpUD0BCqmj9rBRCjBe73j+RKmIXiJsWAfNCwhQA7UmkQJBAJ8/i/Qbja4+TI1GqocQfhViX9lzPtCMmCCg/GFFAKiQZYOHzEtLhXVjzfVjS+DnkAhumFaZk0S0e/B0K64T1tkCQQDjK99KLo/MqgDY4OWF1mgMhbYODXuQd7jTrJZfby4nEmkbBDa3x5vftPGRcOsmmxlx9fPq6CNTG2Mh1TqedOZ+";
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.sellerID = seller;
    int random= (int)(1000 + (arc4random() % (9999 - 1000 + 1)));
    order.outTradeNO = [NSString stringWithFormat:@"%@-%d",tradeNo,random]; //订单ID（由商家自行制定）
    order.subject = ProjectName; //商品标题
    order.body = Des; //商品描述
    order.totalFee = [NSString stringWithFormat:@"%@",Amount]; //商品价格
    order.notifyURL =  [NSString stringWithFormat:@"http://www.hunboshi.com.cn/index.php?app=paynotify&act=app_notify&op=order&opc=alipay&order_id=%@&pay_type=all",tradeNo]; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showURL = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"DrHAPPURL";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            
            if ([[[resultDic objectForKey:@"resultStatus"] description] isEqualToString:@"6001"]) {
                //取消支付
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"用户取消支付" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([[[resultDic objectForKey:@"resultStatus"] description] isEqualToString:@"4000"]){
                //支付失败
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"支付失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([[[resultDic objectForKey:@"resultStatus"] description] isEqualToString:@"6002"]){
                //网络链接出错
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网络连接出错" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                
            }
            else if ([[[resultDic objectForKey:@"resultStatus"] description] isEqualToString:@"8000"]){
                //正在处理中
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"正在处理中" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                
            }
            else if ([[[resultDic objectForKey:@"resultStatus"] description] isEqualToString:@"9000"]){
                //订单支付成功
                                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"订单支付成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                                [alert show];
                
                NSLog(@"成功了");
                
            }
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
