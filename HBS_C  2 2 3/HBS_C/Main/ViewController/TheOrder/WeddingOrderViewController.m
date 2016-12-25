//
//  WeddingOrderViewController.m
//  HBS_C
//
//  Created by wangzuowen on 16/11/1.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "WeddingOrderViewController.h"
#import "WeddingOrderTableViewCell.h"
#import "MainModel.h"
#import "AddressListViewController.h"
#import "PayMoneyViewController.h"

@interface WeddingOrderViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)UIView *headerView;

@property (nonatomic, assign)NSInteger tt;//jilu


@property (nonatomic, strong)UILabel *noteLabel;
@property (nonatomic, strong)UILabel *emsLabel;
@property (nonatomic, strong)UILabel *allLabel;
@property (nonatomic, strong)UITextField *noteTF;
@property (nonatomic, strong)UILabel *emsMonetLabel;
@property (nonatomic, strong)UILabel *allMonetLabel;
@property (nonatomic, strong)UILabel *line1Label;
@property (nonatomic, strong)UILabel *line2Label;

@property (nonatomic, strong)UILabel *allPriceLabel;

//tou
@property (nonatomic, strong)UIImageView *locationImage;
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UILabel *adressLabel;
@property (nonatomic, strong)UILabel *titleLabel;

@property (nonatomic, copy)NSString *addr_id;

@property (nonatomic, assign)CGPoint point;

@end

@implementation WeddingOrderViewController

- (instancetype)init
{
    self = [super init];
    
    _dataArr = [NSMutableArray new];
    _headerArr = [NSMutableArray new];
    return self;
}

- (void)dealloc
{
    self.tableView.delegate = nil;
    _noteTF.delegate = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    TITLE = @"确认订单";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self creatTabeleView];
    [self creatFooterView];
//    [self cratHeaderView];
    [self netWorking];
    
    self.addr_id = @"";
}
- (void)textFieldDidBeginEditing:(nonnull UITextField *)textField{
//    UITableViewCell * cell=(UITableViewCell *)[[textField  superview] superview];
//    NSIndexPath *indexPath=[self.tableView indexPathForCell:cell];
//    if (indexPath.section==0) {
//        
//    }else {
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        [UIView setAnimationDuration:0.30f];
        _point = self.tableView.center;
        self.tableView.center = CGPointMake(WIDTH / 2, 120);
        [UIView commitAnimations];
//    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
//    UITableViewCell * cell=(UITableViewCell *)[[textField  superview] superview];
//    NSIndexPath *indexPath=[self.tableView indexPathForCell:cell];
//    if (indexPath.section==0) {
//        
//    }else {
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        [UIView setAnimationDuration:0.30f];
        self.tableView.center = _point;
        [UIView commitAnimations];
//    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_noteTF resignFirstResponder];
}
- (void)netWorking
{
    [self showLoadingViewWithMessage];
    [HBSNetWork getUrl:[NSString stringWithFormat:@"%@cart/address/%@", HBSNetAdress, [ProjectCache getLoginMessage][@"user_id"]] paramaters:nil header:@"stoken" cookie:nil Result:^(id result) {
        if ([result[@"code"] integerValue] == 200) {
            
            self.headerArr = result[@"result"];
            if (_headerArr.count == 0) {
                _addr_id = @"";
            }else{
                _addr_id = self.headerArr[0][@"addr_id"];
            }
            [self cratHeaderView];
            [self.tableView reloadData];
            
        }else if([result[@"code"] integerValue] == 201){
            self.headerArr = [@[] mutableCopy];
            [self cratHeaderView];
            [self.tableView reloadData];
            
        }
        [self removeLodingView];
    }];
}

