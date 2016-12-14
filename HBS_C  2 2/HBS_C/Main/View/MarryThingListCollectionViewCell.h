//
//  MarryThingListCollectionViewCell.h
//  HBS_C
//
//  Created by wangzuowen on 16/10/22.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainModel.h"

@interface MarryThingListCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong)MainModel *model;

@property (nonatomic, strong)UIImageView *imgView;
@property (nonatomic, strong)UILabel *priceLabel;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *priceMarketLabel;

@end
