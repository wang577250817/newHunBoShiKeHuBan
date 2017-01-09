//
//  SCUserProfileEntity.h
//  Dr.hun
//
//  Created by wangzuowen on 16/7/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCUserProfileEntity : NSObject

//通过环信ID去保存昵称和头像url到本地
+ (void)saveUserProfileWithUsername:(NSString *)username forNickName:(NSString *)nickName avatarURLPath:(NSString *)avatarURLPath;

//通过环信ID取本地的昵称
+ (NSString *)getNickNameWithUsername:(NSString*)username;

//通过环信ID取本地的头像url
+ (NSString *)getavatarURLPathWithUsername:(NSString*)username;

//移除本地的头像昵称，清缓存
+ (void)removeUserProfileWithUsername:(NSString *)username;


@end
