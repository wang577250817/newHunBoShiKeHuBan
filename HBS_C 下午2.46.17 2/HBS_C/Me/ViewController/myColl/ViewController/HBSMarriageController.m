//
//  HBSMarriageController.m
//  HBS_C
//
//  Created by 王 世江 on 16/10/31.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSMarriageController.h"
#import "HBSMarriageCell.h"
#import "HBSMarriageModel.h"

@interface HBSMarriageController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *marriageArr;

@end

@implementation HBSMarriageController
//循环利用的标识
static NSString *const HBSMarriageCellID = @"marriage";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BAISE;
    [self setupCollection];
    [self getupData];
}
#pragma mark----获取网路数据
- (void)getupData{
    
    NSMutableDictionary *paramas = [NSMutableDictionary dictionary];
    paramas[@"id"] = user_id_find;
    paramas[@"user_token"] = @"123456";
    paramas[@"user_collect_type"] = @"goods";
    paramas[@"iPageItem"] = @"20";
    paramas[@"iPageIndex"] = @"0";
    [HBSNetWork getUrl:[NSString stringWithFormat:@"%@user/1036/collect?user_collect_type=goods&iPageItem=20&iPageIndex=0", HBSNetAdress] paramaters:paramas header:nil cookie:nil Result:^(id result) {
       
        if ([result[@"code"]integerValue] == 200) {
            
            self.marriageArr = [HBSMarriageModel mj_objectArrayWithKeyValuesArray:result[@"result"]];
            [self.collectionView reloadData];
            
            HBSLog(@"%@", result);
            
        }else if ([result[@"code"]integerValue] == 400){
            
            UIImageView *backImage = [[UIImageView alloc]init];
            [backImage setImage:[UIImage imageNamed:@"img_1_guanjia"]];
            backImage.frame = CGRectMake(0, 0, WIDTH, HEIGHT-110);
            [self.view addSubview:backImage];
            HBSLog(@"1234567890%@", result[@"result"]);
        }
        
    }];
    
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
    return self.marriageArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HBSMarriageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HBSMarriageCellID forIndexPath:indexPath];
    cell.marriageModel = self.marriageArr[indexPath.row];

    return cell;
}
@end
