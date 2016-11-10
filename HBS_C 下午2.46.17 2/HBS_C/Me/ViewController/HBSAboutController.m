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
@property (strong, nonatomic) IBOutlet UIImageView *leftImage;
@property (nonatomic, retain)UIActivityIndicatorView *activity;

@end

@implementation HBSAboutController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BAISE;
    self.webView.delegate = self;
    self.webView.backgroundColor = BAISE;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.hunboshi.com.cn/index.php?app=phone&act=about_hbers"]]];
    //创建小菊花
    self.activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activity.center =self.view.center;
    [self.view addSubview:self.activity];
    
    UITapGestureRecognizer *tapImage = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImage)];
    [self.leftImage addGestureRecognizer:tapImage];
    
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
