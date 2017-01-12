//
//  HBSGoodOrderDetailController.m
//  HBS_C
//
//  Created by 王 世江 on 16/11/9.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSGoodOrderDetailController.h"
#import "HBSGoodOrderCell.h"
#import "HBSHeaderView.h"
#import "HBSGoodModel.h"
#import "HBSFooterView.h"
#import "HBSContactUsController.h"
@interface HBSGoodOrderDetailController ()<UITableViewDelegate, UITableViewDataSource, phoneCallDelegate>
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UITableView *orderGoodTableView;
@property (nonatomic, strong) NSMutableArray<HBSGoodModel *> *goodArr;
@property (nonatomic, strong) NSMutableDictionary *goodDic;
@property (nonatomic, strong) HBSHeaderView *headerView;//头部视图
@property (nonatomic, strong) HBSFooterView *footerView;//尾部视图
@property (nonatomic, strong) NSString *phoneStr;//接受电话的str
@property (nonatomic, strong) NSString *talkStr;//聊天id
@property (nonatomic, strong) NSString *storeNameStr;//店名
@end
@implementation HBSGoodOrderDetailController
static NSString *const HBSGoodOrderCellID = @"good";

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BAISE;
    [self setUpChildControls];
    [self getData];
}
#pragma mark----设置子控件
- (void)setUpChildControls{
    
    //返回箭头
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.leftBtn.frame = CGRectMake(0, 20, 30, 35);
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_fanhuijiantou"] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(clickImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.leftBtn];
    //商品订单详情tableView
    self.orderGoodTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 62, WIDTH, HEIGHT - 66) style:UITableViewStylePlain];
    self.orderGoodTableView.backgroundColor = HBSColor(244, 244, 243);
    self.orderGoodTableView.separatorStyle = UITableViewCellAccessoryNone;
    self.orderGoodTableView.delegate = self;
    self.orderGoodTableView.dataSource = self;
    self.orderGoodTableView.rowHeight = 125;
    [self.view addSubview:self.orderGoodTableView];
    //头部视图
    self.headerView = [[HBSHeaderView alloc]init];
    self.headerView.WSJ_height = 177;
    self.orderGoodTableView.tableHeaderView = self.headerView;
    //尾部视图
    self.footerView = [[HBSFooterView alloc]init];
    self.footerView.WSJ_height = 300;
    self.footerView.delegate = self;
//    self.footerView.backgroundColor = HBSRandomColor;
    self.orderGoodTableView.tableFooterView = self.footerView;
    //注册
    [self.orderGoodTableView registerClass:[HBSGoodOrderCell class] forCellReuseIdentifier:HBSGoodOrderCellID];
}

- (instancetype)mj_setKeyValues:(id)keyValues
{
    return [self mj_setKeyValues:keyValues context:nil];
}
#pragma mark----获取数据
- (void)getData{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"id"] = self.goodID;
    params[@"token"] = userToken;
    [HBSNetWork getUrl:[NSString stringWithFormat:@"%@order/%@",HBSNetAdress, self.goodID] paramaters:params header:nil cookie:nil Result:^(id result) {
        
        
        if ([result[@"code"]integerValue] == 200) {
            self.goodArr = [HBSGoodModel mj_objectArrayWithKeyValuesArray:result[@"result"][@"order_goods_info"]];
            self.goodDic = result[@"result"];
            self.headerView.goodHeaderDic = self.goodDic;
            self.footerView.goodFooterDic = self.goodDic;
            self.phoneStr = self.goodDic[@"consignee_phone"];
            self.talkStr = result[@"result"][@"seller_im"];
            self.storeNameStr = result[@"result"][@"order_store_name"];
            HBSLog(@"城祥你真是个大傻逼啊%@", result);
            
            [self.orderGoodTableView reloadData];
        }else if ([result[@"code"]integerValue] == 400){
            
            HBSLog(@"请求失败");
        }
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.goodArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HBSGoodOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:HBSGoodOrderCellID];
    cell.goodModel = self.goodArr[indexPath.row];
    return cell;
}
#pragma mark----打电话实现代理方法
- (void)phoneCallDelegate:(HBSFooterView *)view WithclickPhone:(UIButton *)btn
{
    [HBSContactUsController call:self.phoneStr inViewController:self failBlock:^{
    }];
}
#pragma mark----聊天实现代理方法
- (void)talkCallDelegate:(HBSFooterView *)view WithclickTalk:(UIButton *)btn{
    
    if (![EMClient sharedClient].isLoggedIn){
        [self creatAlertView:@"聊天已断开" message:nil sureStr:@"重新连接" cancelStr:@"关闭" sureAction:^(id result) {
            NSLog(@"sure");
        } cancelAction:^(id result) {
            NSLog(@"end");
        }];
    }else{
        ChatViewController *chatVC = [[ChatViewController alloc] initWithConversationChatter:self.talkStr conversationType:EMConversationTypeChat];
        chatVC.name = self.storeNameStr;
//        chatVC.phone = self.model.store_tel;
        [self.navigationController pushViewController:chatVC animated:YES];
    }
}
#pragma mark----确认收货的代理方法
- (void)sureGoodsDelegate:(HBSFooterView *)view withClickGood:(UIButton *)btn{
    
    [self getData];
    
}
#pragma mark----返回箭头
- (void)clickImage{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    
}
@end
