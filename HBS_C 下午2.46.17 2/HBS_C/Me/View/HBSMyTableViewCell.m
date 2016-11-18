//
//  HBSMyTableViewCell.m
//  HBS_C
//
//  Created by 王 世江 on 16/10/26.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSMyTableViewCell.h"

@interface HBSMyTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UIImageView *leftImage;
@property (nonatomic, strong) UILabel *bottomLabel;

@end

@implementation HBSMyTableViewCell
//设置cell之间的距离
- (void)setFrame:(CGRect)frame{
    
    frame.size.height -=1;
    
    [super setFrame:frame];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = FONT(14);
        self.titleLabel.textColor = HEISE;
        [self.contentView addSubview:self.titleLabel];
        
        self.subTitleLabel = [[UILabel alloc] init];
        self.subTitleLabel.font = FONT(12);
        self.subTitleLabel.textAlignment = NSTextAlignmentRight;
        self.subTitleLabel.textColor = HBSColor(153, 153, 153);
        [self.contentView addSubview:self.subTitleLabel];
        
        self.leftImage = [[UIImageView alloc] init];
        [self.contentView addSubview:self.leftImage];
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.backgroundColor = BAISE;
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftImage.mas_right).offset(10);
        make.top.mas_equalTo(self.leftImage.mas_top).offset(-5);
        make.size.mas_equalTo(CGSizeMake(100 * HSHIPEI, 30));
    }];
    
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-35);
        make.top.mas_equalTo(self.leftImage.mas_top).offset(-8);
        make.size.mas_equalTo(CGSizeMake(100 * HSHIPEI, 30));
    }];
    
}
- (void)setDic:(NSDictionary *)dic
{
    if (_dic != dic) {
        _dic = dic;
    }
   self.leftImage.image = [UIImage imageNamed:dic[@"image"]];
   self.titleLabel.text = dic[@"title"];
   self.subTitleLabel.text = dic[@"subTitle"];
}



@end
