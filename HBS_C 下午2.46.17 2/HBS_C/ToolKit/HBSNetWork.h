//
//  HBSNetWork.h
//  HBS_C
//
//  Created by wangzuowen on 16/10/17.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^JSONBLOCK)(id result);
@interface HBSNetWork : NSObject
+ (void)getUrl:(NSString *)urlStr
        cookie:(NSString *)cookie
        Result:(JSONBLOCK)block;

+ (void)postUrl:(NSString *)url parame:(id)parame cookie:(NSString *)cookie result:(JSONBLOCK)block;
+ (void)getUrl1:(NSString *)urlStr cookie:(NSString *)cookie Result:(JSONBLOCK)block ;

@end
