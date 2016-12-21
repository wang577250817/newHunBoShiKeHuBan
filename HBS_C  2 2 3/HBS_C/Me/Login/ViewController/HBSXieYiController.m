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
@property (nonatomic, strong) UIButton *leftBtn;

@end

@implementation HBSXieYiController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HEISE;
    [self.xieYIWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"%@h5/index.php?app=service&act=fwxyforapp"]]];
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.leftBtn.frame = CGRectMake(0, 20, 30, 35);
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_fanhuijiantou"] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(clickImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.leftBtn];
    
}
- (void)clickImage{
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
