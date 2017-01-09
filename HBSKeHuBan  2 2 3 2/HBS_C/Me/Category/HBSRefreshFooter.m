
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
    [self setTitle:@"老沈啊 别加载了， 已经到底了" forState:MJRefreshStateNoMoreData];
    
}

@end
