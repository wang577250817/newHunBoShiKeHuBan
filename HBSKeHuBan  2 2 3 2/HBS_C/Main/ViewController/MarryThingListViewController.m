//
//  MarryThingListViewController.m
//  HBS_C
//
//  Created by wangzuowen on 16/10/22.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "MarryThingListViewController.h"
#import "MarryThingListCollectionViewCell.h"
#import "MainModel.h"
#import "WeddingDetailViewController.h"

@interface MarryThingListViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, assign)BOOL isFresh;
@property (nonatomic, assign)NSInteger page;

@end

@implementation MarryThingListViewController

- (void)dealloc
{
//    self.collectionView.delegate = nil;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    TITLE = @"婚品列表";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _dataArr = [NSMutableArray array];
    [self creatCollectionView];
//    [self netWorking];
    _page = 0;
    _isFresh = NO;
    
}
- (void)netWorking
{
    NSMutableDictionary *dic = [@{} mutableCopy];
    if ([self.type isEqualToString:@"material"]) {
        [dic setObject:_cate_id forKey: @"goods_store_id"];
    }else{
        [dic setObject:_cate_id forKey:@"goods_cate_id"];
    }
    [dic setObject:@"material" forKey:@"goods_type"];
    [dic setObject:@"30" forKey:@"iPageItem"];
    [dic setObject:[NSString stringWithFormat:@"%ld", self.page] forKey:@"iPageIndex"];
    
    if ([self checkWIFI]) {
        [self showLoadingViewWithMessage];
        [HBSNetWork getUrl:[NSString stringWithFormat:@"%@goods", HBSNetAdress] paramaters:dic header:nil cookie:nil Result:^(id result) {
            if ([result[@"code"] integerValue] == 200) {
                _collectionView.userInteractionEnabled = YES;
                if (_isFresh){
                    [_dataArr removeAllObjects];
                }
                [_dataArr addObjectsFromArray: [MainModel transformWithArray:result[@"result"]]];
               
                [_collectionView reloadData];
                
            }else if ([result[@"code"] integerValue] == 201){
                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            }
            [self removeLodingView];
        }];
    }else{
        self.collectionView.userInteractionEnabled = NO;
        if (!self.errorImage) {
            
            [self noNetWorkView:self.view];
        }
        self.errorImage.userInteractionEnabled = YES;
        __weak typeof(self)weakself = self;
        self.freshBlock = ^(void){
            [weakself netWorking];
        };
    }
    
}
- (void)creatCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((WIDTH - 35) / 2, (WIDTH - 35) / 2 + 65);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.minimumInteritemSpacing = 15;
    layout.minimumLineSpacing = 10;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
//    self.collectionView.pagingEnabled = YES;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerClass:[MarryThingListCollectionViewCell class] forCellWithReuseIdentifier:@"cell123"];
    [self.view addSubview:self.collectionView];
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _isFresh = YES;
        [self netWorking];
        [self.collectionView.mj_header endRefreshing];
    }];
    [self.collectionView.mj_header beginRefreshing];
    self.collectionView.mj_header.automaticallyChangeAlpha = YES;
    
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(MJLoadfresh)];
    
}
- (void)MJLoadfresh
{
    //    if (self.isLoad) {
    _isFresh = NO;
    _page++;
    [self netWorking];
    [self.collectionView.mj_footer endRefreshing];
    //    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MarryThingListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell123" forIndexPath:indexPath];
    cell.model = self.dataArr[indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [_collectionView deselectItemAtIndexPath:indexPath animated:YES];
    WeddingDetailViewController *wedVC = [[WeddingDetailViewController alloc] init];
    wedVC.type = DetailTypeWedding;
    wedVC.goods_id = [self.dataArr[indexPath.row] goods_id];
    [self.navigationController pushViewController:wedVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
