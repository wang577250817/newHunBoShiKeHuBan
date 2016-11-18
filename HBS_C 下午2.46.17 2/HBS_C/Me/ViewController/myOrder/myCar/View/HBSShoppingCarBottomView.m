
//
//  HBSShoppingCarBottomView.m
//  HBS_C
//
//  Created by 王 世江 on 16/11/14.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSShoppingCarBottomView.h"
#import "HBSMyCarBottomModel.h"

@interface HBSShoppingCarBottomView ()
@property (nonatomic, strong) UILabel *allSelectLabel;//全选label
@property (nonatomic, strong) UIButton *endNumBtn;//最终件数

@end

@implementation HBSShoppingCarBottomView
#pragma mark----初始化
- (instancetype)initWithFrame:(CGRect)frame With:(HBSMyCarBottomModel *)bottomModel{
    
    self = [super initWithFrame:frame];
    if (self) {
        //全选按钮
//        self.allSelectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.allSelectBtn = [[UIButton alloc]init];
        [self.allSelectBtn setImage:[UIImage imageNamed:@"icon_1_2_xuanzekuang"] forState:UIControlStateNormal];
        [self.allSelectBtn setImage:[UIImage imageNamed:@"icon_1_2_xuanzhonghong"] forState:UIControlStateSelected];
        self.allSelectBtn.selected = bottomModel.isSelect;
        [self.allSelectBtn addTarget:self action:@selector(allSelectClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.allSelectBtn];
        //全选label
        UILabel *allSelectLabel = [[UILabel alloc]init];
        allSelectLabel.font = FONT(12);
        allSelectLabel.textColor = HEISE;
        allSelectLabel.text = @"全选";
        allSelectLabel.textAlignment = 0;
        allSelectLabel.backgroundColor = HBSRandomColor;
        [self addSubview:allSelectLabel];
        self.allSelectLabel = allSelectLabel;
        //全选label
        self.resultPriceLabel = [[UILabel alloc]init];
        self.resultPriceLabel.font = FONT(12);
        self.resultPriceLabel.textColor = FENSE;
        self.resultPriceLabel.textAlignment = 0;
        self.resultPriceLabel.backgroundColor = HBSRandomColor;
        self.resultPriceLabel.text = bottomModel.priceText;
        [self addSubview:self.resultPriceLabel];
        //最终件数
        self.endNumBtn = [[UIButton alloc]init];
        self.endNumBtn.backgroundColor = FENSE;
        NSString *endStr = [NSString stringWithFormat:@"去结算(共%d件)",bottomModel.counts];
        self.endNumBtn.titleLabel.font = FONT(15);
        [self.endNumBtn setTitle:endStr forState:UIControlStateNormal];
        [self addSubview:self.endNumBtn];
        
        
    }
    
    return self;
}
#pragma mark----布局
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.allSelectBtn.frame = CGRectMake(10, 10, 18, 18);
    self.allSelectLabel.frame = CGRectMake(10, 32, 45, 15);
    self.resultPriceLabel.frame = CGRectMake(70, 10, 120, 30);
    self.endNumBtn.frame = CGRectMake(220, 0, WIDTH -220, 50);
    
}
#pragma mark----全选按钮
- (void)allSelectClick:(UIButton *)sender{
    
    if ([self.delegate respondsToSelector:@selector(HBSShoppingCarBottomViewDelegate:)]) {
        
        [self.delegate HBSShoppingCarBottomViewDelegate:sender];
        
    }
}
@end
