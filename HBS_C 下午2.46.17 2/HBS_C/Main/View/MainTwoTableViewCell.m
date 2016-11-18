//
//  MainTwoTableViewCell.m
//  HBS_C
//
//  Created by wangzuowen on 16/10/14.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "MainTwoTableViewCell.h"

@implementation MainTwoTableViewCell

@synthesize buttonOne, buttonTwo, buttonFive, buttonFour, buttonThree;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        buttonOne = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:buttonOne];
        
        buttonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:buttonTwo];
        
        buttonThree = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:buttonThree];
        
        buttonFour = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:buttonFour];
        
        buttonFive = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:buttonFive];
        
        [buttonOne setTitle:@"婚礼策划" forState:UIControlStateNormal];
        [buttonTwo setTitle:@"婚纱摄影" forState:UIControlStateNormal];
        [buttonThree setTitle:@"婚礼酒店" forState:UIControlStateNormal];
        [buttonFour setTitle:@"司仪" forState:UIControlStateNormal];
        [buttonFive setTitle:@"跟妆" forState:UIControlStateNormal];
        
        buttonOne.titleLabel.font = FONT(14);
        buttonTwo.titleLabel.font = FONT(14);
        buttonThree.titleLabel.font = FONT(14);
        buttonFour.titleLabel.font = FONT(14);
        buttonFive.titleLabel.font = FONT(14);
    }
    return self;
}
- (void)layoutSubviews
{
    [buttonOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake((WIDTH - 60) / 4, 30));
    }];
    [buttonTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(buttonOne.mas_right).offset(10);
        make.top.mas_equalTo(buttonOne.mas_top);
        make.size.mas_equalTo(CGSizeMake((WIDTH - 60) / 4, 30));
    }];
    [buttonThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(buttonTwo.mas_right).offset(10);
        make.top.mas_equalTo(buttonOne.mas_top);
        make.size.mas_equalTo(CGSizeMake((WIDTH - 60) / 4, 30));
    }];
    [buttonFour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(buttonThree.mas_right).offset(10);
        make.top.mas_equalTo(buttonOne.mas_top);
        make.size.mas_equalTo(CGSizeMake((WIDTH - 60) / 4 / 2, 30));
    }];
    [buttonFive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(buttonFour.mas_right).offset(10);
        make.top.mas_equalTo(buttonOne.mas_top);
        make.size.mas_equalTo(CGSizeMake((WIDTH - 60) / 4 / 2, 30));
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
