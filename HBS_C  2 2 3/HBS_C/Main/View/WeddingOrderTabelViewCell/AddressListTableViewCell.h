//
//  AddressListTableViewCell.h
//  HBS_C
//
//  Created by wangzuowen on 16/11/7.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainModel.h"

@interface AddressListTableViewCell : UITableViewCell

@property (nonatomic, strong)MainModel *model;

@property (nonatomic, strong)UIButton *roundImage;
@property (nonatomic, strong)UIButton *rightImage;

@end
