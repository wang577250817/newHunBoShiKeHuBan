//
//  ShopCarViewController.m
//  HBS_C
//
//  Created by wangzuowen on 16/10/21.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "ShopCarViewController.h"
#import "ShopCarTableViewCell.h"
#import "MainModel.h"
#import "WeddingOrderViewController.h"

@interface ShopCarViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UITextView * textView;
    UIButton *_allButton;
}
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)NSMutableArray *selectDataArr;
@property (nonatomic, assign)NSInteger tt;
@property (nonatomic, strong)UILabel *allPriceLabel;
@property (nonatomic, strong)UIButton *allButton;
@property (nonatomic, strong) UILabel *endLabel;//修改成功标识

@end

@implementation ShopCarViewController


- (void)dealloc
{
    self.tableView.delegate = nil;
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    TITLE = @"购物车";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _dataArr = [NSMutableArray array];
    _selectDataArr = [NSMutableArray array];
    
    [self creatTableView];
    
    //    textView= [[UITextView alloc] initWithFrame:CGRectMake(0, 64, WIDTH - 20, 300)];
    //    textView.backgroundColor = WZWgrayColor;
    //
    //    UIView *keyBoardTopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    //    keyBoardTopView.backgroundColor = [UIColor lightGrayColor];
    //
    //    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(keyBoardTopView.bounds.size.width - 60 - 12, 4, 60, 20)];
    //    btn.titleLabel.font = FONT(13);
    //    [btn setTitle:@"关闭" forState:UIControlStateNormal];
    //    [btn addTarget:self action:@selector(onKeyBoardDown:) forControlEvents:UIControlEventTouchUpInside];
    //    [keyBoardTopView addSubview:btn];
    //
    //    textView.inputAccessoryView = keyBoardTopView;
    //
    //    [self.view addSubview:textView];
    UIView *footerView = [[UIView alloc]init];
    footerView.frame = CGRectMake(0, 0, WIDTH, 185);
    UIImageView *carImage = [[UIImageView alloc]init];
    carImage.image = [UIImage imageNamed:@"ditu"];
    carImage.frame = CGRectMake(0, 0, WIDTH, 185);
    [footerView addSubview:carImage];
    self.tableView.tableFooterView = footerView;
    
    [self netWorking];
}
//- (void)onKeyBoardDown:(UIButton *)sender
//{
//    [textView resignFirstResponder];
//}
- (void)netWorking
{
    [self.dataArr removeAllObjects];
    [self.selectDataArr removeAllObjects];
    if ([self checkWIFI]) {
        [self showLoadingViewWithMessage];
        [HBSNetWork getUrl:[NSString stringWithFormat:@"%@cart/1036", HBSNetAdress] cookie:nil Result:^(id result) {
            if ([result[@"code"] integerValue] == 200) {
                _dataArr = [MainModel transformWithArray:result[@"result"]];
                for (NSInteger i = 0; i < _dataArr.count; i++) {
                    NSMutableArray *arrdddheheieh=[[NSMutableArray alloc] init];
                    for (NSInteger j = 0; j < [[_dataArr[i] goods] count]; j++) {
                        NSMutableDictionary *dicInfo=[[NSMutableDictionary alloc] initWithObjects:@[[_dataArr[i] goods][j][@"goods_quantity"],@"0"] forKeys:@[@"count",@"selected"]];
                        [arrdddheheieh addObject:dicInfo];
                        
                    }
                    //                    [_selectDataArr addObject:@{@"i":[NSString stringWithFormat:@"%ld", i], @"goods":arrdddheheieh}];
                    [_selectDataArr addObject:arrdddheheieh];
                }
                [self changeAllPrice];
                [_tableView reloadData];
            }
            [self removeLodingView];
        }];
    }else{
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50.0f;
}
- (void)creatTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64 - 49 * HSHIPEI) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, -20, 0);
//    _tableView.sectionHeaderHeight = 50.0f;
    _tableView.sectionFooterHeight = 5.0f;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.rowHeight = 160.0f;
    [self.view addSubview:_tableView];
    
    UIView *footerView = ViewAlloc(0, HEIGHT - 49 * HSHIPEI, WIDTH, 49 * HSHIPEI);
    [self.view addSubview:footerView];
    
    _allButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    _allButton.frame = CGRectMake(10, 18 * HSHIPEI, 18, 18);
    [_allButton setImage:[UIImage imageNamed:@"icon_hun@2x"] forState:UIControlStateNormal];
    [_allButton setImage:[UIImage imageNamed:@"icon_1_2_xuanzhonghong"] forState:UIControlStateSelected];
    [_allButton addTarget:self action:@selector(changeAllState:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:_allButton];
    
    UIButton *payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    payButton.frame = CGRectMake(WIDTH - 110 * WSHIPEI, 0, 110 * WSHIPEI, 49 * HSHIPEI);
    [payButton addTarget:self action:@selector(goPayAction:) forControlEvents:UIControlEventTouchUpInside];
    payButton.backgroundColor = FENSE;
    payButton.titleLabel.font = FONT(15);
    [payButton setTitle:@"去结算" forState:UIControlStateNormal];
    [footerView addSubview:payButton];
    
    _allPriceLabel = LabelAlloc(0, 18 * HSHIPEI , WIDTH - 110 * WSHIPEI - 10 - 30, 20);
    _allPriceLabel.textAlignment = NSTextAlignmentRight;
    _allPriceLabel.font = FONT(14);
    _allPriceLabel.textColor = FENSE;
    [footerView addSubview:_allPriceLabel];
}
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    UIView *vv = ViewAlloc(0, 0, WIDTH, 5);
//    vv.backgroundColor = BEIJINGSE;
//    return vv;
//}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 30)];
    vv.backgroundColor = HBSColor(229, 229, 229);
    
    UIButton *roundImage = [UIButton buttonWithType:UIButtonTypeCustom];
    roundImage.frame = CGRectMake(10, 15, 18, 18);
    [roundImage setImage:[UIImage imageNamed:@"icon_hun@2x"] forState:UIControlStateNormal];
    [roundImage setImage:[UIImage imageNamed:@"icon_1_2_xuanzhonghong"] forState:UIControlStateSelected];
    for (int i=0; i<[[_dataArr[section] goods] count]; i++) {
        if ([_selectDataArr[section][i][@"selected"] isEqualToString:@"0"]) {
            roundImage.selected = NO;
        }else if([_selectDataArr[section][i][@"selected"] isEqualToString:@"1"]){
            roundImage.selected = YES;
        }
    }
    roundImage.tag = 9999 + section;
    [roundImage addTarget:self action:@selector(changeSectionState:) forControlEvents:UIControlEventTouchUpInside];
    [vv addSubview:roundImage];
    
    UILabel *label = LabelAlloc(43, 15, WIDTH - 53, 20);
    label.font = FONT(15);
    label.text = [self.dataArr[section] store_name];
    [vv addSubview:label];
    
    return vv;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_dataArr[section] goods] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellStr = @"shaopcarcell";
    ShopCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (!cell) {
        cell = [[ShopCarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    __weak typeof(self)weakself = self;
    cell.block = ^(NSInteger tt) {
        //        weakself.tt = tt;
        //        NSLog(@"数量:%ld, 区:%ld , 行:%ld", (long)self.tt, indexPath.section, indexPath.row);
        [_selectDataArr[indexPath.section][indexPath.row] setObject:[NSString stringWithFormat:@"%ld", tt] forKey:@"count"];
        [weakself changeAllPrice];
        
    };
    cell.blockNum = ^(NSInteger tt){
        NSDictionary *dic = @{@"rec_id":[weakself.dataArr[indexPath.section] goods][indexPath.row][@"rec_id"], @"quantity":[NSString stringWithFormat:@"%ld", tt]};
        [weakself showLoadingViewWithMessage];
        [HBSNetWork putUrl:[NSString stringWithFormat:@"%@cart/%@", HBSNetAdress, @"1036"] parame:dic header:@"c02b68e88c44385f56064ce4cd49b319" cookie:nil result:^(id result) {
            if ([result[@"code"] integerValue] == 200) {
                [weakself removeLodingView];
                [weakself netWorking];
            }
        }];
    };
    cell.roundButton.tag = indexPath.section * 1000 + indexPath.row;
    [cell.roundButton addTarget:self action:@selector(changeRowState:) forControlEvents:UIControlEventTouchUpInside];
    if ([_selectDataArr[indexPath.section][indexPath.row][@"selected"] intValue] ==0 ) {
        cell.roundButton.selected = NO;
    }else{
        cell.roundButton.selected = YES;
    }
    cell.dic = [self.dataArr[indexPath.section] goods][indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self showLoadingViewWithMessage];
        NSDictionary *dic = @{@"token":@"c02b68e88c44385f56064ce4cd49b319", @"rec_ids":[_dataArr[indexPath.section] goods][indexPath.row][@"rec_id"]};
        [HBSNetWork deleteUrl:[NSString stringWithFormat:@"%@cart/%@", HBSNetAdress, @"1036"] parame:dic cookie:nil result:^(id result) {
            if ([result[@"code"] integerValue] == 200) {
                [self removeLodingView];
                [self netWorking];
            }
            
        }];
    }
}

- (void)changeRowState:(UIButton *)sender
{
    NSMutableDictionary *dic = _selectDataArr[sender.tag/1000][sender.tag%1000];
    [dic setObject:[NSString stringWithFormat:@"%d",!sender.selected] forKey:@"selected"];
    if ([dic[@"count"] intValue]==0) {
        [dic setObject:[NSString stringWithFormat:@"1"] forKey:@"count"];
    }
    //如果全部都选择了, 那么 改变"选择全部"按钮的图片
    _allButton.selected=YES;
    for (int i=0; i<[_selectDataArr count]; i++) {
        for (int x=0; x<[_selectDataArr[i] count]; x++) {
            if ([_selectDataArr[i][x][@"selected"] isEqualToString:@"0"]) {
                _allButton.selected=NO;
            }
        }
    }
    sender.selected = !sender.selected;
    [self changeAllPrice];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag/1000] withRowAnimation:UITableViewRowAnimationNone];
    
}
- (void)changeSectionState:(UIButton *)sender
{
    
    for (int x=0; x<[_selectDataArr[sender.tag - 9999] count]; x++) {
        NSMutableDictionary *dic = _selectDataArr[sender.tag - 9999][x];
        [dic setObject:[NSString stringWithFormat:@"%d",!sender.selected] forKey:@"selected"];
        
        if ([dic[@"count"] intValue]==0) {
            [dic setObject:[NSString stringWithFormat:@"1"] forKey:@"count"];
        }
    }
    //如果全部都选择了, 那么 改变"选择全部"按钮的图片
    _allButton.selected=YES;
    for (int i = 0; i < _selectDataArr.count; i++) {
        for (int j = 0; j < [_selectDataArr[i] count]; j++) {
            if ([_selectDataArr[i][j][@"selected"] isEqualToString:@"0"]) {
                _allButton.selected=NO;
            }
        }
    }
    sender.selected = !sender.selected;
    [self.tableView reloadData];
    [self changeAllPrice];
}
- (void)changeAllState:(UIButton *)sender
{
    for (int i=0; i<[_selectDataArr count]; i++) {
        for (int x=0; x<[_selectDataArr[i] count]; x++) {
            NSMutableDictionary *dic=[[_selectDataArr objectAtIndex:i] objectAtIndex:x];
            [dic setObject:[NSString stringWithFormat:@"%d",!sender.selected] forKey:@"selected"];
            if ([dic[@"count"] intValue]==0) {
                [dic setObject:[NSString stringWithFormat:@"1"] forKey:@"count"];
            }
        }
    }
    sender.selected=!sender.selected;
    [self.tableView reloadData];
    [self changeAllPrice];
    
}
- (void)changeAllPrice
{
    float totalPrice=0;
    for (int i=0; i < _dataArr.count; i++) {
        for (int x=0; x<[[_dataArr[i] goods] count]; x++) {
            if ([_selectDataArr[i][x][@"selected"] intValue]==1) {
                totalPrice += ([[_dataArr[i] goods][x][@"goods_price"] floatValue] * [_selectDataArr[i][x][@"count"] intValue]);
            }
        }
    }
    self.allPriceLabel.text=[NSString stringWithFormat:@"总价:￥%.2f",totalPrice];
    HBSLog(@"%@", self.allPriceLabel.text);
    
}
- (void)goPayAction:(UIButton *)sender
{
    if ([self.allPriceLabel.text isEqualToString:@"总价:￥0.00"]) {
        
//        [SVProgressHUD showSuccessWithStatus:@"345678"];
        [self setupSuccessedLabel];
        
    }else{
        
    NSMutableArray *dataArr = [NSMutableArray new];
    NSInteger tt = 0;
    bool isAdd = YES;
    for (int i = 0; i < _dataArr.count; i++) {
        NSMutableDictionary *dic = [NSMutableDictionary new];
        NSMutableArray *temp = [NSMutableArray new];
        for (int j = 0; j < [[_dataArr[i] goods] count]; j++) {
            if ([self.selectDataArr[i][j][@"selected"] integerValue] == 1) {
                [temp addObject:[_dataArr[i] goods][j]];
                [dic setObject:temp forKey:@"goods"];
                isAdd = YES;
            }else{
                isAdd = NO;
            }
            
        }
        if (isAdd) {            
            [dataArr addObject:dic];
            [dataArr[tt] setObject:[_dataArr[i]store_id] forKey:@"store_id"];
            [dataArr[tt] setObject:[_dataArr[i]store_name] forKey:@"store_name"];
            tt++;
        }else{
            
        }
    }
    
    WeddingOrderViewController *orderVC = [[WeddingOrderViewController alloc] init];
    orderVC.dataArr = dataArr;
    orderVC.isCar = YES;
    [self.navigationController pushViewController:orderVC animated:YES];
    }
}
#pragma mark----评价成功弹框
- (void)setupSuccessedLabel{
    
    self.endLabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH / 2 - 90, HEIGHT / 2 - 25, 210, 50)];
    self.endLabel.backgroundColor = [UIColor blackColor];
    self.endLabel.alpha = 0.5;
    _endLabel.layer.cornerRadius = 10;
    _endLabel.layer.masksToBounds = YES;
    _endLabel.textColor = BAISE;
    _endLabel.text = @"亲* 您还没有选择宝贝哦!";
    _endLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.endLabel];
    CATransition * transion = [CATransition animation];
    transion.type = @"push";//设置动画方式
    transion.subtype = @"fromTop";//设置动画从那个方向开始
    [_endLabel.layer addAnimation:transion forKey:nil];
    //Label.layer 添加动画
    //设置延时效果
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(),^{
        [_endLabel removeFromSuperview];
       
    });
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self.view endEditing:YES];
}
@end
