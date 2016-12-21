//
//  HBSServiceController.m
//  HBS_C
//
//  Created by 王 世江 on 16/10/31.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSServiceController.h"
#import "HBSServiceCell.h"
#import "HBSServiceModel.h"
#import "WeddingDetailViewController.h"
@interface HBSServiceController ()

@property (nonatomic, strong) NSMutableArray *serviceArr;

@end

@implementation HBSServiceController
//循环利用的标识
static NSString *const HBSServiceCellID = @"service";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BAISE;
    [self setupTableView];
    [self getupData];
}
#pragma mark----获取数据
- (void)getupData{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"id"] = [ProjectCache getLoginMessage][@"user_id"];
    params[@"user_token"] = userToken;
    params[@"user_collect_type"] = @"package";
    params[@"iPageItem"] = @"20";
    params[@"iPageIndex"] = @"0";
    
    [HBSNetWork getUrl:[NSString stringWithFormat:@"%@user/1036/collect?user_collect_type=package&iPageItem=20&iPageIndex=0", HBSNetAdress] paramaters:params header:nil cookie:nil Result:^(id result) {
       
        if ([result[@"code"]integerValue] == 200) {
            
            self.serviceArr = [HBSServiceModel mj_objectArrayWithKeyValuesArray:result[@"result"]];
            [self.tableView reloadData];
            HBSLog(@"%@", result);
            
        }else if ([result[@"code"]integerValue] == 202){
            UIImageView *backImage = [[UIImageView alloc]init];
            [backImage setImage:[UIImage imageNamed:@"img_1_guanjia"]];
            backImage.frame = CGRectMake(0, 0, WIDTH, HEIGHT-110);
            [self.view addSubview:backImage];
            HBSLog(@"1234567890%@", result[@"result"]);
        }
        
    }];
    
}
#pragma mark----tableView的相关方法
- (void)setupTableView{
    
    self.tableView.backgroundColor = HBSColor(244, 244, 243);
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 110, 0);
    //设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.rowHeight = 106;
    //注册
    [self.tableView registerClass:[HBSServiceCell class] forCellReuseIdentifier:HBSServiceCellID];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.serviceArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HBSServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:HBSServiceCellID];
    cell.serviceModel = self.serviceArr[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        
    WeddingDetailViewController *wedVC = [[WeddingDetailViewController alloc] init];
    wedVC.type = DetailTypeGoods;
    wedVC.goods_id = [self.serviceArr[indexPath.row] goods_id];
    [self.navigationController pushViewController:wedVC animated:YES];
    
}
@end
