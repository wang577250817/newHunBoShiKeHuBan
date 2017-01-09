//
//  WebWithUrlViewController.m
//  HBS_C
//
//  Created by wangzuowen on 16/11/3.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "WebWithUrlViewController.h"
#import <WebKit/WebKit.h>

#import "WeddingDetailViewController.h"
#import "ShopDetailViewController.h"

@interface WebWithUrlViewController ()<WKNavigationDelegate>

@property (nonatomic, strong)WKWebView *webView;

@end

@implementation WebWithUrlViewController

@synthesize title;

-(void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"title"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (title) {
        TITLE = title;
    }else{
        
    }
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64)];
    self.webView.navigationDelegate = self;
    self.webView.opaque = NO;
    self.webView.backgroundColor = [UIColor whiteColor];
    //    self.webView.opaque = NO; //不设置这个值 页面背景始终是白色
    
    [self.view addSubview:self.webView];
    [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    if ([self checkWIFI]) {
        NSURLRequest * request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:self.urlWithString]];
        [self.webView loadRequest:request];
        
    }else{
        self.webView.userInteractionEnabled = NO;
        if (!self.errorImage) {
            
            [self noNetWorkView:self.view];
        }
        self.errorImage.userInteractionEnabled = YES;
        __weak typeof(self)weakself = self;
        self.freshBlock = ^(void){
            NSURLRequest * request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:weakself.urlWithString]];
            [weakself.webView loadRequest:request];
        };

    }
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"title"])
    {
        if (object == self.webView) {
            TITLE = self.webView.title;
        }else
        {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
            
        }
    }
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    
    NSString *str = navigationAction.request.URL.relativeString;
    if ([str rangeOfString:@"hunboshi"].location != NSNotFound) {
        if ([str rangeOfString:@"tel"].location != NSNotFound){
            decisionHandler(WKNavigationActionPolicyCancel);
            [phoneViewController call:[str substringFromIndex:4] inViewController:self failBlock:^{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"拨打失败" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *defult = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:defult];
                [self presentViewController:alert animated:YES completion:^{
                }];
            }];
            return;
        }
        
        NSArray *arr1 = [str componentsSeparatedByString:@"?"];
        NSArray *arr2 = [arr1[1] componentsSeparatedByString:@"&"];
        
        if ([str rangeOfString:@"h5=0"].location == NSNotFound) {
            
            decisionHandler(WKNavigationActionPolicyAllow);
            
        }else{
            
            if ([arr1[1] rangeOfString:@"app=goodspro"].location != NSNotFound) {
                decisionHandler(WKNavigationActionPolicyCancel);
                if([arr1[1] rangeOfString:@"service"].location != NSNotFound){
                    decisionHandler(WKNavigationActionPolicyCancel);
                    WeddingDetailViewController *fwVC = [[WeddingDetailViewController  alloc] init];
                    NSString *str = [NSString stringWithFormat:@"%@", arr2[1]];
                    fwVC.goods_id = [str substringFromIndex:3];
                    fwVC.type = DetailTypeGoods;
                    [self.navigationController pushViewController:fwVC animated:YES];
                }else if ([arr1[1] rangeOfString:@"material"].location != NSNotFound){
                    WeddingDetailViewController *fwVC = [[WeddingDetailViewController  alloc] init];
                    NSString *str = [NSString stringWithFormat:@"%@", arr2[1]];
                    fwVC.goods_id = [str substringFromIndex:3];
                    fwVC.type = DetailTypeWedding;
                    [self.navigationController pushViewController:fwVC animated:YES];
                }else if ([arr1[1] rangeOfString:@"case"].location != NSNotFound){
                    decisionHandler(WKNavigationActionPolicyCancel);
                    WeddingDetailViewController *fwVC = [[WeddingDetailViewController  alloc] init];
                    NSString *str = [NSString stringWithFormat:@"%@", arr2[1]];
                    fwVC.goods_id = [str substringFromIndex:3];
                    fwVC.type = DetailTypeCase;
                    [self.navigationController pushViewController:fwVC animated:YES];
                }
            }else if ([arr1[1] rangeOfString:@"app=store"].location != NSNotFound){
                decisionHandler(WKNavigationActionPolicyCancel);
                if ([arr1[1] rangeOfString:@"service"].location != NSNotFound || [arr1[1] rangeOfString:@"goods"].location != NSNotFound) {
                    decisionHandler(WKNavigationActionPolicyCancel);
                    ShopDetailViewController *fwVC = [[ShopDetailViewController  alloc] init];
                    NSString *str = [NSString stringWithFormat:@"%@", arr2[1]];
                    fwVC.story_id = [str substringFromIndex:3];
                    [self.navigationController pushViewController:fwVC animated:YES];
                }
            }else{
                decisionHandler(WKNavigationActionPolicyAllow);
            }
        }
        
    }else{
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    [self showLoadingViewWithMessage];
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [self removeLodingView];
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    [self removeLodingView];
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
