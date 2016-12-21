//
//  ShopDetailEvaluationTableViewCell.m
//  HBS_C
//
//  Created by wangzuowen on 16/10/31.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "ShopDetailEvaluationTableViewCell.h"

@interface ShopDetailEvaluationTableViewCell()

@property (nonatomic, strong)UIImageView *userImageView;
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UILabel *timeLabel;
@property (nonatomic, strong)UILabel *contentLabel;

@end
@implementation ShopDetailEvaluationTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.userImageView = [[UIImageView alloc] init];
        self.userImageView.layer.cornerRadius = 25.0;
        self.userImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:_userImageView];
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = HEISE;
        _nameLabel.font = FONT(14);
        [self.contentView addSubview:_nameLabel];
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = HEISE;
        _timeLabel.font = FONT(12);
        _timeLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_timeLabel];
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = HEISE;
        _contentLabel.font = FONT(13);
        _contentLabel.numberOfLines = 0;
        [self.contentView addSubview:_contentLabel];
        
//        self.userImageView.backgroundColor = WZWgrayColor;
//        self.nameLabel.backgroundColor = WZWblackColor;
//        self.timeLabel.backgroundColor = [UIColor redColor];
//        self.contentLabel.backgroundColor = WZWmagentaColor;
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(50, 50));

    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userImageView.mas_right).offset(15);
        make.top.mas_equalTo(self.userImageView.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WIDTH - 80);
        make.top.mas_equalTo(self.userImageView.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(70, 20));
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userImageView.mas_right).offset(15);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 85, 40));
    }];
}
- (void)setModel:(ShopCityModel *)model
{
    _model = model;
    
    [_userImageView sd_setImageWithURL:WZWURLWithString(model.comment_head) placeholderImage:ZHANWEI];
    _nameLabel.text = model.comment_name;
    _timeLabel.text = model.comment_time;
    _contentLabel.text = model.comment;
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
