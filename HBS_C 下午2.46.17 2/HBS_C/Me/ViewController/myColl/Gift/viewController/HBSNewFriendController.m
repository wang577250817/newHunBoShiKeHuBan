//
//  HBSNewFriendController.m
//  HBS_C
//
//  Created by 王 世江 on 16/11/2.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSNewFriendController.h"
#import "HBSFriendCell.h"

@interface HBSNewFriendController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIImageView *leftImage;
@property (nonatomic, strong) UITableView * myTableView;
@property (nonatomic, strong) NSArray *listArr;//列表Arr
@property (nonatomic, strong) NSArray *imageArr;//图片image
@end

@implementation HBSNewFriendController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BAISE;
    [self setUpChildControls];
    
}
#pragma mark----设置子控件
- (void)setUpChildControls{
    
    //返回箭头
    UITapGestureRecognizer *tapImage = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImage)];
    [self.leftImage addGestureRecognizer:tapImage];
    
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 62, WIDTH, HEIGHT) style:UITableViewStylePlain];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
//    self.myTableView.contentInset = UIEdgeInsetsMake(0,50,50,0);
    self.myTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.myTableView.backgroundColor = HBSColor(244, 244, 243);
    self.myTableView.rowHeight = 65.0;
    [self.view addSubview:self.myTableView];
    self.listArr = @[@"微信好友", @"微信朋友圈", @"QQ好友", @"QQ空间", @"新浪微博"];
    self.imageArr = @[@"icon_1_2_weixinhaiyou", @"icon_1_2_weixinpenyouquan",@"icon_1_2_qqhaoyou", @"icon_1_2_qqkonhjian", @"icon_1_2_xinlangweibo"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellStr = @"cell";
    HBSFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (!cell) {
        cell = [[HBSFriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    NSDictionary *dic = @{@"image":self.imageArr[indexPath.row], @"title":self.listArr[indexPath.row]};
    cell.dic = dic;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
}

#pragma mark----箭头image返回方法
- (void)clickImage{
    
    [self.navigationController popViewControllerAnimated:YES];

}
@end
