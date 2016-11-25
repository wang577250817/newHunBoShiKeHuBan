//
//  HBSLPlaceholderTextView.h
//  HBS_C
//
//  Created by 王 世江 on 16/11/18.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HBSMyLabel.h"
@interface HBSLPlaceholderTextView : UITextView

{
    HBSMyLabel *_placeholderLabel;
}


@property (strong, nonatomic) NSString *placeholderText;
@property (strong, nonatomic) UIColor *placeholderColor;
- (void)shiquxiangying;
- (void)topShow;

@end
