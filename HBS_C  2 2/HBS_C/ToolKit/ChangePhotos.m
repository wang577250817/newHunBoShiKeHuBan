//
//  ChangePhotos.m
//  collectionView轮播图
//
//  Created by Marx on 15/11/24.
//  Copyright © 2015年 RenCheng. All rights reserved.
//

#import "ChangePhotos.h"
#import "PhotosCollectionViewCell.h"
@interface ChangePhotos () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)UIPageControl *pageControl;
@property (nonatomic, strong)NSTimer *timer;
@end
@implementation ChangePhotos


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = self.bounds.size;
        layout.minimumLineSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.tag = 6666;
        self.collectionView.pagingEnabled = YES;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.showsHorizontalScrollIndicator = NO;
        [self.collectionView registerClass:[PhotosCollectionViewCell class] forCellWithReuseIdentifier:@"cell123"];
        [self addSubview:self.collectionView];

        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
        self.pageControl.center = CGPointMake(self.collectionView.center.x, self.collectionView.center.y + self.bounds.size.height / 2 - 20);
        [self addSubview:self.pageControl];

        self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(autoChangePicture) userInfo:nil repeats:YES];
        [self.timer invalidate];
    }
    return self;
}
- (void)didnotSelect
{
    self.collectionView.allowsSelection = NO;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.dataArr) {
        self.pageControl.numberOfPages = self.dataArr.count;
        
        return 4000;
    }
    else {
        return 0;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.dataArr && _dataArr.count != 0) {
        self.pageControl.currentPage = (NSInteger)(scrollView.contentOffset.x / self.bounds.size.width) % self.dataArr.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotosCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell123" forIndexPath:indexPath];
    if (_dataArr.count != 0) {
        cell.imageUrl = self.dataArr[indexPath.item % self.dataArr.count];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.block(indexPath.item % self.dataArr.count);
    
}
- (void)setDataArr:(NSMutableArray *)dataArr {
    _dataArr = dataArr;
    [self.collectionView reloadData];
    [self.collectionView setContentOffset:CGPointMake(self.bounds.size.width * 2000, 0)];
}
- (void)autoChangePicture {
    [self.collectionView setContentOffset:CGPointMake(self.bounds.size.width + self.collectionView.contentOffset.x, 0) animated:YES];
}
- (void)reloadData
{
    [self.collectionView reloadData];
}

- (void)openTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(autoChangePicture) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}
- (void)closeTimer {
    if (self.timer.isValid) {
        [self.timer invalidate];
//        [self.timer setFireDate:[NSDate distantFuture]];
    }
}

@end
