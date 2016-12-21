//
//  WeddingDetailTwoTableViewCell.m
//  HBS_C
//
//  Created by wangzuowen on 16/10/26.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "WeddingDetailTwoTableViewCell.h"

@interface WeddingDetailTwoTableViewCell()

@property (nonatomic, strong)UIImageView *shopImgView;
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UILabel *adressLabel;
@property (nonatomic, strong)UIImageView *zhibiaoImg;
@property (nonatomic, strong)UIImageView *locationImage;

@end

@implementation WeddingDetailTwoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.shopImgView = [[UIImageView alloc] init];
        self.shopImgView.layer.cornerRadius = 20;
        self.shopImgView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.shopImgView];
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.font = FONT(13);
        [self.contentView addSubview:self.nameLabel];
        
        self.adressLabel = [[UILabel alloc] init];
        self.adressLabel.font = FONT(12);
        self.adressLabel.textColor = yiwusanColor;
        [self.contentView addSubview:self.adressLabel];
        
        self.zhibiaoImg = [[UIImageView alloc] init];
        [self.contentView addSubview:self.zhibiaoImg];
        
        self.locationImage = [[UIImageView alloc] init];
        
        [self.contentView addSubview:self.locationImage];
        [self setUp_UI];
    }
    return self;
}
- (void)setUp_UI {
    [self.shopImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.shopImgView.mas_right).offset(15);
        make.top.mas_equalTo(self.shopImgView.mas_top);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 100, 20));
    }];
    [self.locationImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.shopImgView.mas_right).offset(15);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(10, 10));
    }];
    [self.adressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.shopImgView.mas_right).offset(30);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 120, 20));
    }];
    [self.zhibiaoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WIDTH - 20);
        make.top.mas_equalTo(30);
        make.size.mas_equalTo(CGSizeMake(10, 10));
    }];
}
- (void)setDataDic:(NSDictionary *)dataDic
{
    if (_dataDic != dataDic) {
        _dataDic = dataDic;
    }
    [self.shopImgView sd_setImageWithURL:WZWURLWithString(dataDic[@"goods_store_logo"]) placeholderImage:ZHANWEI];
    self.nameLabel.text = dataDic[@"goods_store_name"];
    self.adressLabel.text = dataDic[@"goods_store_address"];
    self.locationImage.image = [UIImage imageNamed:@"icon_dizhi@2x"];
    self.zhibiaoImg.image = [UIImage imageNamed:@"icon_1_2_youjiantou@2x"];
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
