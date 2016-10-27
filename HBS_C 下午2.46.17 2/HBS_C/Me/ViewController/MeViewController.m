//
//  MeViewController.m
//  HBS_C
//
//  Created by wangzuowen on 16/9/10.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "MeViewController.h"
#import "ViewController.h"
#import "HBSSystemSetController.h"
#import "HBSMyTableViewCell.h"
#import "HBSEditViewController.h"
#import "HBSContactUsController.h"
#import "HBSWillWebView.h"
@interface MeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView * myTableView;
@property (nonatomic, strong) NSArray *listArr;//列表Arr
@property (nonatomic, strong) NSArray *subtitleArr;//名字Arr
@property (nonatomic, strong) NSArray *imageArr;//图片image
@property (nonatomic, strong) UIImageView *rightImage;//右上的image

@end

@implementation MeViewController
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
     self.automaticallyAdjustsScrollViewInsets = NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BAISE;
    [self creatTableView];
    [self creatHeaderView];
    
}
#pragma mark----创建tableView的头部视图
- (void)creatHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 230 * HSHIPEI)];
    UIImageView *backImage = ImageAlloc(0, 0, WIDTH, 230 * HSHIPEI);
    backImage.userInteractionEnabled = YES;
    [backImage setImage:[UIImage imageNamed:@"backImage"]];
    [headerView addSubview:backImage];
    
    self.rightImage = [[UIImageView alloc]init];
    [self.rightImage setImage:[UIImage imageNamed:@"icon_1_bianji"]];
    self.rightImage.userInteractionEnabled = YES;
    [backImage addSubview:self.rightImage];
    [self.rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(backImage).offset(40);
        make.right.mas_equalTo(backImage).offset(-10);
        make.size.mas_equalTo(CGSizeMake(24, 24));
        
    }];
    
    UITapGestureRecognizer *tapImage = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImage)];
    [self.rightImage addGestureRecognizer:tapImage];
    
    UIImageView *userHeadImage = ImageAlloc(WIDTH / 2 - 37.5, 40, 75, 75);
    [userHeadImage setImage:[UIImage imageNamed:@"backImage"]];
    userHeadImage.layer.masksToBounds = YES;
    userHeadImage.layer.cornerRadius = 37.5;
    userHeadImage.layer.borderWidth = 3.5;
    userHeadImage.layer.borderColor = [BAISE CGColor];
    [headerView addSubview:userHeadImage];
    
    
    UILabel *userName = [[UILabel alloc]init];
    userName.text = @"sb567";
    userName.font = FONT(18);
    userName.textColor = BAISE;
//    userName.backgroundColor = HBSRandomColor;
    userName.textAlignment = NSTextAlignmentCenter;
    [backImage addSubview:userName];
    [userName mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(userHeadImage).offset(95);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 20));
        
    }];
    
    UILabel *userTime = [[UILabel alloc]init];
    userTime.text = @"1999-09-09";
    userTime.textColor = BAISE;
    userTime.font = FONT(13);
//    userTime.backgroundColor = [UIColor lightGrayColor];
    userTime.textAlignment = NSTextAlignmentCenter;
    [backImage addSubview:userTime];
    [userTime mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(userName).offset(34);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 15));
        
    }];
    
    self.myTableView.tableHeaderView = headerView;
}
#pragma mark-----创建tableView
- (void)creatTableView
{
    self.myTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.contentInset = UIEdgeInsetsMake(0,0,50,0);
    self.myTableView.separatorStyle = UITableViewCellSelectionStyleDefault;
    self.myTableView.backgroundColor = HBSColor(244, 244, 243);
    self.myTableView.rowHeight = 48.0;
    [self.view addSubview:self.myTableView];
    self.listArr = @[@"我的订单", @"我的购物车", @"我的收藏", @"我的钱包", @"我是商家", @"联系我们", @"邀请有礼", @"设置"];
    _subtitleArr = @[@"", @"",@"", @"", @"我要入驻",@"4008-520-182",@"", @"", @""];
     self.imageArr = @[@"icon_1_dingdan", @"icon_1_gouwuche",@"icon_1_wodesoucang", @"icon_1_wodequanbao", @"icon_1_woshishangjia",@"icon_1_lianxiwomen", @"icon_1_yaoqingyouli", @"icon_1_shezhi"];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellStr = @"cell";
    HBSMyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (!cell) {
        cell = [[HBSMyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    NSDictionary *dic = @{@"image":self.imageArr[indexPath.row], @"title":self.listArr[indexPath.row], @"subTitle":self.subtitleArr[indexPath.row]};
    cell.dic = dic;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    if (indexPath.row == 4) {
        HBSWillWebView *willWebView = [[HBSWillWebView alloc]init];
        [self.navigationController pushViewController:willWebView animated:YES];
    
    }else if (indexPath.row == 5) {
        
        [HBSContactUsController call:@"4008-520-182" inViewController:self failBlock:^{
        HBSLog(@"模拟器不能打电话");
            
        }];
        
    }else if (indexPath.row == 7) {
        
        HBSSystemSetController *system = [[HBSSystemSetController alloc]init];
        [self.navigationController pushViewController:system animated:YES];
        
    }
}

#pragma mark----编辑资料跳转方法
- (void)clickImage{
    
    HBSEditViewController *edit = [[HBSEditViewController alloc]init];
    [self.navigationController pushViewController:edit animated:YES];
    
}

@end
