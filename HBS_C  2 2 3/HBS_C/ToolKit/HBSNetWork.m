//
//  HBSNetWork.m
//  HBS_C
//
//  Created by wangzuowen on 16/10/17.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSNetWork.h"
#import "AFNetworking.h"

@implementation HBSNetWork

#pragma mark - GET网络请求
+ (void)getUrl:(NSString *)urlStr paramaters:(id)paramater header:(NSString *)header cookie:(NSString *)cookie Result:(JSONBLOCK)block {
    NSString *urlString = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if (cookie) {
        [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
    }
    [manager.requestSerializer setValue:header forHTTPHeaderField:@"token"];
    //设置返回数据格式
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil]];
    
    
    [manager GET:urlString parameters:paramater progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 如果请求成功, 回调请求到得数据, 同时在这里做本地缓存
        NSString *path = [NSString stringWithFormat:@"%ld.plist", (unsigned long)[urlStr hash]];
        NSString *path_doc = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        [NSKeyedArchiver archiveRootObject:responseObject toFile:[path_doc stringByAppendingPathComponent:path]];
        block(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 在这里读取本地缓存
        NSString *path = [NSString stringWithFormat:@"%ld.plist", (unsigned long)[urlStr hash]];
        NSString *path_doc = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        
        id result = [NSKeyedUnarchiver unarchiveObjectWithFile:[path_doc stringByAppendingPathComponent:path]];
        block(result);
    }];
}
+ (void)getUrl:(NSString *)urlStr cookie:(NSString *)cookie Result:(JSONBLOCK)block {
    NSString *urlString = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if (cookie) {
        [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
    }
    //设置返回数据格式
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil]];
    
    
    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 如果请求成功, 回调请求到得数据, 同时在这里做本地缓存
        NSString *path = [NSString stringWithFormat:@"%ld.plist", (unsigned long)[urlStr hash]];
        NSString *path_doc = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        [NSKeyedArchiver archiveRootObject:responseObject toFile:[path_doc stringByAppendingPathComponent:path]];
        block(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 在这里读取本地缓存
        NSString *path = [NSString stringWithFormat:@"%ld.plist", (unsigned long)[urlStr hash]];
        NSString *path_doc = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        
        id result = [NSKeyedUnarchiver unarchiveObjectWithFile:[path_doc stringByAppendingPathComponent:path]];
        block(result);
    }];
}
+ (void)getUrl1:(NSString *)urlStr cookie:(NSString *)cookie Result:(JSONBLOCK)block {
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if (cookie) {
        [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
    }
    
    //设置返回数据格式
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil]];
    
    [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
       
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 如果请求成功, 回调请求到得数据, 同时在这里做本地缓存
        NSString *path = [NSString stringWithFormat:@"%ld.plist", (unsigned long)[urlStr hash]];
        NSString *path_doc = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        [NSKeyedArchiver archiveRootObject:responseObject toFile:[path_doc stringByAppendingPathComponent:path]];
        block(responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 在这里读取本地缓存
        NSString *path = [NSString stringWithFormat:@"%ld.plist", (unsigned long)[urlStr hash]];
        NSString *path_doc = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        
        id result = [NSKeyedUnarchiver unarchiveObjectWithFile:[path_doc stringByAppendingPathComponent:path]];
        block(result);
    }];
}

#pragma mark - POST网络请求

+ (void)postUrl:(NSString *)url parame:(id)parame header:(NSString *)header cookie:(NSString *)cookie result:(JSONBLOCK)block
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //  manager.requestSerializer setValue:<#(nullable NSString *)#> forHTTPHeaderField:<#(nonnull NSString *)#>
    if (header) {
        [manager.requestSerializer setValue:header forHTTPHeaderField:@"token"];
    }
    // 接口带Cookie
    if (cookie) {
        [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
    }
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    //设置返回数据格式
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil]];
    
    [manager POST:url parameters:parame progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        block(responseObject);
        
    } failure:
    ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@"hbs_error");
    }];
}
+ (void)deleteUrl:(NSString *)url parame:(id)parame cookie:(NSString *)cookie result:(JSONBLOCK)block
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //  manager.requestSerializer setValue:<#(nullable NSString *)#> forHTTPHeaderField:<#(nonnull NSString *)#>
    
    // 接口带Cookie
    if (cookie) {
        [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
    }
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    //设置返回数据格式
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil]];
    
    [manager DELETE:url parameters:parame success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        block(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(error);
    }];
    
    
}
+ (void)putUrl:(NSString *)url parame:(id)parame header:(NSString *)header cookie:(NSString *)cookie result:(JSONBLOCK)block
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //  manager.requestSerializer setValue:<#(nullable NSString *)#> forHTTPHeaderField:<#(nonnull NSString *)#>
    // 接口带Cookie
    if (cookie) {
        [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
    }
    if (header) {
        [manager.requestSerializer setValue:header forHTTPHeaderField:@"token"];
    }
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    //设置返回数据格式
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil]];
    [manager PUT:url parameters:parame success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        block(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@"hbs_error");
        
    }];
}
@end
