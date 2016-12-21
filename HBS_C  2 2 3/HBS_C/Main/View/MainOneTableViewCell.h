//
//  MainOneTableViewCell.h
//  HBS_C
//
//  Created by wangzuowen on 16/10/14.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainOneTableViewCell : UITableViewCell

@property (nonatomic, strong)UIImageView *hlgjImageView;
@property (nonatomic, strong)UIImageView *bslImageView;
@property (nonatomic, strong)UIImageView *thpImageView;
@property (nonatomic, strong)UIImageView *hdzqImageView;

@property (nonatomic, strong)UIButton *hlgjButton;
@property (nonatomic, strong)UIButton *bslButton;
@property (nonatomic, strong)UIButton *thpButton;
@property (nonatomic, strong)UIButton *hdzqButton;

@property (nonatomic, strong)NSMutableArray *dataArr;

@end
