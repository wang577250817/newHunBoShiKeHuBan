//
//  HBSContactUsController.m
//  HBS_C
//
//  Created by 王 世江 on 16/10/27.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSContactUsController.h"

@interface HBSContactUsController ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation HBSContactUsController

- (instancetype)init{
    
    self = [super init];
    if (self) {
        _webView = [[UIWebView alloc]init];
    }
    
    return self;
}
- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    [self removeFromParentViewController];
    
}
+ (void)call:(NSString *)no inViewController:(UIViewController *)vc failBlock:(void (^)())failBlock{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", no]];
    BOOL canOpen = [[UIApplication sharedApplication]canOpenURL:url];
    if (!canOpen) {
        if (failBlock != nil) failBlock();return;
        
    }
    
    HBSContactUsController *mediaVC = [[HBSContactUsController alloc]init];
    [vc addChildViewController:mediaVC];
    mediaVC.view.frame = CGRectZero;
    mediaVC.view.alpha = .0f;
    
    [vc.view addSubview:mediaVC.view];
    
    //    打电话
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [mediaVC.webView loadRequest:request];
}
- (void)dealloc{
    
    self.webView = nil;
    NSLog(@"CoreMediaFuncManagerVC被释放");
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

@end
