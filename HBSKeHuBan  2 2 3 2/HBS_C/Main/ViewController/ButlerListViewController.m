//
//  ButlerListViewController.m
//  HBS_C
//
//  Created by wangzuowen on 16/10/21.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "ButlerListViewController.h"
#import "ButlerListTableViewCell.h"
#import "MainModel.h"
#import "ShopDetailViewController.h"
#import "WebWithUrlViewController.h"

@interface ButlerListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, assign)BOOL isFresh;
@property (nonatomic, assign)BOOL isLoad;
@property (nonatomic, assign)NSInteger page;
@property (nonatomic, strong)NSArray *headerArr;

@end

@implementation ButlerListViewController

- (void)dealloc
{
    self.tableView.delegate = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    TITLE = @"管家列表";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _dataArr = [NSMutableArray array];
    _headerArr = [NSMutableArray array];
    
    [self creatTableView];
    
//    [self netWorking];
    _isFresh = NO;
    _page = 0;
//    _isLoad = NO;
}
- (void)netWorking
{
    if ([self checkWIFI]) {
        [self showLoadingViewWithMessage];
        NSDictionary *dic = @{@"iPageIndex":[NSString stringWithFormat:@"%ld", self.page]};
        [HBSNetWork getUrl:[NSString stringWithFormat:@"%@store/butler", HBSNetAdress] paramaters:dic header:nil cookie:nil Result:^(id result) {
            if ([result[@"code"] integerValue] == 200) {
                _tableView.userInteractionEnabled = YES;
                if (_isFresh) {
                    [_dataArr removeAllObjects];
                }
//                _isLoad = YES;
                [_dataArr addObjectsFromArray:[MainModel transformWithArray:result[@"result"][@"butler_list"]]];
                _headerArr = result[@"result"][@"banner_list"];
                [self setUp_HeaderView];
                [_tableView reloadData];
            }else if ([result[@"code"] integerValue] == 201){
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            [self removeLodingView];
        }];
    }else{
        self.tableView.userInteractionEnabled = NO;
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
- (void)creatTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = NO;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _isFresh = YES;
        [self netWorking];
        [self.tableView.mj_header endRefreshing];
    }];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(MJLoadfresh)];
    
}
- (void)setUp_HeaderView
{
    UIImageView *headerImage = ImageAlloc(0, 0, WIDTH, 117*HSHIPEI);
    [headerImage sd_setImageWithURL:WZWURLWithString(self.headerArr[0][@"adv_image"]) placeholderImage:ZHANWEI];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerAction)];
    [headerImage addGestureRecognizer:tap];
    headerImage.userInteractionEnabled = YES;
    self.tableView.tableHeaderView = headerImage;
}
- (void)headerAction
{
    WebWithUrlViewController *webView = [[WebWithUrlViewController alloc] init];
    webView.title = @"管家介绍";
    webView.urlWithString = self.headerArr[0][@"adv_url"];
    [self.navigationController pushViewController:webView animated:YES];
}
- (void)MJLoadfresh
{
//    if (self.isLoad) {
        self.isFresh = NO;
        _page++;
        [self netWorking];
        [self.tableView.mj_footer endRefreshing];
//    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainModel *model = self.dataArr[indexPath.row];
    if (model.store_images.count == 0) {
        return 145;
    }else{
        return 223;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellStr = @"cell";
    ButlerListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (!cell) {
        cell = [[ButlerListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    
    cell.model = self.dataArr[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    ShopDetailViewController *shopVC = [[ShopDetailViewController alloc] init];
    MainModel *model = self.dataArr[indexPath.row];
    shopVC.story_id = model.store_id;
    [self.navigationController pushViewController:shopVC animated:YES];

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
