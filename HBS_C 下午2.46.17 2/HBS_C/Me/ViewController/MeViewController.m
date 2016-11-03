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
#import "HBSMyWalletController.h"
#import "HBSMyCollectionController.h"
#import "HBSGiftController.h"

@interface MeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView * myTableView;
@property (nonatomic, strong) NSArray *listArr;//列表Arr
@property (nonatomic, strong) NSArray *subtitleArr;//名字Arr
@property (nonatomic, strong) NSArray *imageArr;//图片image
@property (nonatomic, strong) UIImageView *rightImage;//右上的image
@property (nonatomic, strong) NSDictionary *mDic;//用于接受数据的字典
@property (nonatomic, strong) UILabel *userName;//名字label
@property (nonatomic, strong) UIImageView *userHeadImage;//图片image
@property (nonatomic, strong) UILabel *userTime;//日期Label
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
    [self requestData];
    
}
#pragma mark----数据请求
- (void)requestData{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"id"] = user_id_find;
    params[@"user_token"] = @"123456";
    if ([self checkWIFI]) {
        [self showLoadingViewWithMessage];
        [HBSNetWork getUrl:[NSString stringWithFormat:@"%@user/1036", HBSNetAdress] paramaters:params header:nil cookie:nil Result:^(id result) {
            if ([result[@"code"]integerValue]== 200) {
                
                self.mDic = result[@"result"];
                self.userName.text = self.mDic[@"user_real_name"];
                [self.userHeadImage sd_setImageWithURL:[NSURL URLWithString:self.mDic[@"user_head_pic"]] placeholderImage:[UIImage imageNamed:@"img_1-1"]];
                self.userTime.text = self.mDic[@"user_wedding_day"];
                HBSLog(@"婚博士%@", result);
                [self removeLodingView];
            }else if ([result[@"code"]integerValue] == 400){
                HBSLog(@"获取失败");
            }
            
        }];
        
    }
    
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
    
    //头像
    self.userHeadImage = ImageAlloc(WIDTH / 2 - 37.5, 40, 75, 75);
//    [userHeadImage setImage:[UIImage imageNamed:@"backImage"]];
    self.userHeadImage.layer.masksToBounds = YES;
    self.userHeadImage.layer.cornerRadius = 37.5;
    self.userHeadImage.layer.borderWidth = 3.5;
    self.userHeadImage.layer.borderColor = [BAISE CGColor];
    [headerView addSubview:self.userHeadImage];
    
    
    //昵称
    self.userName = [[UILabel alloc]init];
//    userName.text = @"sb567";
    self.userName.font = FONT(18);
    self.userName.textColor = BAISE;
//    userName.backgroundColor = HBSRandomColor;
    self.userName.textAlignment = NSTextAlignmentCenter;
    [backImage addSubview:self.userName];
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.userHeadImage).offset(95);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 20));
        
    }];
    //时间
    self.userTime = [[UILabel alloc]init];
//    self.userTime.text = @"1999-09-09";
    self.userTime.textColor = BAISE;
    self.userTime.font = FONT(13);
//    userTime.backgroundColor = [UIColor lightGrayColor];
    self.userTime.textAlignment = NSTextAlignmentCenter;
    [backImage addSubview:self.userTime];
    [self.userTime mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.userName).offset(34);
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
    
    if (indexPath.row == 2) {
        
        HBSMyCollectionController *myCollection = [[HBSMyCollectionController alloc]init];
        [self.navigationController pushViewController:myCollection animated:YES];
        
    
  }else if (indexPath.row == 3) {
        
        HBSMyWalletController *myWallet = [[HBSMyWalletController alloc]init];
        [self.navigationController pushViewController:myWallet animated:YES];
        
    }else if (indexPath.row == 4) {
        HBSWillWebView *willWebView = [[HBSWillWebView alloc]init];
        [self.navigationController pushViewController:willWebView animated:YES];
    
    }else if (indexPath.row == 5) {
        
        [HBSContactUsController call:@"4008-520-182" inViewController:self failBlock:^{
        HBSLog(@"模拟器不能打电话");
            
        }];
        
    }else if (indexPath.row == 6){
        HBSGiftController *gift = [[HBSGiftController alloc]init];
        [self.navigationController pushViewController:gift animated:YES];
    
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
