//
//  HBSAnLiCell.m
//  HBS_C
//
//  Created by 王 世江 on 16/11/1.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSAnLiCell.h"
#import "HBSAnLiModel.h"

@interface HBSAnLiCell ()

@property (nonatomic, strong) UIImageView *anLiImage;//案例image
@property (nonatomic, strong) UILabel *titleLabel;//标题label
@end

@implementation HBSAnLiCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.anLiImage = [[UIImageView alloc]init];
        [self.anLiImage setImage:[UIImage imageNamed:@"backImage"]];
        [self addSubview:self.anLiImage];
        
        //标题label
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.text = @"城祥是傻逼吗城祥是傻逼城祥真的是傻逼城祥是傻逼吗城祥是傻逼城祥真的是傻逼";
        self.titleLabel.font = FONT(12);
//        self.titleLabel.backgroundColor = HBSRandomColor;
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.textColor = HBSColor(255, 255, 255);
        [self.anLiImage addSubview:self.titleLabel];
        
    }
    
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
//    self.backgroundColor = HBSRandomColor;
    [self.anLiImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self).offset(15);
        make.left.mas_equalTo(self).offset(10);
        make.right.mas_equalTo(self).offset(-10);
        make.bottom.mas_equalTo(self).offset(-10);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self.anLiImage).offset(5);
        make.bottom.mas_equalTo(self.anLiImage).offset(-10);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 35, 35));
        
    }];
    
}

- (void)setAnLiModel:(HBSAnLiModel *)anLiModel{
    
    _anLiModel = anLiModel;
    self.titleLabel.text = anLiModel.goods_name;
    [self.anLiImage sd_setImageWithURL:[NSURL URLWithString:anLiModel.goods_image] placeholderImage:ZHANWEI];
    
}

@end