-(void)creatFooterView
{
    UIView *footerView = ViewAlloc(0, HEIGHT - 49 * HSHIPEI, WIDTH, 49 * HSHIPEI);
    footerView.backgroundColor = WZWClearColor;
    [self.view addSubview:footerView];
    
    _allPriceLabel = LabelAlloc(10, 0, WIDTH - 135 * WSHIPEI, 49 * HSHIPEI);
    _allPriceLabel.textColor = FENSE;
    _allPriceLabel.textAlignment = NSTextAlignmentRight;
    [footerView addSubview:_allPriceLabel];
    if(_isCar){
        CGFloat pp = 0.00;
        for (int i = 0; i < [_dataArr count]; i++) {
            for (int j = 0; j < [_dataArr[i][@"goods"] count]; j++) {
                pp += [self.dataArr[i][@"goods"][j][@"goods_price"] floatValue] * [self.dataArr[i][@"goods"][j][@"goods_quantity"] floatValue];
            }
        }
        _allPriceLabel.text = [NSString stringWithFormat:@"总计:¥%.2f", pp];
    }
    
    UIButton *putButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [putButton setTitle:@"提交订单" forState:UIControlStateNormal];
    [putButton setTitleColor:BAISE forState:UIControlStateNormal];
    putButton.backgroundColor = FENSE;
    putButton.frame = CGRectMake(WIDTH - 110 * WSHIPEI, 0, 110 * WSHIPEI, 49 * HSHIPEI);
    [putButton addTarget:self action:@selector(putOrder:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:putButton];
}
- (void)cratHeaderView
{
    
    _headerView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 105)];
    _headerView.backgroundColor = BEIJINGSE;
    
    
        _titleLabel = LabelAlloc(15, _headerView.height / 2 - 5, WIDTH - 35, 30);
        _titleLabel.text = @"请选择收货地址";
        _titleLabel.textColor = HEISE;
        [_headerView addSubview:_titleLabel];

    
        _locationImage = ImageAlloc(10, 24, 18, 25);
        _locationImage.image = [UIImage imageNamed:@"icon_1_2_3_dizhi@2x"];
        [_headerView addSubview:_locationImage];
        
        _nameLabel = LabelAlloc(46, 15, (WIDTH - 46 - 30) * WSHIPEI, 20);
        _nameLabel.textColor = HEISE;
        _nameLabel.font = FONT(14);
//        _nameLabel.backgroundColor = WZWmagentaColor;
        [_headerView addSubview:_nameLabel];
        
        _adressLabel = LabelAlloc(46, 50, (WIDTH - 46 - 30) * WSHIPEI, 40);
        _adressLabel.numberOfLines = 0;
        _adressLabel.textColor = HEISE;
        _adressLabel.font = FONT(14);
    
