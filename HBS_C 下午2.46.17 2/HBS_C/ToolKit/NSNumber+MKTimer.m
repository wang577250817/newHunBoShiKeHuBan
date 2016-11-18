//
//  NSNumber+MKTimer.m
//  what2
//
//  Created by 李亚洲 on 15/10/26.
//  Copyright © 2015年 MK. All rights reserved.
//

#import "NSNumber+MKTimer.h"

@implementation NSNumber (MKTimer)


+(NSString*)TimeformatFromSeconds:(NSInteger)seconds
{
    NSString *day = @"";
        day = [NSString stringWithFormat:@"%02ld",seconds/(60*60*24)];
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",(seconds - [day integerValue] * 60 * 60 * 24) / 3600];
    
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    //format of second
//    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    //format of time
    NSString *format_time = @"";
    if ([day isEqualToString:@"00"]) {
        format_time = [NSString stringWithFormat:@"%@小时%@分钟",str_hour,str_minute];
    }else if ([str_hour isEqualToString:@"00"]){
        format_time = [NSString stringWithFormat:@"%@分钟",str_minute];
    }
    else{
        format_time = [NSString stringWithFormat:@"%@天%@小时%@分钟",day,str_hour,str_minute];
    }
    
    return format_time;
}
//时间格式转化
- (NSString *)transformToMMDD
{
    if (!self) {
        return @"";
    }
    NSTimeInterval timeInterval = [self longLongValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSString *dataString = @"";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeInterval delta = [[NSDate date] timeIntervalSinceDate:date];
    if (delta < 60) { // 1分钟以内
        dataString = @"1分钟前";
    } else if (delta < 60 * 60) { // 60分钟以内
        dataString = [NSString stringWithFormat:@"%d分钟前", (int)delta/60];
    } else if (delta < 60 * 60 * 24) { // 24小时内
        dataString = [NSString stringWithFormat:@"%d小时前", (int)delta/(60 * 60)];
    } else if (delta < 60 * 60 * 24 * 2) { // 昨天
        dataString = [NSString stringWithFormat:@"昨天"];
    }
//    else if (delta < 60 * 60 * 24 * 10){   // 10天以内 {
//        dataString = [NSString stringWithFormat:@"%d天前", (int)delta/(60 * 60 * 24)];
//        
//    }
    else {
        //        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
        formatter.dateFormat = @"MM月/dd日";
        dataString = [formatter stringFromDate:date];
    }
    return dataString;
}

+ (NSString *)DuoshaoshijianHou:(NSInteger)time
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSString *dataString = @"";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"dd日HH小时";
    
    dataString = [formatter stringFromDate:date];
    
    return dataString;
}
- (NSString *)transformTotimeNow
{
    if (!self) {
        return @"";
    }
    NSTimeInterval timeInterval = [self longLongValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSString *dataString = @"";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeInterval delta = [[NSDate date] timeIntervalSinceDate:date];
    delta = delta * -1;
    if (delta < 60) { // 1分钟以内
        dataString = @"1分钟";
        
    } else if (delta < 60 * 60) { // 60分钟以内
        dataString = [NSString stringWithFormat:@"%d分钟", (int)delta/60];
    } else if (delta < 60 * 60 * 24) { // 24小时内
        dataString = [NSString stringWithFormat:@"%d小时", (int)delta/(60 * 60)];
    } else if (delta < 60 * 60 * 24 * 2) { // 昨天
        dataString = [NSString stringWithFormat:@"昨天"];
    } else if (delta < 60 * 60 * 24 * 10){   // 10天以内 {
        dataString = [NSString stringWithFormat:@"%d天", (int)delta/(60 * 60 * 24)];
    } else {
        //        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
        formatter.dateFormat = @"dd日/HH小时";
        dataString = [formatter stringFromDate:date];
        
    }
    return dataString;
}

- (NSString *)transformToTimerString
{
    if (!self) {
        return @"";
    }
    NSTimeInterval timeInterval = [self longLongValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSString *dataString = @"";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeInterval delta = [date timeIntervalSinceDate:[NSDate date]];
    if (delta < 60) { // 1分钟以内
        dataString = @"1分钟内";
    } else if (delta < 60 * 60) { // 60分钟以内
        dataString = [NSString stringWithFormat:@"%d分钟后", (int)delta/60];
    } else if (delta < 60 * 60 * 24) { // 24小时内
        dataString = [NSString stringWithFormat:@"%d小时后", (int)delta/(60 * 60)];
    } else if (delta < 60 * 60 * 24 * 2) { // 昨天
        dataString = [NSString stringWithFormat:@"明天"];
    } else if (delta < 60 * 60 * 24 * 10){   // 10天以内 {
        dataString = [NSString stringWithFormat:@"%d天后", (int)delta/(60 * 60 * 24)];
    } else {
        //        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
        formatter.dateFormat = @"MM月/dd日";
        dataString = [formatter stringFromDate:date];
        
    }
    return dataString;
}

- (NSString *)formatterDDHHMM
{
    NSTimeInterval timeInterval = [self longLongValue] / 1000000000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    timeFormatter.dateFormat = @"MM月dd日 HH:mm";
    return [timeFormatter stringFromDate:date];
}

- (BOOL)checkDateSetting24Hours{
    BOOL is24Hours = YES;
    NSString *dateStr = [[NSDate date] descriptionWithLocale:[NSLocale currentLocale]];
    NSArray  *sysbols = @[[[NSCalendar currentCalendar] AMSymbol],[[NSCalendar currentCalendar] PMSymbol]];
    for (NSString *symbol in sysbols) {
        if ([dateStr rangeOfString:symbol].location != NSNotFound) {//find
            is24Hours = NO;
            break;
        }
    }
    return is24Hours;
}
@end
