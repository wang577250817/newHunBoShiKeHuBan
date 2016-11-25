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
@property (strong, nonatomic) IBOutlet UIImageView *leftImage;//返回image
@property (nonatomic, strong) UITableView *orderDetailTableView;
@property (nonatomic, strong) NSDictionary *serviceDetailDic;
@property (nonatomic, strong) HBSServiceOrderCell *serviceCell;
@property (nonatomic, strong) NSString *phoneStr;//接受电话的str

@end

@implementation HBSOrderDetailsController
//防止循环引用的标识
static NSString *const HBSServiceOrderCellID = @"service";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BAISE;
    [self getData];
    [self setUpChildControls];
}
#pragma mark----设置子控件
- (void)setUpChildControls{
    
    //返回箭头
    UITapGestureRecognizer *tapImage = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImage)];
    [self.leftImage addGestureRecognizer:tapImage];
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
            HBSLog(@"12345678累了%@", self.serviceDetailDic);
            self.phoneStr = self.serviceDetailDic[@"seller_phone"];
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
}
#pragma mark----返回箭头
- (void)clickImage{
    
    [self.navigationController popViewControllerAnimated:YES];

}
@end
