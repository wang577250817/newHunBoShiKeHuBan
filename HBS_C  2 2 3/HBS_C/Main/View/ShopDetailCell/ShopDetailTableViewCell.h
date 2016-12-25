//
//  ShopDetailTableViewCell.h
//  HBS_C
//
//  Created by wangzuowen on 16/10/31.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopDetailTableViewCell : UITableViewCell

@property (nonatomic, strong)UICollectionView *collectionView;
//@property (nonatomic, assign)id <UICollectionViewDataSource> datasource;
//@property (nonatomic, assign)id <UICollectionViewDelegate> delegate;

@property (nonatomic, assign)NSInteger tt;
@property (nonatomic, assign)CGFloat height;
@property (nonatomic, strong)NSDictionary *dataDic;

@end
