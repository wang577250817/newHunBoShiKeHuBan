//
//  HBSFriendCell.m
//  HBS_C
//
//  Created by 王 世江 on 16/11/3.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSFriendCell.h"

@interface HBSFriendCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UIImageView *leftImage;
@property (nonatomic, strong) UILabel *bottomLabel;

@end

@implementation HBSFriendCell
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
        self.titleLabel.font = FONT(15);
        self.titleLabel.textColor = HEISE;
        [self.contentView addSubview:self.titleLabel];
        
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
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftImage.mas_right).offset(10);
        make.centerY.mas_equalTo(self);
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
}


@end
