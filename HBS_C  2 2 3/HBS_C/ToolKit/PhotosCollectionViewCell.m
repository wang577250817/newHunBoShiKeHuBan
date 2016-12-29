//
//  PhotosCollectionViewCell.m
//  collectionView轮播图
//
//  Created by Marx on 15/11/24.
//  Copyright © 2015年 RenCheng. All rights reserved.
//

#import "PhotosCollectionViewCell.h"


@interface PhotosCollectionViewCell ()
@property (nonatomic, strong)UIImageView *imageV;
@end
@implementation PhotosCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageV = [[UIImageView alloc] init];
        self.imageV.userInteractionEnabled = NO;
        [self.contentView addSubview:self.imageV];
    }
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    self.imageV.frame = layoutAttributes.bounds;
}

- (void)setImageUrl:(NSString *)imageUrl {
    
    _imageUrl = imageUrl;

    [self.imageV sd_setImageWithURL:[NSURL URLWithString:_imageUrl] placeholderImage:ZHANWEI];
    
}

@end
