//
//  WeddingDetailFourTableViewCell.m
//  HBS_C
//
//  Created by wangzuowen on 16/10/27.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "WeddingDetailFourTableViewCell.h"

@interface WeddingDetailFourTableViewCell()

@property (nonatomic, strong)UIImageView *imgView;
@property (nonatomic, strong)MyLabel *titleLabel;
@property (nonatomic, strong)UILabel *priceLabel;
@property (nonatomic, strong)UILabel *priceMarketLabel;
@property (nonatomic, strong)UILabel *lineLabel;

@end
@implementation WeddingDetailFourTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imgView = [[UIImageView alloc] init];
        [self.contentView addSubview:_imgView];
        
        _titleLabel = [[MyLabel alloc] init];
        _titleLabel.numberOfLines = 0;
        [_titleLabel setVerticalAlignment:VerticalAlignmentTop];
        _titleLabel.font = FONT(14);
        _titleLabel.textColor = HEISE;
        [self.contentView addSubview:_titleLabel];
        
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = FONT(15);
        _priceLabel.textColor = FENSE;
        [self.contentView addSubview:_priceLabel];
        
        _priceMarketLabel = [[UILabel alloc] init];
        _priceMarketLabel.font = FONT(12);
        _priceMarketLabel.textColor = yiwusanColor;
        [self.contentView addSubview:_priceMarketLabel];
        
        _lineLabel = [[UILabel alloc] init];
        _lineLabel.backgroundColor = ererjiuColor;
        [self.contentView addSubview:_lineLabel];
        [self setup_UI];
    }
    return self;
}

- (void)setup_UI {
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(121 * WSHIPEI, 68 * HSHIPEI));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imgView.mas_right).offset(12);
        make.top.mas_equalTo(self.imgView.mas_top);
        make.size.mas_equalTo(CGSizeMake(self.contentView.width - 121 * WSHIPEI - 32, 40));
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(8);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    [self.priceMarketLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.priceLabel.mas_right).offset(10);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(8);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.priceLabel.mas_right).offset(10);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(18);
        make.size.mas_equalTo(CGSizeMake(50 * WSHIPEI, 1));
    }];
}

- (void)setModel:(MainModel *)model
{
    _model = model;
    [self.imgView sd_setImageWithURL:WZWURLWithString(model.rec_goods_image) placeholderImage:ZHANWEI];
    self.titleLabel.text = model.rec_goods_name;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@", model.rec_goods_price];
    self.priceMarketLabel.text = [NSString stringWithFormat:@"￥%@", model.rec_goods_price_market];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
