//
//  ShopCityViewController.m
//  HBS_C
//
//  Created by wangzuowen on 16/10/17.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "ShopCityViewController.h"
#import "ShopCityModel.h"
#import "ShopCityCollectionViewCell.h"
#import "ShopDetailViewController.h"
#import "WebWithUrlViewController.h"

@interface ShopCityViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
{
    NSInteger tt;
}
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSMutableArray *dataArr;

@end

@implementation ShopCityViewController

- (void)dealloc
{
    self.collectionView.delegate = nil;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    TITLE = @"商家分类";
    self.view.backgroundColor = WZWwhiteColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _dataArr = [NSMutableArray array];
    [self creatCollectionView];
    
    if ([self checkWIFI]) {
        [self netWorking];
    }else{
        [self creatAlertViewOne:@"未连接网络" message:nil sureStr:@"确定" sureAction:^(id result) {
            
        }];
    }
}
- (void)netWorking
{
    
    [self showLoadingViewWithMessage];
    [HBSNetWork getUrl:[NSString stringWithFormat:@"%@store/category", HBSNetAdress] cookie:nil Result:^(id result) {
        [self removeLodingView];
        if ([result[@"code"] integerValue] == 200) {
            
            _dataArr = [ShopCityModel transformWithArray:result[@"result"]];
            
            [_collectionView reloadData];
        }
        
    }];
}
- (void)creatCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((WIDTH - 40) / 3, 120 * WSHIPEI);
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 10);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64 - 49) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerClass:[ShopCityCollectionViewCell class] forCellWithReuseIdentifier:@"cell123"];
    [self.view addSubview:self.collectionView];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ShopCityCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell123" forIndexPath:indexPath];
    cell.model = self.dataArr[indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
    WebWithUrlViewController *webVC = [[WebWithUrlViewController alloc] init];
    webVC.urlWithString = [self.dataArr[indexPath.row] cate_url];
    [self.navigationController pushViewController:webVC animated:YES];
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
