//
//  MarryThingListCollectionViewCell.m
//  HBS_C
//
//  Created by wangzuowen on 16/10/22.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "MarryThingListCollectionViewCell.h"

@interface MarryThingListCollectionViewCell()

@property (nonatomic, strong)UILabel *lineLabel;

@end
@implementation MarryThingListCollectionViewCell

@synthesize imgView, priceLabel, titleLabel, priceMarketLabel;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        imgView = [[UIImageView alloc] init];
        imgView.userInteractionEnabled = NO;
        [self.contentView addSubview:imgView];
        
        titleLabel = [[UILabel alloc] init];
        titleLabel.font = FONT(14);
        titleLabel.textColor = HEISE;
        [self.contentView addSubview:titleLabel];
        
        priceLabel = [[UILabel alloc] init];
        priceLabel.textColor = FENSE;
        priceLabel.font = FONT(15);
        [self.contentView addSubview:priceLabel];
        
        priceMarketLabel = [[UILabel alloc] init];
        priceMarketLabel.font = FONT(15);
        priceMarketLabel.textColor = yiwusanColor;
        [self.contentView addSubview:priceMarketLabel];
        
        _lineLabel = [[UILabel alloc] init];
        _lineLabel.backgroundColor = yiwusanColor;
        [self.contentView addSubview:_lineLabel];

    }
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(170 * WSHIPEI, 170 * HSHIPEI));
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imgView.mas_left);
        make.top.mas_equalTo(imgView.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(self.contentView.width, 20));
    }];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imgView.mas_left);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake((self.contentView.width - 10) / 2, 20));
    }];
    [priceMarketLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(priceLabel.mas_right).offset(10);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake((self.contentView.width - 10) / 2, 20));
    }];
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(priceLabel.mas_right).offset(10);
        make.top.mas_equalTo(priceMarketLabel.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake((self.contentView.width - 10) / 2 - 10, 1));
    }];
}
- (void)setModel:(MainModel *)model
{
    if (_model != model) {
        _model = model;
    }
    [imgView sd_setImageWithURL:WZWURLWithString(model.goods_image) placeholderImage:ZHANWEI];
    titleLabel.text = model.goods_name;
    priceLabel.text = [NSString stringWithFormat:@"¥%@", model.goods_price];
    priceMarketLabel.text = [NSString stringWithFormat:@"¥%@", model.goods_price_market];
    
}
@end
