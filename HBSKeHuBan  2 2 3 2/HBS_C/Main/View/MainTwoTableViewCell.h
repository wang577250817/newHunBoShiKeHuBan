//
//  MainTwoTableViewCell.h
//  HBS_C
//
//  Created by wangzuowen on 16/10/14.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainModel.h"

@interface MainTwoTableViewCell : UITableViewCell

@property (nonatomic, strong)UIImageView *imgView;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UIImageView *backImage;
@property (nonatomic, strong)MainModel *model;

@end
