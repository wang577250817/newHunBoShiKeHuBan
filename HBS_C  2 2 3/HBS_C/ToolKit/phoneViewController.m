//
//  phoneViewController.m
//  Dr.hun
//
//  Created by 王 世江 on 16/7/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "phoneViewController.h"

@interface phoneViewController ()

@property (nonatomic, strong) UIWebView *webView;
@end

@implementation phoneViewController

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
    
    phoneViewController *mediaVC = [[phoneViewController alloc]init];
    [vc addChildViewController:mediaVC];
    mediaVC.view.frame = CGRectZero;
    mediaVC.view.alpha = .0f;
    
    [vc.view addSubview:mediaVC.view];
    
    // 打电话
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [mediaVC.webView loadRequest:request];
}
- (void)dealloc{
    
    self.webView = nil;
//    NSLog(@"CoreMediaFuncManagerVC被释放");
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
