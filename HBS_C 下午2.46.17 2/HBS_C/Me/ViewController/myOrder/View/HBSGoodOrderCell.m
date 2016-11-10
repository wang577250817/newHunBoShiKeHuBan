//
//  HBSGoodOrderCell.m
//  HBS_C
//
//  Created by 王 世江 on 16/11/9.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSGoodOrderCell.h"
#import "HBSGoodModel.h"
#import "HBSHeaderView.h"
@interface HBSGoodOrderCell ()
@property (nonatomic, strong) UILabel *grayLabel;//灰线
@property (nonatomic, strong) UIImageView *goodImage;//商品图片
@property (nonatomic, strong) UILabel *goodNameLabel;//商品名称
@property (nonatomic, strong) UILabel *goodSpecLabel;//规格
@property (nonatomic, strong) UILabel *goodMoneyLabel;//钱
@property (nonatomic, strong) UILabel *goodAmountLabel;//数量

//@property (nonatomic, strong) HBSHeaderView *headr

@end

@implementation HBSGoodOrderCell

#pragma mark-----初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        self.grayLabel = [[UILabel alloc]init];
        self.grayLabel.backgroundColor = HBSColor(229, 229, 229);
        [self addSubview:self.grayLabel];
        //商品图片
        self.goodImage = [[UIImageView alloc]init];
        [self addSubview:self.goodImage];
        //商品名
        self.goodNameLabel = [[UILabel alloc]init];
        self.goodNameLabel.backgroundColor = HBSRandomColor;
        self.goodNameLabel.font = FONT(14);
        self.goodNameLabel.textColor = HEISE;
        self.goodNameLabel.numberOfLines = 0;
        [self addSubview:self.goodNameLabel];
        //商品规格
        self.goodSpecLabel = [[UILabel alloc]init];
        self.goodSpecLabel.backgroundColor = HBSRandomColor;
        self.goodSpecLabel.font = FONT(12);
        self.goodSpecLabel.textColor = HBSColor(153, 153, 153);
        [self addSubview:self.goodSpecLabel];
        //钱数
        self.goodMoneyLabel = [[UILabel alloc]init];
        self.goodMoneyLabel.backgroundColor = HBSRandomColor;
        self.goodMoneyLabel.font = FONT(15);
        self.goodMoneyLabel.textColor = FENSE;
        [self addSubview:self.goodMoneyLabel];
        //商品数量
        self.goodAmountLabel = [[UILabel alloc]init];
        self.goodAmountLabel.backgroundColor = HBSRandomColor;
        self.goodAmountLabel.font = FONT(15);
        self.goodAmountLabel.textColor = HEISE;
        self.goodAmountLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.goodAmountLabel];
        
    }
    
    return self;
}
#pragma mark----布局
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.grayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self).offset(15);
        make.left.mas_equalTo(self).offset(10);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 2 * 10, 1));
        
    }];
        [self.goodImage mas_makeConstraints:^(MASConstraintMaker *make) {
    
            make.top.mas_equalTo(self.grayLabel).offset(10);
            make.left.mas_equalTo(self).offset(10);
            make.size.mas_equalTo(CGSizeMake(90, 90));
    
        }];
    
        [self.goodNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    
            make.top.mas_equalTo(self.grayLabel).offset(17);
            make.left.mas_equalTo(self.goodImage).offset(105);
            make.size.mas_equalTo(CGSizeMake(WIDTH - 125, 35));
    
        }];
    

    [self.goodSpecLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.goodNameLabel).offset(45);
        make.left.mas_equalTo(self.goodImage).offset(105);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 125, 15));
        
    }];

    [self.goodMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.goodSpecLabel).offset(20);
        make.left.mas_equalTo(self.goodImage).offset(105);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 240, 15));
        
    }];
    
    [self.goodAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.mas_equalTo(self).offset(-10);
        make.top.mas_equalTo(self.goodSpecLabel).offset(20);
         make.size.mas_equalTo(CGSizeMake(50, 15));
    }];

    
}
- (void)setGoodModel:(HBSGoodModel *)goodModel{
    
    _goodModel = goodModel;
    [self.goodImage sd_setImageWithURL:[NSURL URLWithString:goodModel.goods_image] placeholderImage:ZHANWEI];
    self.goodNameLabel.text = goodModel.goods_name;
    self.goodSpecLabel.text = [NSString stringWithFormat:@"规格:%@", goodModel.goods_spec];
    self.goodMoneyLabel.text = [NSString stringWithFormat:@"¥%@", goodModel.goods_amount];
    self.goodAmountLabel.text = [NSString stringWithFormat:@"*%@", goodModel.goods_quantity];
    
}
@end
