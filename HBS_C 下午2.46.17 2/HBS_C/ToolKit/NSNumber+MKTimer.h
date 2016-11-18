//
//  NSNumber+MKTimer.h
//  what2
//
//  Created by 李亚洲 on 15/10/26.
//  Copyright © 2015年 MK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (MKTimer)
- (NSString *)transformToMMDD;
- (NSString *)transformToTimerString;

- (NSString *)formatterDDHHMM;
- (NSString *)transformTotimeNow;
+ (NSString *)DuoshaoshijianHou:(NSInteger)time;

+(NSString*)TimeformatFromSeconds:(NSInteger)seconds;

@end
