//
//  WZWModel.h
//  Dr.hun
//
//  Created by wangzuowen on 16/6/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WZWModel : NSObject

- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)baseModelWithDic:(NSDictionary *)dic;
+ (NSMutableArray *)transformWithArray:(NSArray *)array;

@end
