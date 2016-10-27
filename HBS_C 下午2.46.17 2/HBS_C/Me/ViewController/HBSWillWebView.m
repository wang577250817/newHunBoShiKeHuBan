//
//  HBSWillWebView.m
//  HBS_C
//
//  Created by 王 世江 on 16/10/27.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSWillWebView.h"

@interface HBSWillWebView ()<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *leftImage;//返回image
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, retain)UIActivityIndicatorView *activity;//加载图
@end

@implementation HBSWillWebView
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BAISE;
    [self setUpChildControls];
    
    
}
#pragma mark----设置子控件
- (void)setUpChildControls{
    
    self.webView.delegate = self;
    self.webView.backgroundColor = BAISE;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.hunboshi.com.cn/index.php?app=phone&act=compay_reg"]]];
    //创建小菊花
    self.activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activity.center =self.view.center;
    [self.view addSubview:self.activity];
    
    //返回箭头
    UITapGestureRecognizer *tapImage = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImage)];
    [self.leftImage addGestureRecognizer:tapImage];
    
    
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.activity startAnimating];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activity stopAnimating];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.activity stopAnimating];
}
#pragma mark----箭头image返回方法
- (void)clickImage{
    
    [self.navigationController popViewControllerAnimated:YES];
    [self.tabBarController.tabBar setHidden:NO];
}

@end
