//
//  HBSCachesHandle.m
//  HBS_C
//
//  Created by 王 世江 on 16/10/23.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSCachesHandle.h"

@implementation HBSCachesHandle

+ (instancetype)shareCachesHandle
{
    static HBSCachesHandle *cachesHandle = nil;
    if (cachesHandle == nil) {
        cachesHandle = [[HBSCachesHandle alloc] init];
    }
    return cachesHandle;
}

-(void)myClearCacheAction
{
    dispatch_async(
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                   , ^{
                       NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                       
                       self.fileSize = [self folderSizeAtPath:cachPath];
                       
                       NSLog(@"111111aaaa%@",[NSString stringWithFormat:@"%.2fMB",self.fileSize]);
                       
                       NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
                       
                       NSLog(@"files :%lu",(unsigned long)[files count]);
                       
                       for (NSString *p in files) {
                           NSError *error;
                           NSString *path = [cachPath stringByAppendingPathComponent:p];
                           if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                               [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                           }
                       }
                       [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];});
}
-(void)clearCacheSuccess
{
    NSLog(@"清理成功");
}

- (float)folderSizeAtPath:(NSString *)folderPath
{
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) {
        return 0;
    }
    float folderSize = 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    
    NSString *fileName = nil;
    
    while ((fileName = [childFilesEnumerator nextObject]) != nil) {
        NSString *fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize / (1024.0 * 1024.0);
    
}

- (long long)fileSizeAtPath:(NSString *)filePath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
    
}



@end
