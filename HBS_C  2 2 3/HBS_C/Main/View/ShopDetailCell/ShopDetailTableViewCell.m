//
//  ShopDetailTableViewCell.m
//  HBS_C
//
//  Created by wangzuowen on 16/10/31.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "ShopDetailTableViewCell.h"
#import "NinePictureCollectionViewCell.h"


@interface ShopDetailTableViewCell()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong)UILabel *monthLabel;
@property (nonatomic, strong)UILabel *dayLabel;
@property (nonatomic, strong)UILabel *timeLabel;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *contentLabel;

@end
@implementation ShopDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _monthLabel = [[UILabel alloc] init];
        _monthLabel.font = FONT(13);
        _monthLabel.textColor = yiwusanColor;
        [self.contentView addSubview:_monthLabel];
        
        _dayLabel = [[UILabel alloc] init];
        _dayLabel.font = FONT(23);
        _dayLabel.textColor = HEISE;
        [self.contentView addSubview:_dayLabel];
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = FONT(13);
        _timeLabel.textColor = yiwusanColor;
        [self.contentView addSubview:_timeLabel];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = FONT(14);
        _titleLabel.textColor = HEISE;
        [self.contentView addSubview:_titleLabel];
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = FONT(13);
        _contentLabel.numberOfLines = 0;
        _contentLabel.textColor = yilingerColor;
        [self.contentView addSubview:_contentLabel];

        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake((WIDTH - 48 - 30) / 3, (WIDTH - 48 - 30) / 3);
        flowLayout.minimumLineSpacing = 10;
        flowLayout.minimumInteritemSpacing = 10;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH - 30, self.height) collectionViewLayout:flowLayout];
        _collectionView.userInteractionEnabled = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
                _collectionView.delegate = self;
                _collectionView.dataSource = self;
        _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [_collectionView registerClass:[NinePictureCollectionViewCell class] forCellWithReuseIdentifier:@"collcell"];
        [self.contentView addSubview:_collectionView];

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.dayLabel.frame = CGRectMake(10, 15, 30, 30);
    self.monthLabel.frame = CGRectMake(_dayLabel.x, _dayLabel.y + _dayLabel.height, _dayLabel.width, 20);
    self.timeLabel.frame = CGRectMake(_dayLabel.x + _dayLabel.width + 8, _dayLabel.y + _dayLabel.height - 20, 100, 20);
    self.titleLabel.frame = CGRectMake(_timeLabel.x, _timeLabel.y + _timeLabel.height + 5, WIDTH - (_timeLabel.x + 10), 20);
    CGFloat ff = [TextAdapter HeightWithText:self.dataDic[@"article_content"] width:WIDTH - (_timeLabel.x + 10) font:13];
    self.contentLabel.frame = CGRectMake(_titleLabel.x, _titleLabel.y + _titleLabel.height + 15, WIDTH - (_timeLabel.x + 10), ff);
    
    
    self.collectionView.frame = CGRectMake(_contentLabel.x, _contentLabel.y + _contentLabel.height + 15, (WIDTH - 56 * WSHIPEI), self.height - (82 + ff));
}

- (void)setDataDic:(NSDictionary *)dataDic
{
    if (_dataDic != dataDic) {
        _dataDic = dataDic;
    }
    self.dayLabel.text = dataDic[@"add_day"];
    self.monthLabel.text = dataDic[@"add_month"];
    self.timeLabel.text = dataDic[@"add_hour"];
    self.titleLabel.text = dataDic[@"article_title"];
    self.contentLabel.text = dataDic[@"article_content"];
}
- (void)setDatasource:(id<UICollectionViewDataSource>)datasource
{
    [self.collectionView setDataSource:datasource];
}
- (void)setDelegate:(id<UICollectionViewDelegate>)delegate
{
    [self.collectionView setDelegate:delegate];
}
#pragma mark - collectionView delegate & dataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.tt;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NinePictureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collcell" forIndexPath:indexPath];
    cell.imageUrl = self.dataDic[@"article_images"][indexPath.row][@"img"];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"---%ld---", indexPath.item);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
