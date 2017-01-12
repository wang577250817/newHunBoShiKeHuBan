
//
//  HBSRefreshFooter.m
//  HBS_C
//
//  Created by 王 世江 on 17/1/9.
//  Copyright © 2017年 wangzuowen. All rights reserved.
//

#import "HBSRefreshFooter.h"

@implementation HBSRefreshFooter

- (void)prepare{
    
    [super prepare];
    [self setTitle:@"亲* 别在往下拉了 我是有底线的哦" forState:MJRefreshStateNoMoreData];
    
}

@end
