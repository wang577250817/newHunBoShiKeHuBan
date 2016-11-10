//
//  HBSCachesHandle.h
//  HBS_C
//
//  Created by 王 世江 on 16/10/23.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HBSCachesHandle : NSObject

@property (nonatomic, assign) float fileSize;

+ (instancetype)shareCachesHandle;

-(void)myClearCacheAction;
- (float)folderSizeAtPath:(NSString *)folderPath;
- (long long)fileSizeAtPath:(NSString *)filePath;

@end