//        _adressLabel.backgroundColor = WZWorangeColor;
        [_headerView addSubview:_adressLabel];
        
        UIImageView *rightImage = ImageAlloc(WIDTH - 19, 29, 9, 16);
        rightImage.image = [UIImage imageNamed:@"icon_1_2_youjiantou@2x"];
        [_headerView addSubview:rightImage];
        
        UILabel *label = LabelAlloc(0, 100, WIDTH, 5);
        label.backgroundColor = BEIJINGSE;
        [_headerView addSubview:label];

        UIButton *chooseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        chooseButton.frame = self.headerView.frame;
        chooseButton.backgroundColor = WZWClearColor;
        [chooseButton addTarget:self action:@selector(headerChooseAction) forControlEvents:UIControlEventTouchUpInside];
        [_headerView addSubview:chooseButton];
    if (_headerArr.count == 0 || [_headerArr isEqual:[NSNull null]]) {
        _titleLabel.hidden = NO;
        _locationImage.hidden = YES;
        _nameLabel.hidden = YES;
        _adressLabel.hidden = YES;
    }else{
        _titleLabel.hidden = YES;
        _locationImage.hidden = NO;
        _nameLabel.hidden = NO;
        _adressLabel.hidden = NO;
        _nameLabel.text = [NSString stringWithFormat:@"收货人:%@    %@", self.headerArr[0][@"consignee"], self.headerArr[0][@"phone_mob"]];
        _adressLabel.text = [NSString stringWithFormat:@"收货地址:%@%@", self.headerArr[0][@"region_name"], self.headerArr[0][@"address"]];
    }
    
    self.tableView.tableHeaderView = _headerView;
}
#pragma mark - 选着地址
- (void)headerChooseAction
{
    AddressListViewController *addVC = [[AddressListViewController alloc] init];
    __weak typeof(self)weakself = self;
    addVC.block = ^(MainModel *model){
        weakself.addr_id = model.addr_id;
        weakself.titleLabel.hidden = YES;
        weakself.locationImage.hidden = NO;
        weakself.nameLabel.hidden = NO;
        weakself.adressLabel.hidden = NO;
        weakself.nameLabel.text = [NSString stringWithFormat:@"收货人:%@    %@", model.consignee, model.phone_mob];
        weakself.adressLabel.text = [NSString stringWithFormat:@"收货地址:%@%@", model.region_name, model.address];
    };
    addVC.isOrder = YES;
    [self.navigationController pushViewController:addVC animated:YES];
}
- (void)creatTabeleView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64 - (49 * HSHIPEI)) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView.backgroundColor = [UIColor clearColor];
//    _tableView.sectionHeaderHeight = 30.0f;
    _tableView.sectionFooterHeight = 123.0f;
    _tableView.rowHeight = 110.0f;
    [self.view addSubview:_tableView];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45.0f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 45)];
    //    vv.backgroundColor = BEIJINGSE;
    UILabel *grayLabel = LabelAlloc(0, 0, WIDTH, 5);
    grayLabel.backgroundColor = BEIJINGSE;
    [vv addSubview:grayLabel];
    UILabel *label = LabelAlloc(10, 15, WIDTH - 20, 20);
    label.font = FONT(15);
    if (_isCar) {
        label.text = self.dataArr[section][@"store_name"];
    }else{
        label.text = self.dataArr[section][@"goods_store_name"];
    }
    [vv addSubview:label];
    
    return vv;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 30)];
//    footerView.backgroundColor = WZWmagentaColor;
    
    _noteLabel = [[UILabel alloc] init];
    _noteLabel.font = FONT(14);
    _noteLabel.textColor = HEISE;
    [footerView addSubview:_noteLabel];
    
    _emsLabel = [[UILabel alloc] init];
    _emsLabel.font = FONT(14);
    _emsLabel.textColor = HEISE;
    [footerView addSubview:_emsLabel];
    
    _allLabel = [[UILabel alloc] init];
    _allLabel.font = FONT(14);
    _allLabel.textColor = HEISE;
    [footerView addSubview:_allLabel];
    
    _noteTF = [[UITextField alloc] init];
    _noteTF.returnKeyType = UIReturnKeyDone;
    _noteTF.delegate = self;
    _noteTF.tag = section + 2333;
    _noteTF.textAlignment = NSTextAlignmentRight;
    _noteTF.placeholder = @"(建议填写与卖家达成一致的留言)";
    _noteTF.font = FONT(14);
    _noteTF.textColor = erlingsiColor;
    [footerView addSubview:_noteTF];
    
    _emsMonetLabel = [[UILabel alloc] init];
    _emsMonetLabel.textAlignment = NSTextAlignmentRight;
    _emsMonetLabel.font = FONT(14);
    _emsMonetLabel.textColor = HEISE;
    [footerView addSubview:_emsMonetLabel];
    
    _allMonetLabel = [[UILabel alloc] init];
    _allMonetLabel.textAlignment = NSTextAlignmentRight;
    _allMonetLabel.font = FONT(15);
    _allMonetLabel.textColor = FENSE;
    [footerView addSubview:_allMonetLabel];
    
    _line1Label = [[UILabel alloc] init];
    _line1Label.backgroundColor = BEIJINGSE;
    [footerView addSubview:_line1Label];
    
    _line2Label = [[UILabel alloc] init];
    _line2Label.backgroundColor = BEIJINGSE;
    [footerView addSubview:_line2Label];
    
