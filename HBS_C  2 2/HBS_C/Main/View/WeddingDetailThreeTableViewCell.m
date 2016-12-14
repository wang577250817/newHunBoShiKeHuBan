//
//  WeddingDetailThreeTableViewCell.m
//  HBS_C
//
//  Created by wangzuowen on 16/10/26.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "WeddingDetailThreeTableViewCell.h"

@implementation WeddingDetailThreeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.photoButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.photoButton setTitle:@"图文详情" forState:UIControlStateNormal];
        self.photoButton.tag = 9000;
        self.photoButton.tintColor = FENSE;
        [self.contentView addSubview:self.photoButton];
        
        self.textButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.textButton.tintColor = yiwusanColor;
        self.textButton.tag = 9001;
        [self.textButton setTitle:@"参数列表" forState:UIControlStateNormal];
        [self.contentView addSubview:self.textButton];
        
        self.bgView = [[UIView alloc] init];
        [self.contentView addSubview:self.bgView];
        
        self.grayLabel = [[UILabel alloc] init];
        self.grayLabel.backgroundColor = yiwusanColor;
        [self.contentView addSubview:self.grayLabel];
        
        self.lineLabel = [[UILabel alloc] init];
        self.lineLabel.backgroundColor = FENSE;
        [self.contentView addSubview:self.lineLabel];
        
        [self.photoButton addTarget:self action:@selector(photoButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.textButton addTarget:self action:@selector(textButtonAction) forControlEvents:UIControlEventTouchUpInside];
        self.weizhi = YES;
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.photoButton.frame = CGRectMake((WIDTH - 160) / 3, 10, 80, 20);
    self.textButton.frame = CGRectMake((WIDTH - 160) / 3 * 2 + 80, 10, 80, 20);
    self.bgView.frame = CGRectMake(0, 37, WIDTH, self.contentView.frame.size.height - 37);
    self.grayLabel.frame = CGRectMake(10, 35, WIDTH - 20, 1);
    if (!self.weizhi) {
        self.lineLabel.frame = CGRectMake((WIDTH - 160) / 3 * 2 + 80, 35, 80, 2);
    }else{
        self.lineLabel.frame = CGRectMake((WIDTH - 160) / 3, 35, 80, 2);
    }
}
- (void)photoButtonAction
{
    self.weizhi = YES;
    self.photoButton.tintColor = FENSE;
    self.textButton.tintColor = yiwusanColor;
    self.lineLabel.frame = CGRectMake((WIDTH - 160) / 3, 35, 80, 2);
}
- (void)textButtonAction
{
    self.weizhi = NO;
    self.photoButton.tintColor = yiwusanColor;
    self.textButton.tintColor = FENSE;
    self.lineLabel.frame = CGRectMake((WIDTH - 160) / 3 * 2 + 80, 35, 80, 2);
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
