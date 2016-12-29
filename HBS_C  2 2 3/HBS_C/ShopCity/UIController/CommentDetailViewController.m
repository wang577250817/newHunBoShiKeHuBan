//
//  WZWWebViewController.m
//  Dr.hun
//
//  Created by wangzuowen on 16/8/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CommentDetailViewController.h"
#import "LPlaceholderTextView.h"
#import <WebKit/WebKit.h>

@interface CommentDetailViewController ()<WKNavigationDelegate, UITextViewDelegate>
{
    float spaceBetweenTextViewWithParentView;
}
@property (nonatomic, retain)WKWebView *webView;
@property (nonatomic, retain)UIActivityIndicatorView *activity;
@property (nonatomic, strong)LPlaceholderTextView *textView;
@property (nonatomic, strong)UIButton *sendButton;
@property (nonatomic, strong)UIView *backview;
@property (nonatomic, strong)UIButton *shareButton;

@end

@implementation CommentDetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
}
- (void)dealloc
{
    _webView.navigationDelegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BAISE;
    self.title = @"话题详情";
    
    self.shareButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    self.shareButton.frame = CGRectMake(WIDTH - 35, 10, 20, 20);
    [self.shareButton addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
//    self.shareButton.image = @"icon_fenicng@2x";
    [_shareButton setTitle:@"分享" forState:UIControlStateNormal];
    
    UIBarButtonItem *sendButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.shareButton];
    self.navigationItem.rightBarButtonItem = sendButtonItem;
    
    [self creatWebView];
    
    UITapGestureRecognizer *swipe = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(swipeClic:)];
    //    [swipe setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.webView addGestureRecognizer:swipe];
        
    [self creatCommentTextField];
}
- (void)leftAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)shareAction
{
//    shareListViewController *shareVC = [[shareListViewController alloc] init];
//    shareVC.isArticle = YES;
//    shareVC.titleStr = @"婚博士婚吧-说说结婚那些事儿";
//    shareVC.urlStr = self.urlStr;
//    shareVC.textStr = self.titleStr;
//    [self.navigationController pushViewController:shareVC animated:YES];
}
- (void)creatWebView
{
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    self.webView.navigationDelegate = self;
    self.webView.opaque = NO;
    self.webView.backgroundColor = [UIColor whiteColor];
    //    self.webView.opaque = NO; //不设置这个值 页面背景始终是白色
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:self.urlStr]];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
    
}
#pragma mark - 回复框
- (void)creatCommentTextField
{
    self.backview = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT - 50, WIDTH, 50)];
    self.backview.backgroundColor = BAISE;
    [self.view addSubview:self.backview];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 1)];
    label.backgroundColor = FENSE;
    label.alpha = 0.4;
    [self.backview addSubview:label];
    
    self.textView = [[LPlaceholderTextView alloc] initWithFrame:CGRectMake(10,10, WIDTH - 50, 30)];
    self.textView.layer.cornerRadius = 10;
    self.textView.layer.masksToBounds = YES;
    self.textView.backgroundColor = RANDOMCOLOR(243, 243, 244);
    _textView.delegate=self;
    _textView.textColor = HEISE;
    _textView.placeholderText = @"您的评论会让楼主更加有动力";
    _textView.placeholderColor = RANDOMCOLOR(153, 153, 153);
    spaceBetweenTextViewWithParentView = 5.0;
    _textView.returnKeyType = UIReturnKeyDone;
    [self.backview addSubview:self.textView];
    
    self.sendButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.sendButton.frame = CGRectMake(WIDTH - 35, 10, 30, 30);
    [self.sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [self.sendButton setTitleColor:LANSE forState:UIControlStateNormal];
    self.sendButton.titleLabel.font = FONT(13);
    
    [self.sendButton addTarget:self action:@selector(sendContent) forControlEvents:UIControlEventTouchUpInside];
    [self.backview addSubview:self.sendButton];
    
    //    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    //    [topView setBarStyle:UIBarStyleBlack];
    
    //    UIBarButtonItem * helloButton = [[UIBarButtonItem alloc]initWithTitle:@"Hello" style:UIBarButtonItemStyleBordered target:self action:nil];
    //
    //    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    //
    //    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
    //
    //    NSArray * buttonsArray = [NSArray arrayWithObjects:helloButton,btnSpace,doneButton,nil];
    //
    //    [topView setItems:buttonsArray];
    //    [_textView setInputAccessoryView:topView];
    
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
-(void)textViewDidChange:(UITextView *)textView
{
    
    //     UIFont* font =[UIFont systemFontOfSize:25.0];
    ////    CGSize size = [text boundingRectWithSize:CGSizeMake(320, 200)
    ////                                     options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin
    ////                                  attributes:@{NSFontAttributeName:font}
    ////                                     context:nil].size;
    ////    NSLog(@"%@",NSStringFromCGSize(textView.contentSize)) ;
    //    int numberLines = textView.contentSize.height/font.lineHeight;
    //     NSLog(@"%f,%d",startY,numberLines);
    //    float y = startY - height*(numberLines - 1);
    //    textView.frame=CGRectMake(0, y, 320, height*numberLines);
    
    CGFloat fixedWidth = _textView.frame.size.width;
    CGSize newSize = [_textView sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    CGRect newFrame = _textView.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    if (self.textView.frame.size.height >= 50) {
        return;
    }else{
        newFrame = CGRectMake(10, self.backview.frame.size.height - newFrame.size.height-spaceBetweenTextViewWithParentView, newFrame.size.width , newFrame.size.height);
        _textView.frame=newFrame;
    }
    
}
- (void)sendContent
{
    if ([self.textView.text isEqualToString:@""]) {
        
        [self.textView resignFirstResponder];
        return;
    }
    if ([self checkWIFI]) {
        if ([ProjectCache isLogin]) {
            NSDictionary *dic = @{@"sId":[ProjectCache getLoginMessage][@"user_id"],
                                  @"token":[ProjectCache getLoginMessage][@"user_token"],
                                  @"content":self.textView.text,};
            [HBSNetWork postUrl:[NSString stringWithFormat:@"%@article/%@/reply", HBSNetAdress, self.articleId] parame:dic header:@"dcx" cookie:nil result:^(id result) {
                if ([result[@"code"] integerValue] == 200) {
                    self.textView.text = nil;
                    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:self.urlStr]];
                    [self.webView loadRequest:request];
                }else{
                    [self creatAlertViewOne:result[@"message"] message:nil sureStr:@"确定" sureAction:^(id result) {
                        
                    }];
                }
            }];
        }else{
            [self presentViewController:[[HBSLoginController alloc] init] animated:YES completion:^{
                
            }];
        }
    }else{
        [self noNetWorkView:self.view];
    }
}

#pragma mark-滑动手势
-(void)swipeClic:(UITapGestureRecognizer *)swipe
{
    [self.navigationController popViewControllerAnimated:YES];
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
