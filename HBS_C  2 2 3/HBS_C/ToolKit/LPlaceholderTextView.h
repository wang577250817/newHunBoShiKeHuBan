//
//  Created by Luka Gabrić.
//  Copyright (c) 2013 Luka Gabrić. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "MyLabel.h"

@interface LPlaceholderTextView : UITextView
{
    MyLabel *_placeholderLabel;
}


@property (strong, nonatomic) NSString *placeholderText;
@property (strong, nonatomic) UIColor *placeholderColor;
- (void)shiquxiangying;
- (void)topShow;
@end