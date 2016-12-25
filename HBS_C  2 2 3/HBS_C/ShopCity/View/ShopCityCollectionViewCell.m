//
//  ShopCityCollectionViewCell.m
//  HBS_C
//
//  Created by wangzuowen on 16/10/20.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "ShopCityCollectionViewCell.h"

@interface ShopCityCollectionViewCell()

@property (nonatomic, strong)UIImageView *imageV;
@property (nonatomic, strong)UILabel *titleLabel;

@end

@implementation ShopCityCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageV = [[UIImageView alloc] init];
        self.imageV.userInteractionEnabled = NO;
        self.imageV.layer.cornerRadius = 75 / 2 * WSHIPEI;
        self.imageV.layer.masksToBounds = YES;
        [self.contentView addSubview:self.imageV];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = FONT(13);
        _titleLabel.textColor = HEISE;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.titleLabel];
        
        self.imageV.backgroundColor = WZWgrayColor;
//        self.titleLabel.backgroundColor = WZWorangeColor;
    }
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20 * WSHIPEI);
        make.top.mas_equalTo(15 * HSHIPEI);
        make.size.mas_equalTo(CGSizeMake(75 * WSHIPEI , 75 * WSHIPEI));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageV.mas_left).offset(3);
        make.top.mas_equalTo(self.imageV.mas_bottom).offset(10 * HSHIPEI);
        make.size.mas_equalTo(CGSizeMake(75 * WSHIPEI, 20));
    }];
}
- (void)setModel:(ShopCityModel *)model
{
    if (_model != model) {
        _model = model;
    }
    [self.imageV sd_setImageWithURL:WZWURLWithString(model.cate_img) placeholderImage:ZHANWEI];
    self.titleLabel.text = model.cate_name;
}

@end
