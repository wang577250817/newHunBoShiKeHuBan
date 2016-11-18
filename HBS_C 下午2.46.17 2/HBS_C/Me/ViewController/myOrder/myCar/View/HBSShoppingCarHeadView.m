//
//  HBSShoppingCarHeadView.m
//  HBS_C
//
//  Created by 王 世江 on 16/11/13.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSShoppingCarHeadView.h"
#import "HBSMyCarHeaderModel.h"

@interface HBSShoppingCarHeadView ()

@property (nonatomic, strong) UILabel *storeTitleLabel;//店名
@property (nonatomic, strong) UILabel *grayLabel;//灰线

@end

@implementation HBSShoppingCarHeadView
#pragma mark----初始化
- (instancetype)initWithFrame:(CGRect)frame WithSection:(NSInteger)section HeadModel:(HBSMyCarHeaderModel *)model{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        //全选按钮
        self.selectAllBtn = [[UIButton alloc]init];
        [self.selectAllBtn setImage:[UIImage imageNamed:@"icon_1_2_xuanzekuang"] forState:UIControlStateNormal];
        [self.selectAllBtn setImage:[UIImage imageNamed:@"icon_1_2_xuanzhonghong"] forState:UIControlStateSelected];
        [self.selectAllBtn addTarget:self action:@selector(allClick:) forControlEvents:UIControlEventTouchUpInside];
        self.selectAllBtn.selected = model.isSelect;
        self.selectAllBtn.tag = section + 1000;
        [self addSubview:self.selectAllBtn];
        
        //店名
        self.storeTitleLabel = [[UILabel alloc]init];
        self.storeTitleLabel.text = model.store_name;
        self.storeTitleLabel.font = FONT(15);
        self.storeTitleLabel.textColor = HEISE;
        self.storeTitleLabel.backgroundColor = HBSRandomColor;
        [self addSubview:self.storeTitleLabel];
        
        //灰线
        self.grayLabel = [[UILabel alloc]init];
        self.grayLabel.backgroundColor = [UIColor redColor];
        [self addSubview:self.grayLabel];
        
        
    }
    
    return self;
}
#pragma mark----布局
- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.storeTitleLabel.frame = CGRectMake(43, 15, WIDTH - 100, 15);
    self.grayLabel.frame = CGRectMake(0, 45, WIDTH, 1);
    self.selectAllBtn.frame = CGRectMake(10, 15, 18, 18);
}

- (void)allClick:(UIButton *)btn{
    
    if ([self.delegate respondsToSelector:@selector(HBSShoppingCarHeaderViewDelegate:WithHeadView:)]) {
        
        [self.delegate HBSShoppingCarHeaderViewDelegate:btn WithHeadView:self];
    }
    
}
@end
