


//
//  HBSFooterView.m
//  HBS_C
//
//  Created by 王 世江 on 16/11/10.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSFooterView.h"

@interface HBSFooterView ()
@property (nonatomic, strong) UILabel *buyManLabel;//买家留言

@end


@implementation HBSFooterView
#pragma mark----初始化
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    
    return self;
    
}
#pragma mark----布局
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
}
#pragma mark----赋值
- (void)setGoodFooterDic:(NSMutableDictionary *)goodFooterDic{
    
    _goodFooterDic = goodFooterDic;
    
}
@end
