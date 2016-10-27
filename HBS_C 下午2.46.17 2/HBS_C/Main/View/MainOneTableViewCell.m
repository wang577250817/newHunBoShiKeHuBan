//
//  MainOneTableViewCell.m
//  HBS_C
//
//  Created by wangzuowen on 16/10/14.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "MainOneTableViewCell.h"

@implementation MainOneTableViewCell

@synthesize hdzqImageView, hlgjImageView, thpImageView, bslImageView;

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
        
        hlgjImageView.backgroundColor = [UIColor orangeColor];
        bslImageView.backgroundColor = [UIColor magentaColor];
        thpImageView.backgroundColor =  [UIColor lightGrayColor];
        hdzqImageView.backgroundColor = [UIColor greenColor];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
     [hlgjImageView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(10);
         make.top.mas_equalTo(10);
         make.size.mas_equalTo(CGSizeMake(50, 80));
     }];
    [bslImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(hlgjImageView.mas_right).offset(10);
        make.top.mas_equalTo(hlgjImageView.mas_top);
        make.size.mas_equalTo(CGSizeMake(50, 35));
    }];
    [thpImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bslImageView.mas_right).offset(10);
        make.top.mas_equalTo(hlgjImageView.mas_top);
        make.size.mas_equalTo(CGSizeMake(50, 35));
    }];
    [hdzqImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(hlgjImageView.mas_right).offset(10);
        make.top.mas_equalTo(bslImageView.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 35));
    }];
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
