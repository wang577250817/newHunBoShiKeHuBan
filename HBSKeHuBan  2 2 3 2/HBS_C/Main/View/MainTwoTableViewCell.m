//
//  MainTwoTableViewCell.m
//  HBS_C
//
//  Created by wangzuowen on 16/10/14.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "MainTwoTableViewCell.h"

@implementation MainTwoTableViewCell

@synthesize titleLabel, imgView, backImage;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        imgView = [[UIImageView alloc] init];
        [self.contentView addSubview:imgView];
        
        backImage = [[UIImageView alloc] init];
        [self.contentView addSubview:backImage];
        
        titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = WZWwhiteColor;
        titleLabel.numberOfLines = 0;
        titleLabel.font = FONT(13);
        [self.contentView addSubview:titleLabel];
//        [self setUpUI];
    }
    return self;
}
- (void)layoutSubviews
{
    imgView.frame = CGRectMake(10, 5, WIDTH - 20, 190 * HSHIPEI);
    backImage.frame = CGRectMake(10, (200 - 45)*HSHIPEI, WIDTH - 20, 40);
    titleLabel.frame = CGRectMake(15, (200 - 45)*HSHIPEI, WIDTH - 30, 40);
//    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(10);
//        make.top.mas_equalTo(5);
////        make.size.mas_equalTo(CGSizeMake(self.contentView.width - 20, self.contentView.height - 5));
//        make.width.mas_equalTo(self.contentView.width - 20);
//        make.height.mas_equalTo(self.contentView.height - 5);
//    }];
//    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(imgView.mas_left).offset(5);
//        make.bottom.mas_equalTo(imgView.mas_bottom).offset(-40);
////        make.size.mas_equalTo(CGSizeMake(self.contentView.width - 30, 40));
//        make.width.mas_equalTo(self.contentView.width - 30);
//        make.height.mas_equalTo(40);
//    }];
}
- (void)setModel:(MainModel *)model
{
    if (_model != model) {
        _model = model;
    }
    backImage.image = [UIImage imageNamed:@"heise"];
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
