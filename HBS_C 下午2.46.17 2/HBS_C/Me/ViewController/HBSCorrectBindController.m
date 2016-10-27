//
//  HBSCorrectBindController.m
//  HBS_C
//
//  Created by 王 世江 on 16/10/27.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSCorrectBindController.h"

@interface HBSCorrectBindController ()

@property (strong, nonatomic) IBOutlet UIImageView *leftImage;
@end

@implementation HBSCorrectBindController

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
    
    
}
#pragma mark----箭头image返回方法
- (void)clickImage{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
