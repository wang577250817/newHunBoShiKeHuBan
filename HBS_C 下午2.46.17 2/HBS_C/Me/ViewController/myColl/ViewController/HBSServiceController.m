//
//  HBSServiceController.m
//  HBS_C
//
//  Created by 王 世江 on 16/10/31.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSServiceController.h"
#import "HBSServiceCell.h"
@interface HBSServiceController ()

@end

@implementation HBSServiceController
//循环利用的标识
static NSString *const HBSServiceCellID = @"service";
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
    self.tableView.rowHeight = 106;
    //注册
    [self.tableView registerClass:[HBSServiceCell class] forCellReuseIdentifier:HBSServiceCellID];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HBSServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:HBSServiceCellID];
    return cell;
}
@end
