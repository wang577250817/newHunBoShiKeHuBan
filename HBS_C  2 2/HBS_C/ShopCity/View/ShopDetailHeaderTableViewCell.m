//
//  ShopDetailHeaderTableViewCell.m
//  HBS_C
//
//  Created by wangzuowen on 16/11/1.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "ShopDetailHeaderTableViewCell.h"

@interface ShopDetailHeaderTableViewCell()

@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *typeLabel;
@property (nonatomic, strong)UILabel *lookLabel;
@property (nonatomic, strong)UILabel *fansLabel;
@property (nonatomic, strong)UILabel *IntroductionLabel;
@property (nonatomic, strong)UILabel *lineLabel;
@property (nonatomic, strong)UIImageView *adressImage;
@property (nonatomic, strong)UILabel *adressLabel;

@property (nonatomic, strong)UIImageView *userImageView;
@end
@implementation ShopDetailHeaderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = FONT(15);
        _titleLabel.textColor = HEISE;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLabel];
        
        _typeLabel = [[UILabel alloc] init];
        _typeLabel.textAlignment = NSTextAlignmentRight;
        _typeLabel.font = FONT(12);
        _typeLabel.textColor = yilingerColor;
        [self.contentView addSubview:_typeLabel];
        
        _lookLabel = [[UILabel alloc] init];
        _lookLabel.font = FONT(12);
        _lookLabel.textColor = yilingerColor;
        [self.contentView addSubview:_lookLabel];
        
        _fansLabel = [[UILabel alloc] init];
        _fansLabel.font = FONT(12);
        _fansLabel.textColor = yilingerColor;
        [self.contentView addSubview:_fansLabel];
        
        _IntroductionLabel = [[UILabel alloc] init];
        _IntroductionLabel.font = FONT(13);
        _IntroductionLabel.numberOfLines = 0;
        _IntroductionLabel.textColor = yilingerColor;
        [self.contentView addSubview:_IntroductionLabel];
        
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_moreButton];
        
        _lineLabel = [[UILabel alloc] init];
        _lineLabel.backgroundColor = BEIJINGSE;
        [self.contentView addSubview:_lineLabel];
        
        _adressImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_adressImage];
        
        _adressLabel = [[UILabel alloc] init];
        _adressLabel.font = FONT(13);
        _adressLabel.textColor = HEISE;
        [self.contentView addSubview:_adressLabel];
        
        _userImageView = [[UIImageView alloc] init];
        _userImageView.layer.cornerRadius = 85 / 2;
        _userImageView.layer.masksToBounds = YES;
//        _userImageView.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:_userImageView];

    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.bottom.mas_equalTo(self.contentView.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(85, 85));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 20));
    }];
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(80 * WSHIPEI);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(12);
        make.size.mas_equalTo(CGSizeMake((WIDTH - 160 - 4) / 3 * WSHIPEI, 10));
    }];
    [self.lookLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_typeLabel.mas_right).offset(10);
        make.top.mas_equalTo(self.typeLabel.mas_top);
        make.size.mas_equalTo(CGSizeMake((WIDTH - 160 - 4) / 3 * WSHIPEI, 10));
    }];
    [self.fansLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_lookLabel.mas_right).offset(0);
        make.top.mas_equalTo(self.typeLabel.mas_top);
        make.size.mas_equalTo(CGSizeMake((WIDTH - 160 - 4) / 3 * WSHIPEI, 10));
    }];
    CGFloat ff = [TextAdapter HeightWithText:self.model.store_description width:WIDTH - 60 * WSHIPEI font:13];
    if (_isMore) {
        self.IntroductionLabel.frame = CGRectMake(30, self.typeLabel.height + self.typeLabel.y + 10, WIDTH - 60, ff);
    }else{
        self.IntroductionLabel.frame = CGRectMake(30, self.typeLabel.height + self.typeLabel.y + 10, WIDTH - 60, 40);
    }
    
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(self.IntroductionLabel.mas_bottom).offset(9);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 7));
    }];
    if (ff < 30.0) {
        _moreButton.hidden = YES;
    }else{
        _moreButton.hidden = NO;
    }
    
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(self.moreButton.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 5));
    }];
    [self.adressImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(self.lineLabel.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(14, 18));
    }];
    [self.adressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.adressImage.mas_right).offset(12);
        make.top.mas_equalTo(self.adressImage.mas_top).offset(3);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 46, 18));
    }];
}
- (void)setModel:(ShopCityModel *)model
{
    if (_model != model) {
        _model = model; 
    }
    [self.moreButton setImage:[UIImage imageNamed:@"icon_xialajiantou@2x"] forState:UIControlStateNormal];
    [self.moreButton setImage:[UIImage imageNamed:@"iconshanglajiantou@2x"] forState:UIControlStateSelected];
    self.titleLabel.text = self.model.store_name;
        self.IntroductionLabel.text = self.model.store_description;
    self.adressImage.image = [UIImage imageNamed:@"icon_dizhi@2x"];
    self.adressLabel.text = self.model.store_address;
    
    self.typeLabel.text = [NSString stringWithFormat:@"%@", model.store_cateName];
    NSMutableAttributedString *strOne = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"/  访客:%@", model.store_views]];
    [strOne addAttribute:NSForegroundColorAttributeName value:LANSE range:NSMakeRange(0,1)];
    self.lookLabel.attributedText = strOne;
    NSMutableAttributedString *strTwo = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"/  粉丝:%@", model.store_collects]];
    [strTwo addAttribute:NSForegroundColorAttributeName value:LANSE range:NSMakeRange(0,1)];
    self.fansLabel.attributedText = strTwo;

    
    [_userImageView sd_setImageWithURL:WZWURLWithString(self.model.store_logo) placeholderImage:ZHANWEI];
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
