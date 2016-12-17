//
//  MainTwoTableViewCell.m
//  HBS_C
//
//  Created by wangzuowen on 16/10/14.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "MainTwoTableViewCell.h"

@implementation MainTwoTableViewCell

@synthesize titleLabel, imgView;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        imgView = [[UIImageView alloc] init];
        [self.contentView addSubview:imgView];
        
        titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = WZWwhiteColor;
        titleLabel.numberOfLines = 0;
        titleLabel.font = FONT(13);
        [self.contentView addSubview:titleLabel];
    }
    return self;
}
- (void)layoutSubviews
{
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(5);
        make.size.mas_equalTo(CGSizeMake(self.contentView.width - 20, self.contentView.height - 5));
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imgView.mas_left).offset(5);
        make.bottom.mas_equalTo(imgView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(self.contentView.width - 30, 40));
    }];
}
- (void)setModel:(MainModel *)model
{
    if (_model != model) {
        _model = model;
    }
    [imgView sd_setImageWithURL:WZWURLWithString(model.goods_image) placeholderImage:ZHANWEI];
    titleLabel.text = model.goods_name;
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
