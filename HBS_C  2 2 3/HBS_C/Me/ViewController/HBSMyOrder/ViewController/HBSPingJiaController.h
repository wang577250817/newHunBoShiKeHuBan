//
//  HBSPingJiaController.h
//  HBS_C
//
//  Created by 王 世江 on 16/11/18.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ReloadBlock)(NSString *isFresh);
@interface HBSPingJiaController : BaseViewController

@property (nonatomic, copy)ReloadBlock reloadBlock;
- (void)returnText:(ReloadBlock)block;

@property (nonatomic, strong) NSString *pingID;
@property (nonatomic, strong) NSString *pingComment;
@property (nonatomic, strong) NSString *pingAttitude;
@property (nonatomic, strong) NSString *pingAppearance;
@property (nonatomic, strong) NSString *pingLanguage;
@end
