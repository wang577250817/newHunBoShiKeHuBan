//
//  WeddingDetailOneTableViewCell.m
//  HBS_C
//
//  Created by wangzuowen on 16/10/26.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "WeddingDetailOneTableViewCell.h"

@interface WeddingDetailOneTableViewCell()

@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *priceLabel;
@property (nonatomic, strong)UILabel *priceMarketLabel;
@property (nonatomic, strong)UILabel *earnestLabel;
@property (nonatomic, strong)UIImageView *oneImage;
@property (nonatomic, strong)UILabel *timeLabel;
@property (nonatomic, strong)UILabel *lineLabel;


@end
@implementation WeddingDetailOneTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = HEISE;
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = FONT(15);
        [self.contentView addSubview:_titleLabel];
        
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.textColor = FENSE;
        _priceLabel.font = FONT(15);
        [self.contentView addSubview:_priceLabel];
        
        _priceMarketLabel = [[UILabel alloc] init];
        _priceMarketLabel.textColor = yiqijiuColor;
        _priceMarketLabel.font = FONT(12);
        [self.contentView addSubview:_priceMarketLabel];
        
        _earnestLabel = [[UILabel alloc] init];
        _earnestLabel.textColor = FENSE;
        _earnestLabel.font = FONT(13);
        [self.contentView addSubview:_earnestLabel];
        
//        _oneImage = [[UIImageView alloc] init];
//        _oneImage.backgroundColor = WZWgrayColor;
//        [self.contentView addSubview:_oneImage];
//        
//        _timeLabel = [[UILabel alloc] init];
//        _timeLabel.textColor = FENSE;
//        _timeLabel.backgroundColor = WZWmagentaColor;
//        _timeLabel.font = FONT(13);
//        [self.contentView addSubview:_timeLabel];
        
        _lineLabel = [[UILabel alloc] init];
        _lineLabel.backgroundColor = yiqijiuColor;
        [self.contentView addSubview:_lineLabel];
        
        [self setUp_UI];
    }
    return self;
}
- (void)setUp_UI {
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(self.contentView.width - 20, 40));
    }];

    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLabel.mas_left);
        make.top.mas_equalTo(_titleLabel.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];

    [_priceMarketLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_priceLabel.mas_right).offset(5);
        make.top.mas_equalTo(_titleLabel.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_priceMarketLabel.mas_left);
        make.top.mas_equalTo(_priceMarketLabel.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(50, 1));
    }];
    [_earnestLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_priceMarketLabel.mas_right).offset(30);
        make.top.mas_equalTo(_titleLabel.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
//    [_lineLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(_titleLabel.mas_left);
//        make.top.mas_equalTo(_priceLabel.mas_bottom).offset(15);
//        make.size.mas_equalTo(CGSizeMake(self.contentView.width - 20, 1));
//    }];
//    [_oneImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(_titleLabel.mas_left);
//        make.top.mas_equalTo(_lineLabel1.mas_bottom).offset(15);
//        make.size.mas_equalTo(CGSizeMake(50, 16));
//    }];
//    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(_oneImage.mas_right).offset(12);
//        make.top.mas_equalTo(_lineLabel1.mas_bottom).offset(15);
//        make.size.mas_equalTo(CGSizeMake(100, 20));
//    }];
}
- (void)setDataDic:(NSDictionary *)dataDic
{
    if (_dataDic != dataDic) {
        _dataDic = dataDic;
    }
    NSInteger tt = 0;
    if (![dataDic[@"goods_cate_name"] isEqual:[NSNull null]]) {
        
        tt = [self.dataDic[@"goods_cate_name"] convertToInt:self.dataDic[@"goods_cate_name"]];
    }
    NSMutableAttributedString *strOne = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"[%@]%@", self.dataDic[@"goods_cate_name"], self.dataDic[@"goods_name"]]];
    [strOne addAttribute:NSForegroundColorAttributeName value:LANSE range:NSMakeRange(1,tt / 2)];
    
    _titleLabel.attributedText = strOne;
    
    _priceLabel.text = [NSString stringWithFormat:@"¥%@", self.dataDic[@"goods_price"]];
    _priceMarketLabel.text = [NSString stringWithFormat:@"¥%@", self.dataDic[@"goods_price_market"]];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"定金:¥%@", self.dataDic[@"goods_price_sale"]]];
    [str addAttribute:NSForegroundColorAttributeName value:LANSE range:NSMakeRange(0,2)];
    _earnestLabel.attributedText = str;

    
    if (self.type == 0 || self.type == 1) {
//        _timeLabel.text = @"08927401892";
//        _oneImage
//        _lineLabel1.hidden = NO;
//        _timeLabel.hidden = NO;
//        _oneImage.hidden = NO;
        _priceLabel.hidden = NO;
        _priceMarketLabel.hidden = NO;
        _earnestLabel.hidden = NO;
    }else{
        _priceLabel.hidden = YES;
        _priceMarketLabel.hidden = YES;
        _earnestLabel.hidden = YES;
//        _lineLabel1.hidden = YES;
//        _timeLabel.hidden = YES;
//        _oneImage.hidden = YES;
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
