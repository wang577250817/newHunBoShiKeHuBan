//
//  TextAdapter.m
//  HBS_C
//
//  Created by wangzuowen on 16/9/10.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "TextAdapter.h"

@implementation TextAdapter

// 自适应高度
+ (CGFloat)HeightWithText:(NSString *)text width:(CGFloat)width font:(CGFloat)font
{
    CGSize size = CGSizeMake(width, HEIGHT);
    NSDictionary *dic = @{NSFontAttributeName: [UIFont systemFontOfSize:font]};
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    
    return rect.size.height;
}

+ (CGFloat)WidthtWithText:(NSString *)text height:(CGFloat)height font:(CGFloat)font
{
    CGSize size = CGSizeMake(WIDTH, height);
    NSDictionary *dic = @{NSFontAttributeName: [UIFont systemFontOfSize:font]};
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.width;
}
@end
