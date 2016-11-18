//
//  HBSServiceCell.m
//  HBS_C
//
//  Created by 王 世江 on 16/11/1.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSServiceCell.h"
#import "HBSServiceModel.h"

@interface HBSServiceCell ()
@property (nonatomic, strong) UIImageView *shopImage;//商品image
@property (nonatomic, strong) UILabel *titleLabel;//内容label
@property (nonatomic, strong) UILabel *redMoneyLabel;//红钱label
@property (nonatomic, strong) UILabel *grayMoneyLabel;//灰钱label
@property (nonatomic, strong) UILabel *grayLabel;//灰线label
@end

@implementation HBSServiceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.shopImage = [[UIImageView alloc]init];
        [self.shopImage setImage:[UIImage imageNamed:@"backImage"]];
        [self addSubview:self.shopImage];
        
        //标题label
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.text = @"城祥是傻逼吗城祥是傻逼城祥真的是傻逼城祥是傻逼吗城祥是傻逼城祥真的是傻逼";
        self.titleLabel.font = FONT(15);
//        self.titleLabel.backgroundColor = HBSRandomColor;
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.textColor = HEISE;
        [self addSubview:self.titleLabel];
        
        //红钱label
        self.redMoneyLabel = [[UILabel alloc]init];
        self.redMoneyLabel.text = @"666666";
        self.redMoneyLabel.font = FONT(15);
        self.redMoneyLabel.textAlignment = NSTextAlignmentLeft;
//        self.redMoneyLabel.backgroundColor = HBSRandomColor;
        self.redMoneyLabel.textColor = FENSE;
        [self addSubview:self.redMoneyLabel];
        
        //灰钱label
        self.grayMoneyLabel = [[UILabel alloc]init];
        self.grayMoneyLabel.text = @"666666";
        self.grayMoneyLabel.font = FONT(13);
//        self.grayMoneyLabel.backgroundColor = HBSRandomColor;
        self.grayMoneyLabel.textColor = HBSColor(153, 153, 153);
        [self addSubview:self.grayMoneyLabel];
        
        //灰线
        self.grayLabel = [[UILabel alloc]init];
        self.grayLabel.backgroundColor = HBSColor(153, 153, 153);
        [self addSubview:self.grayLabel];
        
    }
    
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
//    self.backgroundColor = HBSRandomColor;
    [self.shopImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self).offset(15);
        make.left.mas_equalTo(self).offset(10);
        make.size.mas_equalTo(CGSizeMake(136, 76));
        
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.shopImage).offset(151);
        make.top.mas_equalTo(self).offset(17);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 165, 40));
        
    }];
    
    [self.redMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self.shopImage).offset(155);
        make.top.mas_equalTo(self.titleLabel).offset(55);
        make.size.mas_equalTo(CGSizeMake(75, 15));
        
    }];
    
    [self.grayMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.redMoneyLabel).offset(95);
        make.top.mas_equalTo(self.titleLabel).offset(55);
        make.size.mas_equalTo(CGSizeMake(80, 15));
        
    }];
    
    [self.grayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self.redMoneyLabel).offset(95);
        make.top.mas_equalTo(self.titleLabel).offset(62);
        make.size.mas_equalTo(CGSizeMake(80, 1));
        
    }];
    
}
- (void)setFrame:(CGRect)frame{
    
    frame.size.height -= 1;
    
    [super setFrame:frame];
}

- (void)setServiceModel:(HBSServiceModel *)serviceModel{
    
    _serviceModel = serviceModel;
    self.titleLabel.text = serviceModel.goods_name;
    [self.shopImage sd_setImageWithURL:[NSURL URLWithString:serviceModel.goods_image] placeholderImage:ZHANWEI];
    self.redMoneyLabel.text = [NSString stringWithFormat:@"¥%@", serviceModel.goods_price];
    self.grayMoneyLabel.text = [NSString stringWithFormat:@"¥%@", serviceModel.goods_price_market];
    
}

@end
