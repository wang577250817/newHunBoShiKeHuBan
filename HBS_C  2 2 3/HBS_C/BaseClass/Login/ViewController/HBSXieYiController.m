//
//  HBSXieYiController.m
//  HBS_C
//
//  Created by 王 世江 on 16/10/20.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSXieYiController.h"

@interface HBSXieYiController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *xieYIWeb;
@property (weak, nonatomic) IBOutlet UIImageView *leftImage;

@end

@implementation HBSXieYiController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BAISE;
    [self.xieYIWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.0.82/h5/index.php?app=service&act=fwxyforapp"]]];
    
    UITapGestureRecognizer *tapImage = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImage)];
    [self.leftImage addGestureRecognizer:tapImage];
}
- (void)clickImage{
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
