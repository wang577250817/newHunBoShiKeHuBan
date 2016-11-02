//
//  HBSShopsCell.m
//  HBS_C
//
//  Created by 王 世江 on 16/11/1.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSShopsCell.h"

@interface HBSShopsCell ()

@property (nonatomic, strong) UIImageView *shopImage;//商品image
@property (nonatomic, strong) UILabel *contentLabel;//内容label
@property (nonatomic, strong) UILabel *severLabel;//服务label
@property (nonatomic, strong) UILabel *severNumLabel;//服务人数label
@property (nonatomic, strong) UILabel *addressLabel;//地址label
@end


@implementation HBSShopsCell
#pragma mark----初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.shopImage = [[UIImageView alloc]init];
        [self.shopImage setImage:[UIImage imageNamed:@"backImage"]];
        [self addSubview:self.shopImage];
        
        //内容label
        self.contentLabel = [[UILabel alloc]init];
        self.contentLabel.text = @"城祥是傻逼吗城祥是傻逼城祥真的是傻逼城祥是傻逼吗城祥是傻逼城祥真的是傻逼";
        self.contentLabel.font = FONT(14);
        self.contentLabel.backgroundColor = HBSRandomColor;
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.textColor = HEISE;
        [self addSubview:self.contentLabel];
        
        //服务label
        self.severLabel = [[UILabel alloc]init];
        self.severLabel.text = @"服务";
        self.severLabel.font = FONT(12);
        self.severLabel.textColor = HBSColor(153, 153, 153);
        self.severLabel.backgroundColor = HBSRandomColor;
        [self addSubview:self.severLabel];
        
        //服务人数label
        self.severNumLabel = [[UILabel alloc]init];
        self.severNumLabel.text = @"11";
        self.severNumLabel.textColor = HBSColor(153, 153, 153);
        self.severNumLabel.font = FONT(12);
        self.severNumLabel.backgroundColor = HBSRandomColor;
        [self addSubview:self.severNumLabel];
        
        //地址label
        self.addressLabel = [[UILabel alloc]init];
        self.addressLabel.text = @"柯桥区";
        self.addressLabel.textColor = HBSColor(153, 153, 153);
        self.addressLabel.font = FONT(12);
        self.addressLabel.textAlignment = NSTextAlignmentRight;
        self.addressLabel.backgroundColor = HBSRandomColor;
        [self addSubview:self.addressLabel];
        
        
    }
    return self;
    
}

#pragma mark----布局
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.backgroundColor = HBSRandomColor;
    [self.shopImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self).offset(15);
        make.left.mas_equalTo(self).offset(10);
        make.size.mas_equalTo(CGSizeMake(92, 92));
        
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.shopImage).offset(107);
        make.top.mas_equalTo(self).offset(15);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 120, 35));
        
        
    }];
    
    [self.severLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self.shopImage).offset(107);
        make.top.mas_equalTo(self.contentLabel).offset(71);
        make.size.mas_equalTo(CGSizeMake(25, 15));
        
    }];
    
    [self.severNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.severLabel).offset(25);
        make.top.mas_equalTo(self.contentLabel).offset(71);
        make.size.mas_equalTo(CGSizeMake(60, 15));
        
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.contentLabel).offset(71);
        make.right.mas_equalTo(self).offset(-10);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 220, 15));
        
    }];
    
}
//重写set方法
- (void)setFrame:(CGRect)frame{
    
    frame.size.height -= 1;
    [super setFrame:frame];
}

@end
