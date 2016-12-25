//
//  HBSMyCarHeaderModel.h
//  HBS_C
//
//  Created by 王 世江 on 16/11/11.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HBSMyCarHeaderModel : NSObject

@property (nonatomic, assign) BOOL isSelect;
@property (nonatomic, copy) NSString *store_name;//店名
@property (nonatomic, strong) NSMutableArray *goods;//商品数组

@end
