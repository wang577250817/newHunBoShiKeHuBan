//
//  HBSOrderDetailsController.m
//  HBS_C
//
//  Created by 王 世江 on 16/11/9.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSOrderDetailsController.h"
#import "HBSServiceOrderCell.h"
@interface HBSOrderDetailsController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIImageView *leftImage;//返回image
@property (nonatomic, strong) UITableView *orderDetailTableView;
@property (nonatomic, strong) NSDictionary *serviceDetailDic;
@property (nonatomic, strong) HBSServiceOrderCell *serviceCell;

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
    params[@"token"] = @"123456";
    [HBSNetWork getUrl:[NSString stringWithFormat:@"%@order/%@",HBSNetAdress, self.oederID] paramaters:params header:nil cookie:nil Result:^(id result) {
        
        if ([result[@"code"]integerValue] == 200) {
            
            self.serviceDetailDic = result[@"result"];
            HBSLog(@"12345678%@", self.serviceDetailDic);
            
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
    
    
    return cell;
    
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
