//
//  ProjectCache.h
//  HBS_C
//
//  Created by wangzuowen on 16/9/18.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ProjectCache : NSObject

+ (void)saveLoginMessage:(id)object;
+ (NSDictionary *)getLoginMessage;
+ (void)deleteLoginMessage;
+ (void)saveLoginNameAndPassWord:(NSString *)name passWord:(NSString *)passWord;
+ (NSDictionary *)getLoginNameAndPassWord;
+ (BOOL)isLogin;
+(void)loginOut;

+(NSString*)DataTOjsonString:(id)object;

@end
