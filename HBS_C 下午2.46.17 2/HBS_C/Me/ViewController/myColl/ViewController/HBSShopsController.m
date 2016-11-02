//
//  HBSShopsController.m
//  HBS_C
//
//  Created by 王 世江 on 16/10/31.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSShopsController.h"
#import "HBSShopsCell.h"

@interface HBSShopsController ()

@end

@implementation HBSShopsController
//循环利用的标识
static NSString *const HBSShopsCellID = @"shops";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BAISE;
    [self setupTableView];
    
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
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HBSShopsCell *cell = [tableView dequeueReusableCellWithIdentifier:HBSShopsCellID];    
    return cell;
}


@end
