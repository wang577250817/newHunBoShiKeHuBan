//
//  TaoMarryThingViewController.m
//  HBS_C
//
//  Created by wangzuowen on 16/10/20.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "TaoMarryThingViewController.h"
#import "TaoMarryThingCollectionViewCell.h"
#import "MainModel.h"
#import "MarryThingListViewController.h"

@interface TaoMarryThingViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSMutableArray *dataArr;

@end

@implementation TaoMarryThingViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.tabBarController.tabBar.hidden = YES;
}
- (void)dealloc
{
    self.collectionView.delegate = nil;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    TITLE = @"淘婚品";
    self.view.backgroundColor = BEIJINGSE;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _dataArr = [NSMutableArray array];
    
    [self creatCollectionView];
    [self netWorking];
    
//    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [backButton setImage:[UIImage imageNamed:@"icon_fanhuijiantou@2x"] forState:UIControlStateNormal];
//    [backButton sizeToFit];
//    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0); // 这里微调返回键的位置
//    self.navigationController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
//
}
//- (void)back
//{
//    self.navigationController.
//    [self.navigationController popViewControllerAnimated:YES];
//}
- (void)netWorking
{
    if ([self checkWIFI]) {
        
        [self showLoadingViewWithMessage];
        [HBSNetWork getUrl:[NSString stringWithFormat:@"%@goods/category", HBSNetAdress] cookie:nil Result:^(id result) {
            if ([result[@"code"] integerValue] == 200) {
                self.collectionView.userInteractionEnabled = YES;
                _dataArr = [MainModel transformWithArray:result[@"result"]];
                
                [_collectionView reloadData];
            }
            [self removeLodingView];
        }];
    }else{
        [self noNetWorkView:self.view];
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
    layout.itemSize = CGSizeMake((WIDTH - 3) / 2, (WIDTH - 3) / 2);
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumInteritemSpacing = 3;
    layout.minimumLineSpacing = 1;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
//    self.collectionView.pagingEnabled = YES;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerClass:[TaoMarryThingCollectionViewCell class] forCellWithReuseIdentifier:@"cell123"];
    [self.view addSubview:self.collectionView];

}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TaoMarryThingCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell123" forIndexPath:indexPath];
    cell.dataModel = self.dataArr[indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
    MarryThingListViewController *listVC = [[MarryThingListViewController alloc] init];
    listVC.cate_id = [self.dataArr[indexPath.row] cate_id];
    [self.navigationController pushViewController:listVC animated:YES];
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
