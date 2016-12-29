//
//  GoodsListViewController.m
//  HBS_C
//
//  Created by wangzuowen on 16/11/3.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "GoodsListViewController.h"
#import "ShopCityModel.h"
#import "ShopDetailGoodsTableViewCell.h"
#import "WeddingDetailViewController.h"

@interface GoodsListViewController ()<UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArr;

@end

@implementation GoodsListViewController

- (void)dealloc
{
    self.tableView.delegate = nil;
}
-(instancetype)init
{
    self = [super init];
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 90.0f;
    _dataArr = [NSMutableArray new];
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    TITLE = @"服务列表";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _tableView.frame = CGRectMake(0, 64, WIDTH, HEIGHT - 64);
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    
    [self netWorking];
}

- (void)netWorking
{
    NSDictionary *dic = @{@"goods_store_id":self.store_id,@"goods_cate_id":@"", @"goods_type":self.type, @"iPageItem":@"30", @"iPageIndex":@"0"};
    if ([self checkWIFI]) {
        [self showLoadingViewWithMessage];
        [HBSNetWork getUrl:[NSString stringWithFormat:@"%@goods", HBSNetAdress] paramaters:dic header:nil cookie:nil Result:^(id result) {
            if ([result[@"code"] integerValue] == 200) {
                _dataArr = [ShopCityModel transformWithArray:result[@"result"]];
                
                [_tableView reloadData];
                [self removeLodingView];
            }
            
        }];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"cell";
    ShopDetailGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[ShopDetailGoodsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.model = self.dataArr[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    WeddingDetailViewController *weedVC = [[WeddingDetailViewController alloc] init];
    weedVC.goods_id = [self.dataArr[indexPath.row] goods_id];
    weedVC.type = DetailTypeGoods;
    [self.navigationController pushViewController:weedVC animated:YES];
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
