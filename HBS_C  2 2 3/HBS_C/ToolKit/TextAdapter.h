//
//  TextAdapter.h
//  HBS_C
//
//  Created by wangzuowen on 16/9/10.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextAdapter : NSObject

+ (CGFloat)HeightWithText:(NSString *)text width:(CGFloat)width font:(CGFloat)font;
+ (CGFloat)WidthtWithText:(NSString *)text height:(CGFloat)height font:(CGFloat)font;

@end
