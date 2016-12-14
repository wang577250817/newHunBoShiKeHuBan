//
//  MainOneTableViewCell.m
//  HBS_C
//
//  Created by wangzuowen on 16/10/14.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "MainOneTableViewCell.h"

@implementation MainOneTableViewCell

@synthesize hdzqImageView, hlgjImageView, thpImageView, bslImageView, bslButton, thpButton, hdzqButton, hlgjButton;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        hlgjImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:hlgjImageView];
        
        bslImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:bslImageView];
        
        thpImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:thpImageView];
        
        hdzqImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:hdzqImageView];
        
        hlgjButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:hlgjButton];
        
        bslButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:bslButton];
        
        thpButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:thpButton];
        
        hdzqButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:hdzqButton];
        
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [hdzqImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(150 * WSHIPEI, 200 * HSHIPEI));
    }];
    hdzqButton.frame = hdzqImageView.frame;
    [bslImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(hdzqImageView.mas_right).offset(0);
        make.top.mas_equalTo(hdzqImageView.mas_top);
        make.size.mas_equalTo(CGSizeMake(225 * WSHIPEI, 70 * HSHIPEI));
    }];
    bslButton.frame = bslImageView.frame;
    [hlgjImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bslImageView.mas_left);
        make.top.mas_equalTo(bslImageView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(113 * WSHIPEI, 130 * HSHIPEI));
    }];
    hlgjButton.frame = hlgjImageView.frame;
    [thpImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(hlgjImageView.mas_right);
        make.top.mas_equalTo(bslImageView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(112 * WSHIPEI, 130 * HSHIPEI));
    }];
    thpButton.frame = thpImageView.frame;
}
- (void)setDataArr:(NSMutableArray *)dataArr
{
    if (_dataArr != dataArr) {
        _dataArr = dataArr;
    }
    if (dataArr.count == 0) {
        
    }else{
        [hdzqImageView sd_setImageWithURL:WZWURLWithString(dataArr[0][@"tab_img"]) placeholderImage:ZHANWEI];
        [bslImageView sd_setImageWithURL:WZWURLWithString(dataArr[1][@"tab_img"]) placeholderImage:ZHANWEI];
        [hlgjImageView sd_setImageWithURL:WZWURLWithString(dataArr[2][@"tab_img"]) placeholderImage:ZHANWEI];
        [thpImageView sd_setImageWithURL:WZWURLWithString(dataArr[3][@"tab_img"]) placeholderImage:ZHANWEI];
    }
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
