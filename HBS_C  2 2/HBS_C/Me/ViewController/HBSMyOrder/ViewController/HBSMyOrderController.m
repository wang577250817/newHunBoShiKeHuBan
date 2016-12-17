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
@property (strong, nonatomic) IBOutlet UIImageView *leftImage;
@property (nonatomic, strong) UITableView *orderTableView;//订单tableView
@property (nonatomic, strong) NSArray<HBSOrderModel *> *orderArr;
@property (nonatomic, strong) NSArray *resultArr;//接受数据
//@property (nonatomic, strong) NSDictionary *modelStatusDic;//模型状态字典
@property (nonatomic, strong) NSString *str;

@end

@implementation HBSMyOrderController
//防止循环引用的表示
static NSString *const HBSOrderCellID = @"roder";

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
    [self.navigationController.navigationBar setHidden:YES];
    
    self.orderTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getupData];
        [self.orderTableView.mj_header endRefreshing];
        
    }];
    
    [self.orderTableView.mj_header beginRefreshing];
    self.orderTableView.mj_header.automaticallyChangeAlpha = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BAISE;
    [self setUpChildControls];
//    [self getupData];
}
#pragma mark----获取网络数据
- (void)getupData{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"sId"] = user_id_find;
    params[@"token"] = userToken;
    params[@"user_type"] = @"0";
    params[@"state"] = @"200";
    params[@"iPageItem"] = @"20";
    params[@"iPageIndex"] = @"0";
    if ([self checkWIFI]) {
        [self showLoadingViewWithMessage];
        [HBSNetWork getUrl:[NSString stringWithFormat:@"%@order?sId=%@&user_type=0&state=200&iPageItem=%@&iPageIndex=0", HBSNetAdress,params[@"sId"],params[@"iPageItem"]] paramaters:params header:nil cookie:nil Result:^(id result) {
            
            if ([result[@"code"]integerValue] == 200) {
                self.orderArr = [HBSOrderModel mj_objectArrayWithKeyValuesArray:result[@"result"]];
                
                self.resultArr = result[@"result"];
                
//                self.modelStatusDic = result[@"result"];
//                self.str = self.modelStatusDic[@"goods_num"];
                self.str = self.resultArr[0][@"order_status"];
                HBSLog(@"我用字典接受的订单%@", self.str);
                [self.orderTableView reloadData];
                [self removeLodingView];
                
            }else if ([result[@"code"]integerValue] == 400){
                
                [self alertWithTitle:@"请求失败" message:nil sure:nil cancel:nil];
                
            }
            
        }];
    }
    
}
#pragma mark----设置子控件
- (void)setUpChildControls{
    
    //返回箭头
    UITapGestureRecognizer *tapImage = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImage)];
    [self.leftImage addGestureRecognizer:tapImage];
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
        orderDetail.oederID = self.resultArr[indexPath.row][@"order_id"];
        [self.navigationController pushViewController:orderDetail animated:YES];
        
    }else{
        
        HBSGoodOrderDetailController *goodOrderDetail = [[HBSGoodOrderDetailController alloc]init];
        goodOrderDetail.goodID = self.resultArr[indexPath.row][@"order_id"];
        [self.navigationController pushViewController:goodOrderDetail animated:YES];
        
    }
    
}
#pragma mark----实现代理方法
- (void)serviceCancesOrderBtnDelegate:(HBSOrderCell *)cell WithCancesOrder:(UIButton *)btn{
    
    if ([self.str isEqualToString:@"用户取消订单"]) {
        
    NSIndexPath *indexPath = [self.orderTableView indexPathForCell:cell];
    [self.orderTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
    }
    
}
//确认完成订单
- (void)serviceSureOrderBtnDelegate:(HBSOrderCell *)cell WithSureOrder:(UIButton *)btn{
    
    self.orderTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getupData];
        [self.orderTableView.mj_header endRefreshing];
        
    }];
    
    [self.orderTableView.mj_header beginRefreshing];
    self.orderTableView.mj_header.automaticallyChangeAlpha = YES;
    
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
