
//
//  HBSHeaderView.m
//  HBS_C
//
//  Created by 王 世江 on 16/11/10.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSHeaderView.h"

@interface HBSHeaderView ()
@property (nonatomic, strong) UIView *grayView;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UIImageView *addressImage;
@property (nonatomic, strong) UILabel *shouNameLabel;
@property (nonatomic, strong) UILabel *shouAddressLabel;
@property (nonatomic, strong) UILabel *grayLabel;
@property (nonatomic, strong) UILabel *shopNameLabel;//店名label

@end
@implementation HBSHeaderView
#pragma mark----初始化
- (instancetype)initWithFrame:(CGRect)frame{
    

   self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = BAISE;
        
        self.grayView = [[UIView alloc]init];
        self.grayView.backgroundColor = HBSRandomColor;
        [self addSubview:self.grayView];
        //状态
        self.typeLabel = [[UILabel alloc]init];
        self.typeLabel.font = FONT(14);
        self.typeLabel.textAlignment = NSTextAlignmentCenter;
        self.typeLabel.textColor = HBSColor(128, 128, 128);
        self.typeLabel.backgroundColor = HBSRandomColor;
        [self.grayView addSubview:self.typeLabel];
        //地址image
        self.addressImage = [[UIImageView alloc]init];
        [self.addressImage setImage:[UIImage imageNamed:@"address"]];
        [self addSubview:self.addressImage];
        //收货姓名
        self.shouNameLabel = [[UILabel alloc]init];
        self.shouNameLabel.font = FONT(14);
        self.shouNameLabel.textColor = HEISE;
        self.shouNameLabel.backgroundColor = HBSRandomColor;
        [self addSubview:self.shouNameLabel];
        //收货地址
        self.shouAddressLabel = [[UILabel alloc]init];
        self.shouAddressLabel.font = FONT(14);
        self.shouAddressLabel.textColor = HBSColor(102, 102, 102);
        self.shouAddressLabel.backgroundColor = HBSRandomColor;
        [self addSubview:self.shouAddressLabel];
        //灰线
        self.grayLabel = [[UILabel alloc]init];
        self.grayLabel.backgroundColor = HBSColor(229, 229, 229);
        [self addSubview:self.grayLabel];
        //店铺名称
        self.shopNameLabel = [[UILabel alloc]init];
        self.shopNameLabel.textColor = HEISE;
        self.shopNameLabel.font = FONT(13);
        self.shopNameLabel.text = @"城祥傻逼点";
        self.shopNameLabel.backgroundColor = HBSRandomColor;
        [self addSubview:self.shopNameLabel];
        
    }
    
    return self;
}
#pragma mark----布局
- (void)layoutSubviews{
    
    [super layoutSubviews];

    [self.grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self).offset(1);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 65));
        
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.grayView).offset(20);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 15));
        
    }];
    
    [self.addressImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self).offset(10);
        make.top.mas_equalTo(self.grayView).offset(89);
        make.size.mas_equalTo(CGSizeMake(18, 25));
        
    }];
    
    [self.shouNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.grayView).offset(80);
        make.left.mas_equalTo(self).offset(46);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 60, 15));
        
    }];
    
    [self.shouAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.shouNameLabel).offset(30);
        make.left.mas_equalTo(self).offset(46);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 60, 15));
        
    }];
    
    [self.grayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.shouAddressLabel).offset(30);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 5));
        
    }];
    
    [self.shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self).offset(10);
        make.top.mas_equalTo(self.grayLabel).offset(20);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 20, 15));
        
    }];
    
}
#pragma mark----赋值
- (void)setGoodHeaderDic:(NSMutableDictionary *)goodHeaderDic{
    
    _goodHeaderDic = goodHeaderDic;
    self.typeLabel.text = goodHeaderDic[@"order_status"];
    self.shouNameLabel.text = [NSString stringWithFormat:@"收货人: %@           %@",goodHeaderDic[@"consignee_name"], goodHeaderDic[@"consignee_phone"]];
    NSMutableAttributedString *addressLabel = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"收货地址: %@", goodHeaderDic[@"consignee_address"]]];
    [addressLabel addAttribute:NSForegroundColorAttributeName value:HEISE range:NSMakeRange(0, 5)];
    self.shouAddressLabel.attributedText = addressLabel;
    self.shopNameLabel.text = goodHeaderDic[@"order_store_name"];
    
}

@end
