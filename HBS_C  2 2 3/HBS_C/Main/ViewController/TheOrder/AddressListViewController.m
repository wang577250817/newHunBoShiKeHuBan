//
//  AddressListViewController.m
//  HBS_C
//
//  Created by wangzuowen on 16/11/7.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "AddressListViewController.h"
#import "AddressListTableViewCell.h"
#import "NewAddressViewController.h"

@interface AddressListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)UIImageView *noAdressImage;

@end

@implementation AddressListViewController

- (void)dealloc{
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self netWorking];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    TITLE = @"我的地址库";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    [self netWorking];
    [self creatTableView];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.titleLabel.font = FONT(16);
    addButton.backgroundColor = WZWorangeColor;
    addButton.frame = CGRectMake(0, 0, 60, 30);
    [addButton setTitle:@"新增" forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
}
- (void)addAction
{
    NewAddressViewController *addVC = [[NewAddressViewController alloc] init];
    addVC.isOne = YES;
    [self.navigationController pushViewController:addVC animated:YES];
}
- (void)netWorking
{
    [self showLoadingViewWithMessage];
    [HBSNetWork getUrl:[NSString stringWithFormat:@"%@cart/address/%@", HBSNetAdress, [ProjectCache getLoginMessage][@"user_id"]] paramaters:nil header:@"stoken" cookie:nil Result:^(id result) {
        
        
        if ([result[@"code"] integerValue] == 200) {

            self.dataArr = [MainModel transformWithArray:result[@"result"]];
            if (_noAdressImage) {
                [_noAdressImage removeFromSuperview];
            }
            [self.tableView reloadData];
            
        }else if([result[@"code"] integerValue] == 201){
            _noAdressImage = ImageAlloc(0, 64, WIDTH, HEIGHT);
            _noAdressImage.image = [UIImage imageNamed:@"img_shouhuodizhiweikong@2x"];
            [self.view addSubview:_noAdressImage];
        }
        [self removeLodingView];
    }];
}

- (void)creatTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 100.0f;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strCell = @"cell";
    AddressListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
    if (!cell) {
        cell = [[AddressListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
    }
    cell.model = self.dataArr[indexPath.row];
    [cell.rightImage addTarget:self action:@selector(editingAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.rightImage.tag = indexPath.row + 7777;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_isOrder) {
        self.block(self.dataArr[indexPath.row]);
        [self.navigationController popViewControllerAnimated:YES];
    }else{        
        
    }
}
- (void)editingAction:(UIButton *)sender
{
    NewAddressViewController *newVC = [[NewAddressViewController alloc] init];
    newVC.isOne = NO;
    newVC.model = self.dataArr[sender.tag - 7777];
    [self.navigationController pushViewController:newVC animated:YES];
}
- (void)changeRound:(UIButton *)sender
{
    
    sender.selected = !sender.selected;
    
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
