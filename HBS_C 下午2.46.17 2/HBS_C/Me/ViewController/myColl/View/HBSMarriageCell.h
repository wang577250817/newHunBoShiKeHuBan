//
//  HBSMarriageCell.h
//  HBS_C
//
//  Created by 王 世江 on 16/11/1.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HBSMarriageModel;
@interface HBSMarriageCell : UICollectionViewCell

@property (nonatomic, strong) HBSMarriageModel *marriageModel;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceMarketLabel;
@property (nonatomic, strong) UILabel *grayLabel;
@end
