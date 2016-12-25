//
//  HBSOrderDetailsController.m
//  HBS_C
//
//  Created by 王 世江 on 16/11/9.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSOrderDetailsController.h"
#import "HBSServiceOrderCell.h"
#import "HBSContactUsController.h"
@interface HBSOrderDetailsController ()<UITableViewDelegate, UITableViewDataSource, HBSServiceOrderCellDelegate>
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UITableView *orderDetailTableView;
@property (nonatomic, strong) NSDictionary *serviceDetailDic;
@property (nonatomic, strong) HBSServiceOrderCell *serviceCell;
@property (nonatomic, strong) NSString *phoneStr;//接受电话的str
@property (nonatomic, strong) NSString *talkStr;//聊天id
@property (nonatomic, strong) NSString *storeNameStr;//店名

@end

@implementation HBSOrderDetailsController
//防止循环引用的标识
static NSString *const HBSServiceOrderCellID = @"service";
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BAISE;
    [self getData];
    [self setUpChildControls];
}
#pragma mark----设置子控件
- (void)setUpChildControls{
    
    //返回箭头
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.leftBtn.frame = CGRectMake(0, 20, 30, 35);
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_fanhuijiantou"] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(clickImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.leftBtn];
    //服务订单详情tableView
    self.orderDetailTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 62, WIDTH, HEIGHT - 66) style:UITableViewStylePlain];
    self.orderDetailTableView.backgroundColor = HBSColor(244, 244, 243);
    self.orderDetailTableView.separatorStyle = UITableViewCellAccessoryNone;
    self.orderDetailTableView.delegate = self;
    self.orderDetailTableView.dataSource = self;
    self.orderDetailTableView.rowHeight = 600;
    [self.view addSubview:self.orderDetailTableView];
    //注册
    [self.orderDetailTableView registerClass:[HBSServiceOrderCell class] forCellReuseIdentifier:HBSServiceOrderCellID];
    
}
#pragma mark----获取数据
- (void)getData{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"id"] = self.oederID;
    params[@"token"] = userToken;
    [HBSNetWork getUrl:[NSString stringWithFormat:@"%@order/%@",HBSNetAdress, self.oederID] paramaters:params header:nil cookie:nil Result:^(id result) {
        
        if ([result[@"code"]integerValue] == 200) {
            
            self.serviceDetailDic = result[@"result"];
           
            self.phoneStr = self.serviceDetailDic[@"seller_phone"];
            self.talkStr = result[@"result"][@"seller_im"];
             self.storeNameStr = result[@"result"][@"order_store_name"];
            [self.orderDetailTableView reloadData];
        }else if ([result[@"code"]integerValue] == 400){
            
            HBSLog(@"请求失败");
        }
       
    }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HBSServiceOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:HBSServiceOrderCellID];
    cell.serviceDic = self.serviceDetailDic;
    cell.delegate = self;
    return cell;
    
}
#pragma mark----实现代理方法
- (void)HBSServiceOrderCell:(HBSServiceOrderCell *)cell WithPhoneUibutton:(UIButton *)btn{
    
    [HBSContactUsController call:self.phoneStr inViewController:self failBlock:^{
        
//        HBSLog(@"傻逼城祥打电话%@", self.phoneStr);
        
    }];
    
}
#pragma mark----聊天实现代理方法
- (void)talkCallDelegate:(HBSServiceOrderCell *)view WithclickTalk:(UIButton *)btn{
    
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
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
