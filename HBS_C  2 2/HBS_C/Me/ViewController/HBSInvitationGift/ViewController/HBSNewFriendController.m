//
//  HBSNewFriendController.m
//  HBS_C
//
//  Created by 王 世江 on 16/11/2.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSNewFriendController.h"
#import "HBSFriendCell.h"
#import <ShareSDK/NSMutableDictionary+SSDKShare.h>
#import <ShareSDK/ShareSDK.h>
@interface HBSNewFriendController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIImageView *leftImage;
@property (nonatomic, strong) UITableView * myTableView;
@property (nonatomic, strong) NSArray *listArr;//列表Arr
@property (nonatomic, strong) NSArray *imageArr;//图片image
@end

@implementation HBSNewFriendController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BAISE;
    [self setUpChildControls];
    
}
#pragma mark----设置子控件
- (void)setUpChildControls{
    
    //返回箭头
    UITapGestureRecognizer *tapImage = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImage)];
    [self.leftImage addGestureRecognizer:tapImage];
    
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 62, WIDTH, HEIGHT) style:UITableViewStylePlain];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
//    self.myTableView.contentInset = UIEdgeInsetsMake(0,50,50,0);
    self.myTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.myTableView.backgroundColor = HBSColor(244, 244, 243);
    self.myTableView.rowHeight = 65.0;
    [self.view addSubview:self.myTableView];
    self.listArr = @[@"微信好友", @"微信朋友圈", @"QQ好友", @"QQ空间", @"新浪微博"];
    self.imageArr = @[@"icon_1_2_weixinhaiyou", @"icon_1_2_weixinpenyouquan",@"icon_1_2_qqhaoyou", @"icon_1_2_qqkonhjian", @"icon_1_2_xinlangweibo"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellStr = @"cell";
    HBSFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (!cell) {
        cell = [[HBSFriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    NSDictionary *dic = @{@"image":self.imageArr[indexPath.row], @"title":self.listArr[indexPath.row]};
    cell.dic = dic;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    NSString *strText = @"";
    NSString *strUrl = @"";
    NSString *strTitle = @"";
    if (indexPath.row == 0) {
       
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        // 定制微信好友的分享内容
        if (self.isArticle) {
            strUrl = self.urlStr;
            strText = self.textStr;
            strTitle = self.titleStr;
        }else{
            strText = @"如果您是即将步入婚礼殿堂的新的，那就快到我们婚博士的碗里来吧，我们期待您的到来...";
            strUrl = @"http://www.hunboshi.com.cn/index.php?app=phone&act=invite";
            strTitle = @"婚博士-贴身婚礼管家";
        }
        [shareParams SSDKSetupWeChatParamsByText:strText title:strTitle url:[NSURL URLWithString:strUrl]               thumbImage:nil image:[UIImage imageNamed:@"LOGO"]musicFileURL:nil extInfo:nil fileData:nil emoticonData:nil type:SSDKContentTypeAuto forPlatformSubType:SSDKPlatformSubTypeWechatSession];// 微信好友子平台
        //2、微信分享
        [ShareSDK share:SSDKPlatformSubTypeWechatSession parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity,  NSError *error) {
            if (state==1) {
                
                [self showAlertViewWithMessage:@"分享成功" title:nil tag:0 delegate:nil leftBtnStr:@"确定" rightBtnStr:nil
                 ];
            }
        }];
    }else if (indexPath.row == 1){
        //微信朋友圈
        //1、创建分享参数（必要）
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        // 定制微信好友的分享内容
        if (self.isArticle) {
            strUrl = self.urlStr;
            strText = self.textStr;
            strTitle = self.titleStr;
        }else{
            strText = @"如果您是即将步入婚礼殿堂的新的，那就快到我们婚博士的碗里来吧，我们期待您的到来...";
            strUrl = @"http://www.hunboshi.com.cn/index.php?app=phone&act=invite";
            strTitle = @"婚博士-贴身婚礼管家";
        }

        [shareParams SSDKSetupWeChatParamsByText:strText title:strTitle url:[NSURL URLWithString:strUrl] thumbImage:nil image:[UIImage imageNamed:@"LOGO"] musicFileURL:nil extInfo:nil fileData:nil emoticonData:nil type:SSDKContentTypeAuto forPlatformSubType:SSDKPlatformSubTypeWechatTimeline];
        //3.朋友圈分享
        [ShareSDK share:SSDKPlatformSubTypeWechatTimeline parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity,  NSError *error) {
            if (state==1) {
                [self showAlertViewWithMessage:@"分享成功" title:nil tag:0 delegate:nil leftBtnStr:@"确定" rightBtnStr:nil
                 ];
            }
        }];
    }else if (indexPath.row == 2){
        //QQ好友
        //1、创建分享参数（必要）
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        // 定制QQ好友的分享内容
        if (self.isArticle) {
            strUrl = self.urlStr;
            strText = self.textStr;
            strTitle = self.titleStr;
        }else{
            strText = @"如果您是即将步入婚礼殿堂的新的，那就快到我们婚博士的碗里来吧，我们期待您的到来...";
            strUrl = @"http://www.hunboshi.com.cn/index.php?app=phone&act=invite";
            strTitle = @"婚博士-贴身婚礼管家";
        }
        [shareParams SSDKSetupQQParamsByText:strText title:strTitle url:[NSURL URLWithString:strUrl]  thumbImage:nil image:[UIImage imageNamed:@"LOGO"] type:SSDKContentTypeAuto forPlatformSubType:SSDKPlatformSubTypeQQFriend];
        //2、分享
        [ShareSDK share:SSDKPlatformSubTypeQQFriend parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity,  NSError *error) {
            if (state==1) {
                [self showAlertViewWithMessage:@"分享成功" title:nil tag:0 delegate:nil leftBtnStr:@"确定" rightBtnStr:nil
                 ];
            }
        }];
        
    }else if (indexPath.row == 3){
        
        //QQ空间
        //1、创建分享参数（必要）
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        // 定制QQ好友的分享内容
        if (self.isArticle) {
            strUrl = self.urlStr;
            strText = self.textStr;
            strTitle = self.titleStr;
        }else{
            strText = @"如果您是即将步入婚礼殿堂的新的，那就快到我们婚博士的碗里来吧，我们期待您的到来...";
            strUrl = @"http://www.hunboshi.com.cn/index.php?app=phone&act=invite";
            strTitle = @"婚博士-贴身婚礼管家";
        }

        [shareParams SSDKSetupQQParamsByText:strText title:strTitle url:[NSURL URLWithString:strUrl] thumbImage:nil image:[UIImage imageNamed:@"LOGO"] type:SSDKContentTypeAuto forPlatformSubType:SSDKPlatformSubTypeQZone];
        //2、分享
        [ShareSDK share:SSDKPlatformSubTypeQZone parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity,  NSError *error) {
            if (state==1) {
                [self showAlertViewWithMessage:@"分享成功" title:nil tag:0 delegate:nil leftBtnStr:@"确定" rightBtnStr:nil
                 ];
            }
        }];
        
    }else{
        
        //新郎微博
        //1、创建分享参数（必要）
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        // 定制QQ好友的分享内容
        if (self.isArticle) {
            strUrl = self.urlStr;
            strText = self.textStr;
            strTitle = self.titleStr;
        }else{
            strText = @"如果您是即将步入婚礼殿堂的新的，那就快到我们婚博士的碗里来吧，我们期待您的到来...";
            strUrl = @"http://www.hunboshi.com.cn/index.php?app=phone&act=invite";
            strTitle = @"婚博士-贴身婚礼管家";
        }
        
        [shareParams SSDKSetupSinaWeiboShareParamsByText:strText title:strTitle image:[UIImage imageNamed:@"LOGO"] url:[NSURL URLWithString:strUrl] latitude:30.01f longitude:120.58f objectID:nil type:SSDKContentTypeAuto];
        [ShareSDK share:SSDKPlatformTypeSinaWeibo parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
            if (state==1) {
                [self showAlertViewWithMessage:@"分享成功" title:nil tag:0 delegate:nil leftBtnStr:@"确定" rightBtnStr:nil
                 ];
            }
            
        }];
        
    }
}

#pragma mark----箭头image返回方法
- (void)clickImage{
    
    [self.navigationController popViewControllerAnimated:YES];

}
@end
