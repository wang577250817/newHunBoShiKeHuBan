//
//  WZWModel.m
//  Dr.hun
//
//  Created by wangzuowen on 16/6/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "WZWModel.h"

@implementation WZWModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
+ (instancetype)baseModelWithDic:(NSDictionary *)dic
{
    //self calss是当前类本身
    id m = [[[self class] alloc] initWithDic:dic];
    return m;
}
+ (NSMutableArray *)transformWithArray:(NSArray *)array
{
    NSMutableArray *tempArr = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        @autoreleasepool {
            id m = [self baseModelWithDic:dic];
            [tempArr addObject:m];
        }
    }
    return tempArr;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
