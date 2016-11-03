//
//  HBSMarriageCell.m
//  HBS_C
//
//  Created by 王 世江 on 16/11/1.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSMarriageCell.h"
#import "HBSMarriageModel.h"
@interface HBSMarriageCell ()

@end

@implementation HBSMarriageCell
@synthesize imgView, priceLabel, titleLabel, priceMarketLabel, grayLabel;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        imgView = [[UIImageView alloc] init];
        imgView.userInteractionEnabled = NO;
        [imgView setImage:[UIImage imageNamed:@"backImage"]];
        [self.contentView addSubview:imgView];
        
        titleLabel = [[UILabel alloc] init];
        titleLabel.font = FONT(14);
        titleLabel.text = @"海豚湾恋人男女对戒";
        titleLabel.textColor = HEISE;
        [self.contentView addSubview:titleLabel];
        
        priceLabel = [[UILabel alloc] init];
        priceLabel.textColor = FENSE;
        priceLabel.text = @"666666";
        priceLabel.font = FONT(15);
        [self.contentView addSubview:priceLabel];
        
        priceMarketLabel = [[UILabel alloc] init];
        priceMarketLabel.font = FONT(15);
        priceMarketLabel.text = @"666666";
        priceMarketLabel.textColor = HBSColor(153, 153, 153);
        [self.contentView addSubview:priceMarketLabel];
        
        grayLabel = [[UILabel alloc]init];
        grayLabel.backgroundColor = HBSColor(153, 153, 153);
        [self addSubview:grayLabel];
        
        
    }
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    
//    self.backgroundColor = HBSRandomColor;
    
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
    [grayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(priceLabel.mas_right).offset(10);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(60, 1));
    }];
}
- (void)setMarriageModel:(HBSMarriageModel *)marriageModel{
    
    _marriageModel = marriageModel;
    [imgView sd_setImageWithURL:[NSURL URLWithString:marriageModel.goods_image] placeholderImage:ZHANWEI];
    titleLabel.text = marriageModel.goods_name;
    priceLabel.text = [NSString stringWithFormat:@"¥%@", marriageModel.goods_price];
    priceMarketLabel.text = [NSString stringWithFormat:@"¥%@", marriageModel.goods_price_market];
    
}

@end
