//
//  HunBaViewController.m
//  HBS_C
//
//  Created by wangzuowen on 16/9/10.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HunBaViewController.h"
#import <ShareSDK/NSMutableDictionary+SSDKShare.h>
#import <ShareSDK/ShareSDK.h>

@interface HunBaViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArr;

@end

@implementation HunBaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    TITLE = @"🐒";
    
    self.dataArr = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4", nil];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        
    }
    cell.textLabel.text = self.dataArr[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *strText = @"";
    NSString *strUrl = @"";
    NSString *strTitle = @"";
    if (indexPath.row==3){
        //QQ空间
        //1、创建分享参数（必要）
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        // 定制QQ好友的分享内容
//        if (self.isArticle) {
//            strUrl = self.urlStr;
//            strText = self.textStr;
//            strTitle = self.titleStr;
//        }else{
            strText = @"如果您是即将步入婚礼殿堂的新的，那就快到我们婚博士的碗里来吧，我们期待您的到来...";
            strUrl = @"http://www.hunboshi.com.cn/index.php?app=phone&act=invite";
            strTitle = @"婚博士-贴身婚礼管家";
//        }
        [shareParams SSDKSetupQQParamsByText:strText title:strTitle url:[NSURL URLWithString:strUrl] thumbImage:nil image:[UIImage imageNamed:@"refresh@2x"] type:SSDKContentTypeAuto forPlatformSubType:6];
        
        //2、分享
        [ShareSDK share:6 parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity,  NSError *error) {
            if (state==1) {
//                [self showAlertViewWithMessage:@"分享成功" title:nil tag:0 delegate:nil leftBtnStr:@"确定" rightBtnStr:nil
//                 ];
                NSLog(@"成功了, 大兄弟");
            }
        }];
    }
    else if (indexPath.row==2){
        //QQ好友
        //1、创建分享参数（必要）
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        // 定制QQ好友的分享内容
//        if (self.isArticle) {
//            strUrl = self.urlStr;
//            strText = self.textStr;
//            strTitle = self.titleStr;
//        }else{
            strText = @"如果您是即将步入婚礼殿堂的新的，那就快到我们婚博士的碗里来吧，我们期待您的到来...";
            strUrl = @"http://www.hunboshi.com.cn/index.php?app=phone&act=invite";
            strTitle = @"婚博士-贴身婚礼管家";
//        }
        [shareParams SSDKSetupQQParamsByText:strText title:strTitle url:[NSURL URLWithString:strUrl] thumbImage:nil image:[UIImage imageNamed:@"logo_512"] type:SSDKContentTypeAuto forPlatformSubType:24];
        
        //2、分享
        [ShareSDK share:24 parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity,  NSError *error) {
            if (state==1) {
//                [self showAlertViewWithMessage:@"分享成功" title:nil tag:0 delegate:nil leftBtnStr:@"确定" rightBtnStr:nil
//                 ];
                                NSLog(@"成功了, 大兄弟");
            }
        }];
    }
    else if (indexPath.row==1){
        //微信朋友圈
        //1、创建分享参数（必要）
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        // 定制微信好友的分享内容
//        if (self.isArticle) {
//            strUrl = self.urlStr;
//            strText = self.textStr;
//            strTitle = self.titleStr;
//        }else{
            strText = @"如果您是即将步入婚礼殿堂的新的，那就快到我们婚博士的碗里来吧，我们期待您的到来...";
            strUrl = @"http://www.hunboshi.com.cn/index.php?app=phone&act=invite";
            strTitle = @"婚博士-贴身婚礼管家";
//        }
        [shareParams SSDKSetupWeChatParamsByText:strText
                                           title:strTitle
                                             url:[NSURL URLWithString:strUrl]
                                      thumbImage:nil
                                           image:[UIImage imageNamed:@"logo_512"]
                                    musicFileURL:nil
                                         extInfo:nil
                                        fileData:nil
                                    emoticonData:nil
                                            type:SSDKContentTypeAuto
                              forPlatformSubType:23];// 微信好友子平台
        
        //2、分享
        [ShareSDK share:23 parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity,  NSError *error) {
//            if (state==1) {
//                [self showAlertViewWithMessage:@"分享成功" title:nil tag:0 delegate:nil leftBtnStr:@"确定" rightBtnStr:nil
//                 ];
//            }
                            NSLog(@"成功了, 大兄弟");
        }];
    }else{
        //微信好友
        //1、创建分享参数（必要）
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        // 定制微信好友的分享内容
        [shareParams SSDKSetupWeChatParamsByText:@"测试内容"
                                           title:@"wzw"
                                             url:[NSURL URLWithString:@"http://www.hunboshi.com.cn/index.php?app=phone&act=invite"]                                     thumbImage:[UIImage imageNamed:@"icon_weixin"]
                                           image:[UIImage imageNamed:@"icon_weixin"]
                                    musicFileURL:nil
                                         extInfo:nil
                                        fileData:nil
                                    emoticonData:nil
                                            type:SSDKContentTypeAuto
                              forPlatformSubType:22];// 微信好友子平台
        
        //2、分享
        
        [ShareSDK share:22 parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity,  NSError *error) {
            if (state==1) {

            }
        }];
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
