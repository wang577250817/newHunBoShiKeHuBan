//
//  HBSFooterView.h
//  HBS_C
//
//  Created by 王 世江 on 16/11/10.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HBSFooterView;

@protocol phoneCallDelegate <NSObject>

- (void)phoneCallDelegate:(HBSFooterView *)view WithclickPhone:(UIButton *)btn;

- (void)talkCallDelegate:(HBSFooterView *)view WithclickTalk:(UIButton *)btn;
//确认收货
- (void)sureGoodsDelegate:(HBSFooterView *)view withClickGood:(UIButton *)btn;

@end

@interface HBSFooterView : UIView
@property (nonatomic, strong) NSMutableDictionary *goodFooterDic;

@property (nonatomic, assign) id<phoneCallDelegate>delegate;

@end
