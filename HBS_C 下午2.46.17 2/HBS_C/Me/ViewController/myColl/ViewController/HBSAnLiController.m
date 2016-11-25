//
//  HBSAnLiController.m
//  HBS_C
//
//  Created by 王 世江 on 16/10/31.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSAnLiController.h"
#import "HBSAnLiCell.h"
#import "HBSAnLiModel.h"
@interface HBSAnLiController ()

@property (nonatomic, strong) NSMutableArray *anLiArr;

@end

@implementation HBSAnLiController
//循环利用的标识
static NSString *const HBSAnLiCellID = @"anli";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BAISE;
    [self setupTableView];
    [self getupData];
}
#pragma mark----获取数据
- (void)getupData{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"id"] = user_id_find;
    params[@"user_token"] = userToken;
    params[@"user_collect_type"] = @"case";
    params[@"iPageItem"] = @"20";
    params[@"iPageIndex"] = @"0";
    
    [HBSNetWork getUrl:[NSString stringWithFormat:@"%@user/1036/collect?user_collect_type=case&iPageItem=20&iPageIndex=0", HBSNetAdress] paramaters:params header:nil cookie:nil Result:^(id result) {
       
        if ([result[@"code"]integerValue] == 200) {
            self.anLiArr = [HBSAnLiModel mj_objectArrayWithKeyValuesArray:result[@"result"]];
            [self.tableView reloadData];
            
            HBSLog(@"%@", result[@"result"]);
            
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
    self.tableView.rowHeight = 200;
    //注册
    [self.tableView registerClass:[HBSAnLiCell class] forCellReuseIdentifier:HBSAnLiCellID];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.anLiArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HBSAnLiCell *cell = [tableView dequeueReusableCellWithIdentifier:HBSAnLiCellID];
    cell.anLiModel = self.anLiArr[indexPath.row];
    return cell;
}

@end
