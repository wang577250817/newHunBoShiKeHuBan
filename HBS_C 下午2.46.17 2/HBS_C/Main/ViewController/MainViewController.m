//
//  MainViewController.m
//  HBS_C
//
//  Created by wangzuowen on 16/9/10.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "MainViewController.h"
#import "MainOneTableViewCell.h"
#import "MainTwoTableViewCell.h"
#import "HBSLoginController.h"


@interface MainViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@end

@implementation MainViewController

@synthesize buttonOne, buttonTwo, buttonFive, buttonFour, buttonThree;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    TITLE = @"🐷";
    [self creatTableView];
    [self creatTableViewHeaderView];
    
    UIButton *linButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [linButton setTitle:@"跳转" forState:UIControlStateNormal];
    linButton.frame = CGRectMake(50, 450, 100, 20);
    [self.view addSubview:linButton];
    [linButton addTarget:self action:@selector(tiao) forControlEvents:UIControlEventTouchUpInside];

    
}
- (void)tiao{
    
    HBSLoginController *loginVC = [[HBSLoginController alloc]init];
    
    [self.navigationController pushViewController:loginVC animated:YES];
    
}

- (void)button1
{
    self.tableView.backgroundColor = [UIColor blueColor];
}
- (void)button2
{
    self.tableView.backgroundColor = [UIColor redColor];
}
- (void)creatTableViewHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 100)];
    headerView.backgroundColor = [UIColor orangeColor];
    self.tableView.tableHeaderView = headerView;
}
- (void)creatTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 50)];
    headerView.backgroundColor = [UIColor grayColor];
    
    buttonOne = [UIButton buttonWithType:UIButtonTypeCustom];
    [headerView addSubview:buttonOne];
    
    buttonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
    [headerView addSubview:buttonTwo];
    
    buttonThree = [UIButton buttonWithType:UIButtonTypeCustom];
    [headerView addSubview:buttonThree];
    
    buttonFour = [UIButton buttonWithType:UIButtonTypeCustom];
    [headerView addSubview:buttonFour];
    
    buttonFive = [UIButton buttonWithType:UIButtonTypeCustom];
    [headerView addSubview:buttonFive];
    
    [buttonOne setTitle:@"婚礼策划" forState:UIControlStateNormal];
    [buttonTwo setTitle:@"婚纱摄影" forState:UIControlStateNormal];
    [buttonThree setTitle:@"婚礼酒店" forState:UIControlStateNormal];
    [buttonFour setTitle:@"司仪" forState:UIControlStateNormal];
    [buttonFive setTitle:@"跟妆" forState:UIControlStateNormal];
        
    [buttonOne addTarget:self action:@selector(buttonOneAction) forControlEvents:UIControlEventTouchUpInside];
    
    buttonOne.titleLabel.font = FONT(14);
    buttonTwo.titleLabel.font = FONT(14);
    buttonThree.titleLabel.font = FONT(14);
    buttonFour.titleLabel.font = FONT(14);
    buttonFive.titleLabel.font = FONT(14);
    
    [buttonOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake((WIDTH - 60) / 4, 30));
    }];
    [buttonTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(buttonOne.mas_right).offset(10);
        make.top.mas_equalTo(buttonOne.mas_top);
        make.size.mas_equalTo(CGSizeMake((WIDTH - 60) / 4, 30));
    }];
    [buttonThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(buttonTwo.mas_right).offset(10);
        make.top.mas_equalTo(buttonOne.mas_top);
        make.size.mas_equalTo(CGSizeMake((WIDTH - 60) / 4, 30));
    }];
    [buttonFour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(buttonThree.mas_right).offset(10);
        make.top.mas_equalTo(buttonOne.mas_top);
        make.size.mas_equalTo(CGSizeMake((WIDTH - 60) / 4 / 2, 30));
    }];
    [buttonFive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(buttonFour.mas_right).offset(10);
        make.top.mas_equalTo(buttonOne.mas_top);
        make.size.mas_equalTo(CGSizeMake((WIDTH - 60) / 4 / 2, 30));
    }];

    return headerView;
    }else{
        return [UIView new];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else{
        return 50;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        default:
            return 2;
            break;
    }

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return 100;
            break;
        case 1:
            return 50;
            break;
        default:
            return 44;
            break;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *cellStr = @"cellStr";
    MainOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
    if (!cell) {
        cell = [[MainOneTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
    }
    
    MainTwoTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
    if (!cell1) {
        cell1 = [[MainTwoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
    }
    switch (indexPath.section) {
        case 0:
            return cell;
            break;
        case 1:
            cell1.backgroundColor = [UIColor purpleColor];
            return cell1;
            break;
        default:
            return nil;
            break;
    }

    
}
- (void)buttonOneAction
{
    NSLog(@"123456987");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
