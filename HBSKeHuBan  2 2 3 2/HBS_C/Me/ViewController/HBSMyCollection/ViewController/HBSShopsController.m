//
//  HBSShopsController.m
//  HBS_C
//
//  Created by 王 世江 on 16/10/31.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSShopsController.h"
#import "HBSShopsCell.h"
#import "HBSShopsModel.h"
#import "ShopDetailViewController.h"
@interface HBSShopsController ()

@property (nonatomic, strong) NSMutableArray *shopsArr;
@property (nonatomic, assign) NSInteger page;
@end

@implementation HBSShopsController
//循环利用的标识
static NSString *const HBSShopsCellID = @"shops";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BAISE;
    [self setupTableView];
    [self getupData];
    
    self.page = 1;
    
}
#pragma mark----获取数据
- (void)getupData{
    
    NSMutableDictionary *paramas = [NSMutableDictionary dictionary];
    paramas[@"id"] = [ProjectCache getLoginMessage][@"user_id"];
    paramas[@"user_token"] = userToken;
    paramas[@"user_collect_type"] = @"store";
    paramas[@"iPageItem"] = @"20";
    paramas[@"iPageIndex"] = @"0";
    __weak typeof (self) weakSelf = self;
    [HBSNetWork getUrl:[NSString stringWithFormat:@"%@user/%@/collect?user_collect_type=store&iPageItem=20&iPageIndex=%@", HBSNetAdress, [ProjectCache getLoginMessage][@"user_id"], paramas[@"iPageIndex"]] paramaters:paramas header:nil cookie:nil Result:^(id result) {
        if ([result[@"code"]integerValue]==200) {
            //字典数组-->模型数组
            weakSelf.shopsArr = [HBSShopsModel mj_objectArrayWithKeyValuesArray:result[@"result"]];
            [weakSelf.tableView reloadData];
            
            HBSLog(@"店铺收藏%@", result);
            
        }else if ([result[@"code"]integerValue] == 202){
            
            UIImageView *backImage = [[UIImageView alloc]init];
            [backImage setImage:[UIImage imageNamed:@"img_1_guanjia"]];
            backImage.frame = CGRectMake(0, 0, WIDTH, HEIGHT-110);
            [self.view addSubview:backImage];
//            HBSLog(@"1234567890%@", result[@"result"]);
            
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
    self.tableView.rowHeight = 122;
    //注册
    [self.tableView registerClass:[HBSShopsCell class] forCellReuseIdentifier:HBSShopsCellID];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        //        [self getupData];
        [self.tableView.mj_header endRefreshing];
        
    }];
    
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    self.tableView.mj_footer = [HBSRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(MJLoadMorePage)];
    
}
- (void)MJLoadMorePage{
    
    NSMutableDictionary *paramas = [NSMutableDictionary dictionary];
    paramas[@"id"] = [ProjectCache getLoginMessage][@"user_id"];
    paramas[@"user_token"] = userToken;
    paramas[@"user_collect_type"] = @"store";
    paramas[@"iPageItem"] = @"20";
    paramas[@"iPageIndex"] = [NSString stringWithFormat:@"%ld", self.page++];
    __weak typeof (self) weakSelf = self;
    [HBSNetWork getUrl:[NSString stringWithFormat:@"%@user/%@/collect?user_collect_type=store&iPageItem=20&iPageIndex=%@", HBSNetAdress, [ProjectCache getLoginMessage][@"user_id"], paramas[@"iPageIndex"]] paramaters:paramas header:nil cookie:nil Result:^(id result) {
        
        if ([result[@"code"]integerValue] == 200) {
            
            NSMutableArray *moreComments = [HBSShopsModel mj_objectArrayWithKeyValuesArray:result[@"result"]];
            [weakSelf.shopsArr addObjectsFromArray:moreComments];
            
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.mj_footer endRefreshing];
            
        }else if ([result[@"code"]integerValue] == 202){
            
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
        
    }];
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.shopsArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HBSShopsCell *cell = [tableView dequeueReusableCellWithIdentifier:HBSShopsCellID];
    cell.shopsModel = self.shopsArr[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ShopDetailViewController *wedVC = [[ShopDetailViewController alloc] init];
    wedVC.story_id = [self.shopsArr[indexPath.row] store_id];
    [self.navigationController pushViewController:wedVC animated:YES];
    
}

@end
