//
//  NinePictureCollectionViewCell.m
//  Dr.hun
//
//  Created by wangzuowen on 16/7/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "NinePictureCollectionViewCell.h"

@interface NinePictureCollectionViewCell()

@property (nonatomic, strong)UIImageView *imageinfo;

@end

@implementation NinePictureCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.imageinfo = [[UIImageView alloc] init];
        self.imageinfo.userInteractionEnabled = NO;
        self.imageinfo.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.imageinfo];
    }
    return self;
}

- (void)setImageUrl:(NSString *)imageUrl {
    _imageUrl = imageUrl;
    [_imageinfo sd_setImageWithURL:WZWURLWithString(imageUrl) placeholderImage:ZHANWEI];
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    _imageinfo.frame = layoutAttributes.bounds;
}

@end
