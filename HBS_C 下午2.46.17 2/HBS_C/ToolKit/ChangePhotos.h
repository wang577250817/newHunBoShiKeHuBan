//
//  ChangePhotos.h
//  collectionView轮播图
//
//  Created by Marx on 15/11/24.
//  Copyright © 2015年 RenCheng. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "WebViewController.h"

typedef void(^SKIPBLOCK)(NSInteger flag);

@interface ChangePhotos : UIView

// 图片数组
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)NSMutableArray *imageArr;
// block回调
@property (nonatomic, copy)SKIPBLOCK block;

- (void)openTimer;
- (void)closeTimer;
- (void)reloadData;
- (void)didnotSelect;
//- (void)dianji:(SKIPBLOCK *)block;
@end
