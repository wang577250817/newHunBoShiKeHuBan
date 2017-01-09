//
//  HBSMyOrderController.m
//  HBS_C
//
//  Created by 王 世江 on 16/11/4.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSMyOrderController.h"
#import "HBSOrderCell.h"
#import "HBSOrderModel.h"
#import "HBSOrderDetailsController.h"
#import "HBSGoodOrderDetailController.h"
#import "PayMoneyViewController.h"

@interface HBSMyOrderController ()<UITableViewDelegate, UITableViewDataSource, serviceCancesOrderBtnDelegate>
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UITableView *orderTableView;//订单tableView
@property (nonatomic, strong) NSMutableArray<HBSOrderModel *> *orderArr;
@property (nonatomic, strong) NSArray *resultArr;//接受数据
@property (nonatomic, assign) NSInteger page;

@end

@implementation HBSMyOrderController
//防止循环引用的表示
static NSString *const HBSOrderCellID = @"roder";

#pragma mark---懒加载

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
    [self.navigationController.navigationBar setHidden:YES];
    
    [self getupData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BAISE;
    [self setUpChildControls];
    
    _page = 1;
    
}
#pragma mark----获取网络数据
- (void)getupData{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"sId"] = [ProjectCache getLoginMessage][@"user_id"];
    params[@"token"] = userToken;
    params[@"user_type"] = @"0";
    params[@"state"] = @"200";
    params[@"iPageItem"] = @"30";
    params[@"iPageIndex"] = @"0";
    __weak typeof (self) weakSelf = self;
    if ([self checkWIFI]) {
        [self showLoadingViewWithMessage];
        [HBSNetWork getUrl:[NSString stringWithFormat:@"%@order?sId=%@&user_type=0&state=200&iPageItem=%@&iPageIndex=%@", HBSNetAdress,params[@"sId"],params[@"iPageItem"], params[@"iPageIndex"]] paramaters:params header:nil cookie:nil Result:^(id result) {
            
            if ([result[@"code"]integerValue] == 200) {
                
                weakSelf.orderTableView.userInteractionEnabled = YES;
                
                weakSelf.orderArr = [HBSOrderModel mj_objectArrayWithKeyValuesArray:result[@"result"]];
                
                weakSelf.resultArr = result[@"result"];
                //                HBSLog(@"我用字典接受的订单%@", self.resultArr[0]);
                [weakSelf.orderTableView reloadData];
                
                
            }else if ([result[@"code"]integerValue] == 201){
                
                HBSLog(@"没有该类订单");
                
                UIImageView *backImage = [[UIImageView alloc]init];
                [backImage setImage:[UIImage imageNamed:@"tu"]];
                backImage.frame = CGRectMake(0, 64, WIDTH, HEIGHT-110);
                [self.view addSubview:backImage];
                
            }else if ([result[@"code"]integerValue] == 400){
                
                [self alertWithTitle:@"请求失败" message:nil sure:nil cancel:nil];
            }
            
            [weakSelf removeLodingView];
            
        }];
    }else{
        
        self.orderTableView.userInteractionEnabled = NO;
        if (!self.errorImage) {
            [self noNetWorkView:self.view];
        }
        
        self.errorImage.userInteractionEnabled = YES;
        __weak typeof(self)weakself = self;
        self.freshBlock = ^(void){
            [weakself getupData];
            
        };
        
    }
}
#pragma mark----设置子控件
- (void)setUpChildControls{
    
    //返回箭头
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.leftBtn.frame = CGRectMake(0, 20, 30, 35);
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_fanhuijiantou"] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(clickImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.leftBtn];
    //订单tableView
    self.orderTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 66, WIDTH, HEIGHT - 66) style:UITableViewStylePlain];
    self.orderTableView.backgroundColor = HBSColor(244, 244, 243);
    self.orderTableView.separatorStyle = UITableViewCellAccessoryNone;
    //    self.orderTableView.rowHeight = 120;
    self.orderTableView.delegate = self;
    self.orderTableView.dataSource = self;
    [self.view addSubview:self.orderTableView];
    
    //注册
    [self.orderTableView registerClass:[HBSOrderCell class] forCellReuseIdentifier:HBSOrderCellID];
    
    self.orderTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        //        [self getupData];
        [self.orderTableView.mj_header endRefreshing];
        
    }];
    
    [self.orderTableView.mj_header beginRefreshing];
    self.orderTableView.mj_header.automaticallyChangeAlpha = YES;
    self.orderTableView.mj_footer = [HBSRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(MJLoadfresh)];
    
}
- (void)MJLoadfresh
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"sId"] = [ProjectCache getLoginMessage][@"user_id"];
    params[@"token"] = userToken;
    params[@"user_type"] = @"0";
    params[@"state"] = @"200";
    params[@"iPageItem"] = @"30";
    params[@"iPageIndex"] = [NSString stringWithFormat:@"%ld", self.page++];
    
    __weak typeof (self) weakSelf = self;
    if ([self checkWIFI]) {
        [self showLoadingViewWithMessage];
        [HBSNetWork getUrl:[NSString stringWithFormat:@"%@order?sId=%@&user_type=0&state=200&iPageItem=%@&iPageIndex=%@", HBSNetAdress,params[@"sId"],params[@"iPageItem"], params[@"iPageIndex"]] paramaters:params header:nil cookie:nil Result:^(id result) {
            
            if ([result[@"code"]integerValue] == 200) {
                
                NSMutableArray *moreComments = [HBSOrderModel mj_objectArrayWithKeyValuesArray:result[@"result"]];
                [weakSelf.orderArr addObjectsFromArray:moreComments];
                
                [weakSelf.orderTableView reloadData];
                [weakSelf.orderTableView.mj_footer endRefreshing];
                
                
            }else if ([result[@"code"] integerValue] == 201){
                [self.orderTableView.mj_footer endRefreshingWithNoMoreData];
            }
            [self removeLodingView];
        }];
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.orderArr.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HBSOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:HBSOrderCellID];
    cell = [[HBSOrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HBSOrderCellID];
    cell.orderModel = self.orderArr[indexPath.row];
    cell.delegate = self;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.orderArr[indexPath.row].cellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    if ([self.resultArr[indexPath.row][@"order_type"]isEqualToString:@"service"]) {
        
        HBSOrderDetailsController *orderDetail = [[HBSOrderDetailsController alloc]init];
        orderDetail.oederID = self.resultArr[indexPath.row][@"order_ids"];
        [self.navigationController pushViewController:orderDetail animated:YES];
        
    }else{
        
        HBSGoodOrderDetailController *goodOrderDetail = [[HBSGoodOrderDetailController alloc]init];
        goodOrderDetail.goodID = self.resultArr[indexPath.row][@"order_ids"];
        [self.navigationController pushViewController:goodOrderDetail animated:YES];
    }
    
}
#pragma mark----取消订单实现代理方法
- (void)serviceCancesOrderBtnDelegate:(HBSOrderCell *)cell WithCancesOrder:(UIButton *)btn{
    
    //    NSIndexPath *indexPath = [self.orderTableView indexPathForCell:cell];
    //    HBSOrderModel *cancelModel = self.resultArr[indexPath.row];
    //
    //    cancelModel.order_status_id  = @"0";
    //    [self.orderTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
    
    [self getupData];
    
}
#pragma mark----确认完成服务实现代理方法
- (void)serviceSureOrderBtnDelegate:(HBSOrderCell *)cell WithSureOrder:(UIButton *)btn{
    
    [self getupData];
    
}
#pragma mark----确认收货实现代理方法
- (void)goodsSureHasFaHuoBtnDelegate:(HBSOrderCell *)cell WithSureGoodsOrder:(UIButton *)btn{
    
    [self getupData];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    
}
#pragma mark----返回箭头
- (void)clickImage{
    
    [self.navigationController popViewControllerAnimated:YES];
    [self.tabBarController.tabBar setHidden:NO];
}
@end
