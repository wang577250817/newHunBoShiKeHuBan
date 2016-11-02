//
//  HBSMarriageController.m
//  HBS_C
//
//  Created by 王 世江 on 16/10/31.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSMarriageController.h"
#import "HBSMarriageCell.h"

@interface HBSMarriageController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong)UICollectionView *collectionView;

@end

@implementation HBSMarriageController
//循环利用的标识
static NSString *const HBSMarriageCellID = @"marriage";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BAISE;
    [self setupCollection];
}
#pragma mark----tableView的相关方法
- (void)setupCollection
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((WIDTH - 35) / 2, (WIDTH - 35) / 2 + 65);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.minimumInteritemSpacing = 15;
    layout.minimumLineSpacing = 10;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 64) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerClass:[HBSMarriageCell class] forCellWithReuseIdentifier:HBSMarriageCellID];
    [self.view addSubview:self.collectionView];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HBSMarriageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HBSMarriageCellID forIndexPath:indexPath];

    return cell;
}
@end
