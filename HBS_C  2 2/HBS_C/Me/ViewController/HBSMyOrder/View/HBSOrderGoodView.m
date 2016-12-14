

//
//  HBSOrderGoodView.m
//  HBS_C
//
//  Created by 王 世江 on 16/11/8.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSOrderGoodView.h"
#import "HBSOrderModel.h"

@interface HBSOrderGoodView ()
@property (nonatomic, strong) UILabel *nameLabel;//商品名
@property (nonatomic, strong) UIImageView *nameImage;//商品image
@property (nonatomic, strong) UILabel *specLabel;//商品规格
@property (nonatomic, assign) CGFloat numBer;
@property (nonatomic, strong) NSMutableArray *productArr;
@property (nonatomic, strong) UILabel *amountLabel;//商品钱数
@property (nonatomic, strong) UILabel *quantityLabel;//商品数量
@property (nonatomic, strong) UILabel *grayLabel;
@property (nonatomic, strong) UILabel *moneyLabel;


@end
@implementation HBSOrderGoodView

- (instancetype)initWithFrame:(CGRect)frame{
    
   self =  [super initWithFrame:frame];
    if (self) {
        self.grayLabel = [[UILabel alloc]init];
        self.grayLabel.backgroundColor = HBSColor(229, 229, 229);
        [self addSubview:self.grayLabel];
        //总计钱数
        self.moneyLabel = [[UILabel alloc]init];
        self.moneyLabel.textColor = FENSE;
        self.moneyLabel.font = FONT(13);
        self.moneyLabel.text = @"总计:";
        self.moneyLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.moneyLabel];
        
    }

    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.grayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self).offset(-10);
        make.bottom.mas_equalTo(self).offset(10);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 2 * 10, 1));
        
    }];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.mas_equalTo(self).offset(-10);
        make.top.mas_equalTo(self.grayLabel).offset(10);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 100, 15));
        
    }];
}

- (void)setOrderModel:(HBSOrderModel *)orderModel{
    
    _orderModel = orderModel;
    
    if ([orderModel.order_type isEqualToString:@"service"]) {
        self.nameLabel.hidden = YES;
        
    }else{
        self.nameLabel.hidden = NO;
        
    }
    self.productArr = orderModel.order_goods_info;
    self.numBer = orderModel.goods_num;
    self.moneyLabel.text = [NSString stringWithFormat:@"总计: ¥%@", orderModel.order_amount];
    //公共的
    NSUInteger count = self.productArr.count;
    //商品图片
    CGFloat nameImageW = 90;
    CGFloat nameImageH = self.numBer * 10;
    for (NSInteger i = 0; i < count; i++) {
        
        self.nameImage = [[UIImageView alloc]init];
        self.nameImage.frame = CGRectMake(-10, 120 * i + nameImageH, nameImageW, nameImageW);
        [self.nameImage sd_setImageWithURL:[NSURL URLWithString:self.productArr[i][@"goods_image"]] placeholderImage:ZHANWEI];
        [self addSubview:self.nameImage];
        
    }
    //商品名称
        CGFloat titleLabelH = self.numBer * 10;
        for (NSUInteger i = 0; i < count; i++) {
    
            self.nameLabel = [[UILabel alloc]init];
//            self.nameLabel.backgroundColor = HBSRandomColor;
            self.nameLabel.font = FONT(14);
            self.nameLabel.textColor = HEISE;
            self.nameLabel.numberOfLines = 0;
            self.nameLabel.text = self.productArr[i][@"goods_name"];
            self.nameLabel.frame = CGRectMake(95, 120 * i + titleLabelH, WIDTH - 120, 35);
            [self addSubview:self.nameLabel];
        }
    
    //商品规格
//    CGFloat specLabelH = self.numBer * 12;
    for (NSUInteger i = 0; i < count; i++) {
    
        self.specLabel = [[UILabel alloc]init];
//        self.specLabel.backgroundColor = HBSRandomColor;
        self.specLabel.font = FONT(12);
        self.specLabel.textColor = HBSColor(153, 153, 153);
        self.specLabel.text = self.productArr[i][@"goods_spec"];
        self.specLabel.frame = CGRectMake(95, 116 * (i - 0.61) + 140, WIDTH - 120, 15);
        [self addSubview:self.specLabel];
    }
    
    //商品价钱
//    CGFloat moneyLabelH = self.numBer * 40;
    for (NSUInteger i = 0; i < count; i++) {
        
        self.amountLabel = [[UILabel alloc]init];
        self.amountLabel.font = FONT(14);
        self.amountLabel.textColor = FENSE;
//        self.amountLabel.backgroundColor = HBSRandomColor;
        self.amountLabel.text = [NSString stringWithFormat:@"¥%@", self.productArr[i][@"goods_amount"]];
        self.amountLabel.frame = CGRectMake(95, 120 * (i - 0.64) + 165, WIDTH - 280, 15);
        [self addSubview:self.amountLabel];
        
    }
    //商品数量
    for (NSUInteger i = 0; i < count; i++) {
        
        self.quantityLabel = [[UILabel alloc]init];
        self.quantityLabel.font = FONT(14);
        self.quantityLabel.textColor = HEISE;
        self.quantityLabel.textAlignment = NSTextAlignmentRight;
//        self.quantityLabel.backgroundColor = HBSRandomColor;
        self.quantityLabel.text = [NSString stringWithFormat:@"*%@", self.productArr[i][@"goods_quantity"]];
        self.quantityLabel.frame = CGRectMake(WIDTH - 120, 120 * (i - 0.64) + 165, WIDTH - 280, 15);
        [self addSubview:self.quantityLabel];
        
    }
    
    
}

@end
