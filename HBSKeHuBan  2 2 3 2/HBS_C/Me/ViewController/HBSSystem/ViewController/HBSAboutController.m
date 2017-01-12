//
//  HBSAboutController.m
//  HBS_C
//
//  Created by 王 世江 on 16/10/24.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSAboutController.h"

@interface HBSAboutController ()<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, retain)UIActivityIndicatorView *activity;
@property (nonatomic, strong) UIButton *leftBtn;
@end

@implementation HBSAboutController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BAISE;
    self.webView.delegate = self;
    self.webView.backgroundColor = BAISE;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.hunboshi.com.cn/storeH5/index.php?app=address&act=about"]]];
    //创建小菊花
    self.activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activity.center =self.view.center;
    [self.view addSubview:self.activity];
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.leftBtn.frame = CGRectMake(0, 20, 30, 35);
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_fanhuijiantou"] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(clickImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.leftBtn];
    
}
- (void)clickImage{
    
    [self.navigationController popViewControllerAnimated:YES];
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
@end