//    _noteLabel.backgroundColor = WZWgrayColor;
//    _noteTF.backgroundColor = WZWorangeColor;
//    _emsLabel.backgroundColor = WZWgrayColor;
//    _emsMonetLabel.backgroundColor = WZWorangeColor;
//    _allLabel.backgroundColor = WZWgrayColor;
//    _allMonetLabel.backgroundColor = WZWorangeColor;
    
    [_noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    [_noteTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.noteLabel.mas_right);
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 20 - 80, 20));
    }];
    [_line1Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(_noteLabel.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 20, 1));
    }];
    [_emsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(_line1Label.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    [_emsMonetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_noteLabel.mas_right);
        make.top.mas_equalTo(_emsLabel.mas_top);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 20 - 80, 20));
    }];
    [_line2Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(_emsLabel.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 20, 1));
    }];
    [_allLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(_line2Label.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    [_allMonetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_allLabel.mas_right);
        make.top.mas_equalTo(_allLabel.mas_top);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 20 - 80, 20));
    }];

    _emsMonetLabel.text = @"包邮";
    if (_isCar) {
        CGFloat pp = 0;
        for (int i = 0; i < [_dataArr[section][@"goods"] count]; i++) {
            pp += [self.dataArr[section][@"goods"][i][@"goods_price"] floatValue] * [self.dataArr[section][@"goods"][i][@"goods_quantity"] floatValue];
        }
        _allMonetLabel.text = [NSString stringWithFormat:@"¥%.2f", pp];
        
    }else{
        if ([self.specStr isEqualToString:@""]) {
            _allMonetLabel.text = [NSString stringWithFormat:@"¥%.2f", [self.dataArr[section][@"goods_price"] floatValue] * [self.buyNumber floatValue]];
            
            _allPriceLabel.text = [NSString stringWithFormat:@"总计:¥%.2f", [self.dataArr[section][@"goods_price"] floatValue] * [self.buyNumber floatValue]];
        }else{
            
            _allMonetLabel.text = [NSString stringWithFormat:@"¥%.2f", [self.dataArr[section][@"goods_spec"][self.chossePage][@"goods_price"] floatValue] * [self.buyNumber floatValue]];
            
            _allPriceLabel.text = [NSString stringWithFormat:@"总计:¥%.2f", [self.dataArr[section][@"goods_spec"][self.chossePage][@"goods_price"] floatValue] * [self.buyNumber floatValue]];
        }
    }
    
    _noteLabel.text = @"买家留言:";
    _emsLabel.text = @"配送方式:";
    _allLabel.text = @"店铺总计:";
    
    return footerView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArr.count;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!_isCar) {
        return 1;
    }else{
        return [_dataArr[section][@"goods"] count];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"cell";
    WeddingOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[WeddingOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
//    __weak typeof(self)weakself = self;
//    cell.block = ^(NSInteger tt) {
//        weakself.tt = tt;
//        NSLog(@"数量:%ld, 区:%ld , 行:%ld", (long)self.tt, indexPath.section, indexPath.row);
//        [weakself.dataArr[indexPath.section][@"goods"][indexPath.row] setObject:[NSString stringWithFormat:@"%ld", tt] forKey:@"goods_quantity"];
//        [weakself.tableView reloadData];
        
//        CGFloat pp = 0.00;
//        for (int i = 0; i < [_dataArr[indexPath.section][@"goods"] count]; i++) {
//            pp += [self.dataArr[section][@"goods"][i][@"goods_price"] doubleValue] * [self.dataArr[section][@"goods"][i][@"goods_quantity"] doubleValue];
//        }
//        self.allMonetLabel.text = [NSString stringWithFormat:@"¥%2f", pp];
//    };
    if (_isCar) {
        cell.isCar = YES;
        cell.dic = self.dataArr[indexPath.section][@"goods"][indexPath.row];
        
    }else{
        cell.specName = self.specStr;
        cell.buyNumber = self.buyNumber;
        cell.choosePage = self.chossePage;
        cell.isCar = NO;
        cell.dic = self.dataArr[indexPath.row];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    [_noteTF resignFirstResponder];
}
- (void)putOrder:(UIButton *)sender
{
    if([_addr_id isEqualToString:@""] || [_addr_id isEqual:[NSNull null]])
    {
        [self creatAlertViewOne:@"请选择收货地址" message:nil sureStr:@"确定" sureAction:^(id result) {
            
        }];
    }else{
        if ([self checkWIFI]) {
            [self showLoadingViewWithMessage];
            if (_isCar) {
                NSString *str = @"";
                NSMutableDictionary *noteDic = [NSMutableDictionary dictionary];
                for (int i = 0; i < _dataArr.count; i++) {
                    UITextField *tf = (UITextField *)[self.view viewWithTag:2333 + i];
                    [noteDic setObject:[tf.text isEqual:[NSNull null]]?@"":tf.text forKey:_dataArr[i][@"store_id"]];
                    for (int j = 0; j < [_dataArr[i][@"goods"] count]; j++) {
                        if(j == [_dataArr[i][@"goods"] count] - 1){
                            str = [NSString stringWithFormat:@"%@%@",str,self.dataArr[i][@"goods"][j][@"rec_id"]];
                            
                        }else if (j == 0){
                            str = [NSString stringWithFormat:@"%@-",self.dataArr[i][@"goods"][j][@"rec_id"]];
                        }else{
                            str = [NSString stringWithFormat:@"%@-%@-",str,self.dataArr[i][@"goods"][j][@"rec_id"]];
                        }
                    }
                }
                
                NSDictionary *dic = @{@"user_id":[ProjectCache getLoginMessage][@"user_id"],
                                      @"rec_ids":str,
                                      @"addr_id":self.addr_id,
                                      @"message_comp":[ProjectCache DataTOjsonString:noteDic],
                                      @"goods_shipping":@""};
                
                [HBSNetWork postUrl:[NSString stringWithFormat:@"%@order/cart", HBSNetAdress] parame:dic header:@"c02b68e88c44385f56064ce4cd49b319" cookie:nil result:^(id result) {
                    if ([result[@"code"] integerValue] == 200) {
                        PayMoneyViewController *payVC = [[PayMoneyViewController alloc] init];
                        payVC.dicInfo = result[@"result"];
                        [self.navigationController pushViewController:payVC animated:YES];

                    }
                    [self removeLodingView];
                }];
                
            }else{
                NSDictionary *dic = @{@"user_id":[ProjectCache getLoginMessage][@"user_id"],
                                      @"goods_id":self.dataArr[0][@"goods_id"],
                                      @"quantity":self.buyNumber,
                                      @"note":[self.noteTF.text isEqualToString:@""]?@"":self.noteTF.text,
                                      @"addr_id":self.addr_id,
                                      @"spec_id":self.specId};
                [HBSNetWork postUrl:[NSString stringWithFormat:@"%@order/product", HBSNetAdress] parame:dic header:@"c02b68e88c44385f56064ce4cd49b319" cookie:nil result:^(id result) {
                    if ([result[@"code"] integerValue] == 200) {
                        PayMoneyViewController *payVC = [[PayMoneyViewController alloc] init];
                        payVC.dicInfo = result[@"result"];
                        [self.navigationController pushViewController:payVC animated:YES];
                    }
                    [self removeLodingView];
                }];
            }
            
        }else{
            [self creatAlertViewOne:@"温馨提示" message:@"当期无网络,请检查WiFi和数据" sureStr:@"确定" sureAction:^(id result) {
                
            }];
        }
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
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
