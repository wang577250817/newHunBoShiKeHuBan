//
//  TaoMarryThingCollectionViewCell.m
//  HBS_C
//
//  Created by wangzuowen on 16/10/20.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "TaoMarryThingCollectionViewCell.h"

@interface TaoMarryThingCollectionViewCell()

@property (nonatomic, strong)UIImageView *imageV;
@property (nonatomic, strong)UILabel *titleLabel;

@end
@implementation TaoMarryThingCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageV = [[UIImageView alloc] init];
        self.imageV.userInteractionEnabled = NO;
        [self.contentView addSubview:self.imageV];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = FONT(16);
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.titleLabel];
        
//        self.imageV.backgroundColor = WZWgrayColor;
//        self.titleLabel.backgroundColor = WZWorangeColor;
    }
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    self.imageV.frame = layoutAttributes.bounds;
    self.titleLabel.frame = CGRectMake(0, 0, self.contentView.width, 30);
    self.titleLabel.center = self.imageV.center;
}
- (void)setDataModel:(MainModel *)dataModel
{
    if (_dataModel != dataModel) {
        _dataModel = dataModel;
    }
    [self.imageV sd_setImageWithURL:WZWURLWithString(dataModel.cate_img) placeholderImage:ZHANWEI];
//    self.titleLabel.text = dataModel.cate_name;
}
@end
