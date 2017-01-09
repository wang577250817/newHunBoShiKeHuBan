//
//  ProjectCache.m
//  HBS_C
//
//  Created by wangzuowen on 16/9/18.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "ProjectCache.h"

@implementation ProjectCache

#pragma mark - 登陆注册
+ (void)saveLoginMessage:(id)object
{
    SetNSUserDefaults(object, @"LoginMessage");
}
+ (void)loginOut
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"LoginMessage"];
}
+ (NSDictionary *)getLoginMessage
{
    return GetNSUserDefaults(@"LoginMessage");
}
+ (void)deleteLoginMessage
{
    SetNSUserDefaults(nil, @"LoginMessage");

}
+ (void)saveLoginNameAndPassWord:(NSString *)name passWord:(NSString *)passWord
{
    NSDictionary *dic = @{@"name":name, @"passWord":passWord};
    SetNSUserDefaults(dic, @"LoginNameAndPassWord");
}
+ (NSDictionary *)getLoginNameAndPassWord
{
    return GetNSUserDefaults(@"LoginNameAndPassWord");
}
+ (BOOL)isLogin
{
    NSDictionary *dic = [self getLoginMessage];
    if (dic[@"user_id"]) {
        return YES;
    }else{
        return NO;
    }
}
#pragma mark - json
+(NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString ;
}
@end

