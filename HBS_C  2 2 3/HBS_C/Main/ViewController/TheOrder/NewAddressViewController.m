//
//  NewAddressViewController.m
//  HBS_C
//
//  Created by wangzuowen on 16/11/7.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "NewAddressViewController.h"

@interface NewAddressViewController ()<UITextFieldDelegate>

{
    UIPickerView *picker;
    NSDictionary *areaDic;
    NSArray *province;
    NSArray *city;
    NSArray *district;
    
    NSString *selectedProvince;
}
@property (nonatomic, strong)UITextField *peopleTF;
@property (nonatomic, strong)UITextField *phoneTF;
@property (nonatomic, strong)UILabel *adressLabel;
@property (nonatomic, strong)UITextField *detailedTF;
@property (nonatomic, strong)UISwitch *mySwitch;


@end

@implementation NewAddressViewController

- (void)dealloc
{
    _peopleTF.delegate = nil;
    _phoneTF.delegate = nil;
    _detailedTF.delegate = nil;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_phoneTF resignFirstResponder];
    [_detailedTF resignFirstResponder];
    [_peopleTF resignFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (_isOne) {
        TITLE = @"新增收货地址";
    }else{
        TITLE = @"修改收货地址";
        UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteButton.titleLabel.font = FONT(16);
//        deleteButton.backgroundColor = WZWorangeColor;
        [deleteButton setTitleColor:FENSE forState:UIControlStateNormal];
        deleteButton.frame = CGRectMake(0, 0, 60, 30);
        [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [deleteButton addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:deleteButton];
    }
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setUp_UI];
    
}
- (void)deleteAction
{
    NSDictionary *dic = @{@"addr_id":self.model.addr_id};
    [HBSNetWork deleteUrl:[NSString stringWithFormat:@"%@cart/addressDelete/%@", HBSNetAdress, [ProjectCache getLoginMessage][@"user_id"]] parame:dic cookie:nil result:^(id result) {
        if ([result[@"code"] integerValue] == 200) {
            [self creatAlertViewOne:@"删除成功" message:nil sureStr:@"确定" sureAction:^(id result) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
    }];
}
- (void)setUp_UI
{
    UILabel *nameLabel = LabelAlloc(10, 15 + 64, 60, 20);
    nameLabel.text = @"收货人";
//    nameLabel.backgroundColor = WZWorangeColor;
    nameLabel.font = FONT(14);
    nameLabel.textColor = HEISE;
    [self.view addSubview:nameLabel];
    
    _peopleTF = TextFieldAlloc(60 + 30 * WSHIPEI, 15 + 64, WIDTH - 60 + 30 * WSHIPEI - 10, 20);
    _peopleTF.returnKeyType = UIReturnKeyDone;
    _peopleTF.delegate = self;
    _peopleTF.font = FONT(14);
    _peopleTF.placeholder = @"请输入收货人姓名";
    _peopleTF.textColor = HEISE;
    [self.view addSubview:_peopleTF];
    
    UILabel *line1Label = LabelAlloc(10, 50 + 64, WIDTH - 20, 1);
    line1Label.backgroundColor = BEIJINGSE;
    [self.view addSubview:line1Label];
    
    UILabel *phoneLabel = LabelAlloc(10, 66 + 64, 60, 20);
    phoneLabel.text = @"手机号码";
    phoneLabel.font = FONT(14);
    phoneLabel.textColor = HEISE;
    [self.view addSubview:phoneLabel];
    
    _phoneTF = TextFieldAlloc(60 + 30 * WSHIPEI, 66 + 64, WIDTH - 60 + 30 * WSHIPEI - 10, 20);
    _phoneTF.returnKeyType = UIReturnKeyDone;
    _phoneTF.font = FONT(14);
    _phoneTF.delegate = self;
    _phoneTF.placeholder = @"请输入收货人手机号码";
    _phoneTF.textColor = HEISE;
    [self.view addSubview:_phoneTF];
    
    UILabel *line2Label = LabelAlloc(10, 101 + 64, WIDTH - 20, 1);
    line2Label.backgroundColor = BEIJINGSE;
    [self.view addSubview:line2Label];
    
    UILabel *adress1Label = LabelAlloc(10, 117 + 64, 60, 20);
    adress1Label.text = @"收货区域";
    adress1Label.font = FONT(14);
    adress1Label.textColor = HEISE;
    [self.view addSubview:adress1Label];
    
    _adressLabel = LabelAlloc(60 + 30 * WSHIPEI, 117 + 64, WIDTH - 60 + 30 * WSHIPEI - 10 - 10, 20);
    _adressLabel.font = FONT(14);
    _adressLabel.textColor = HEISE;
    [self.view addSubview:_adressLabel];
    
    UIImageView *rightImage = ImageAlloc(WIDTH - 19, 117 + 64, 9, 16);
    rightImage.image = [UIImage imageNamed:@"icon_1_2_youjiantou@2x"];
    [self.view addSubview:rightImage];
    
    UIButton *chooseAdressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    chooseAdressBtn.frame = CGRectMake(60, 117 + 64, WIDTH - 60, 20);
    chooseAdressBtn.backgroundColor = WZWClearColor;
    [chooseAdressBtn addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:chooseAdressBtn];
    
    UILabel *line3Label = LabelAlloc(10, 153 + 64, WIDTH - 20, 1);
    line3Label.backgroundColor = BEIJINGSE;
    [self.view addSubview:line3Label];
    
    UILabel *detailLabel = LabelAlloc(10, 169 + 64, 60, 20);
    detailLabel.text = @"详细地址";
    detailLabel.font = FONT(14);
    detailLabel.textColor = HEISE;
    [self.view addSubview:detailLabel];
    
    _detailedTF = TextFieldAlloc(60 + 30 * WSHIPEI, 169 + 64, WIDTH - 60 + 30 * WSHIPEI - 10, 20);
    _detailedTF.returnKeyType = UIReturnKeyDone;
    _detailedTF.delegate = self;
    _detailedTF.font = FONT(14);
    _detailedTF.placeholder = @"请输入详细地址";
    _detailedTF.textColor = HEISE;
    [self.view addSubview:_detailedTF];
    
    UILabel *line4Label = LabelAlloc(10, 204 + 64, WIDTH - 20, 1);
    line4Label.backgroundColor = BEIJINGSE;
    [self.view addSubview:line4Label];
    
    UILabel *grayLabel1 = LabelAlloc(0, 205 + 64, WIDTH, 10);
    grayLabel1.backgroundColor = BEIJINGSE;
    [self.view addSubview:grayLabel1];
    
    UILabel *setAddLabel = LabelAlloc(10, 230 + 64, 100, 20);
    setAddLabel.text = @"设置为默认地址";
    setAddLabel.font = FONT(14);
    setAddLabel.textColor = HEISE;
    [self.view addSubview:setAddLabel];
    
    self.mySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(WIDTH - 70, 225 + 64, 60, 30)];
    [self.view addSubview:self.mySwitch];
    
    UILabel *grayLabel = LabelAlloc(0, 265 + 64, WIDTH, HEIGHT - 265 - 64);
    grayLabel.backgroundColor = BEIJINGSE;
    [self.view addSubview:grayLabel];
    
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    saveButton.frame = CGRectMake(0 , HEIGHT - 49 * HSHIPEI, WIDTH, HSHIPEI * 49);
    [saveButton addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    saveButton.backgroundColor = FENSE;
    [saveButton setTintColor:BAISE];
    saveButton.titleLabel.font = FONT(14);
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [self.view addSubview:saveButton];
    
    if ([self.model.def_recive isEqualToString:@"1"]) {
        self.mySwitch.on = YES;
    }
    if (!_isOne) {
        self.peopleTF.text = self.model.consignee;
        self.phoneTF.text = self.model.phone_mob;
        self.adressLabel.text = self.model.region_name;
        self.detailedTF.text = self.model.address;
    }
}
- (void)saveAction
{
    if([_peopleTF.text isEqualToString:@""] || [_peopleTF.text isEqual:[NSNull null ]]){
        [self creatAlertViewOne:@"提示" message:@"请输入收货人姓名" sureStr:@"确定" sureAction:^(id result) {
            return ;
        }];
    }else if([_phoneTF.text isEqualToString:@""] || [_phoneTF.text isEqual:[NSNull null ]]){
        [self creatAlertViewOne:@"提示" message:@"请输入收货人联系方式" sureStr:@"确定" sureAction:^(id result) {
            return ;
        }];
    }else{
        if(_isOne){
            NSDictionary *dic = @{@"id":[ProjectCache getLoginMessage][@"user_id"]
                                  ,
                                  @"consignee":self.peopleTF.text,
                                  @"region_name":self.adressLabel.text,
                                  @"address":self.detailedTF.text,
                                  @"phone_mob":self.phoneTF.text,
                                  @"def_recive":[NSString stringWithFormat:@"%d", self.mySwitch.on]};
            [HBSNetWork postUrl:[NSString stringWithFormat:@"%@cart/addressAdd", HBSNetAdress] parame:dic header:nil cookie:nil
                         result:^(id result) {
                             if ([result[@"code"] integerValue] == 200) {
                                 [self.navigationController popViewControllerAnimated:YES];
                             }else{
                                 [self creatAlertViewOne:@"提示" message:@"保存失败" sureStr:@"确定" sureAction:^(id result) {
                                     
                                 }];
                             }
                         }];
        }else{
            NSDictionary *dic = @{@"consignee":self.peopleTF.text,
                                  @"region_name":self.adressLabel.text,
                                  @"address":self.detailedTF.text,
                                  @"phone_mob":self.phoneTF.text,
                                  @"def_recive":[NSString stringWithFormat:@"%d", self.mySwitch.on],
                                  @"addr_id":self.model.addr_id};
            
            [HBSNetWork putUrl:[NSString stringWithFormat:@"%@cart/addressModify/%@", HBSNetAdress, [ProjectCache getLoginMessage][@"user_id"]] parame:dic header:@"c02b68e88c44385f56064ce4cd49b319" cookie:nil result:^(id result) {
                if ([result[@"code"] integerValue] == 200) {
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    [self creatAlertViewOne:@"提示" message:@"修改失败" sureStr:@"确定" sureAction:^(id result) {
                        
                    }];
                }
            }];
            
        }

    }
}
#pragma mark - 省市区选择
- (void)chooseAction:(UIButton *)sender
{
    [sender setExclusiveTouch:YES];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"areaYuanban" ofType:@"plist"];
    areaDic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    NSArray *components = [areaDic allKeys];
    NSArray *sortedArray = [components sortedArrayUsingComparator: ^(id obj1, id obj2) {
        
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    NSMutableArray *provinceTmp = [[NSMutableArray alloc] init];
    for (int i=0; i<[sortedArray count]; i++) {
        NSString *index = [sortedArray objectAtIndex:i];
        NSArray *tmp = [[areaDic objectForKey: index] allKeys];
        [provinceTmp addObject: [tmp objectAtIndex:0]];
    }
    
    province = [[NSArray alloc] initWithArray: provinceTmp];
    
    NSString *index = [sortedArray objectAtIndex:0];
    NSString *selected = [province objectAtIndex:0];
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [[areaDic objectForKey:index]objectForKey:selected]];
    
    NSArray *cityArray = [dic allKeys];
    NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary: [dic objectForKey: [cityArray objectAtIndex:0]]];
    city = [[NSArray alloc] initWithArray: [cityDic allKeys]];
    
    
    NSString *selectedCity = [city objectAtIndex: 0];
    district = [[NSArray alloc] initWithArray: [cityDic objectForKey: selectedCity]];
    
    
    
    picker = [[UIPickerView alloc] initWithFrame: CGRectMake(0, 0, WIDTH, 240)];
    picker.dataSource = self;
    picker.delegate = self;
    picker.showsSelectionIndicator = YES;
    [picker selectRow: 0 inComponent: 0 animated: YES];
    
    selectedProvince = [province objectAtIndex: 0];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSInteger provinceIndex = [picker selectedRowInComponent: PROVINCE_COMPONENT];
        NSInteger cityIndex = [picker selectedRowInComponent: CITY_COMPONENT];
        NSInteger districtIndex = [picker selectedRowInComponent: DISTRICT_COMPONENT];
        
        NSString *provinceStr = [province objectAtIndex: provinceIndex];
        NSString *cityStr = [city objectAtIndex: cityIndex];
        NSString *districtStr = [district objectAtIndex:districtIndex];
        
        if ([provinceStr isEqualToString: cityStr] && [cityStr isEqualToString: districtStr]) {
            cityStr = @"";
            districtStr = @"";
        }
        else if ([cityStr isEqualToString: districtStr]) {
            districtStr = @"";
        }
        
        NSString *showMsg = [NSString stringWithFormat: @"%@ %@ %@", provinceStr, cityStr, districtStr];
        self.adressLabel.text=showMsg;
    }];
    
    [alertController.view addSubview:picker];
    [alertController addAction:cancleAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
#pragma mark- Picker Data Source Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == PROVINCE_COMPONENT) {
        return [province count];
    }
    else if (component == CITY_COMPONENT) {
        return [city count];
    }
    else {
        return [district count];
    }
}
#pragma mark- Picker Delegate Methods

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == PROVINCE_COMPONENT) {
        return [province objectAtIndex: row];
    }
    else if (component == CITY_COMPONENT) {
        return [city objectAtIndex: row];
    }
    else {
        return [district objectAtIndex: row];
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == PROVINCE_COMPONENT) {
        selectedProvince = [province objectAtIndex: row];
        NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: [areaDic objectForKey: [NSString stringWithFormat:@"%ld", (long)row]]];
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [tmp objectForKey: selectedProvince]];
        NSArray *cityArray = [dic allKeys];
        NSArray *sortedArray = [cityArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
            
            if ([obj1 integerValue] > [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedDescending;//递减
            }
            
            if ([obj1 integerValue] < [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedAscending;//上升
            }
            return (NSComparisonResult)NSOrderedSame;
        }];
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int i=0; i<[sortedArray count]; i++) {
            NSString *index = [sortedArray objectAtIndex:i];
            NSArray *temp = [[dic objectForKey: index] allKeys];
            [array addObject: [temp objectAtIndex:0]];
        }
        
        city = [[NSArray alloc] initWithArray: array];
        
        NSDictionary *cityDic = [dic objectForKey: [sortedArray objectAtIndex: 0]];
        district = [[NSArray alloc] initWithArray: [cityDic objectForKey: [city objectAtIndex: 0]]];
        [picker selectRow: 0 inComponent: CITY_COMPONENT animated: YES];
        [picker selectRow: 0 inComponent: DISTRICT_COMPONENT animated: YES];
        [picker reloadComponent: CITY_COMPONENT];
        [picker reloadComponent: DISTRICT_COMPONENT];
        
    }
    else if (component == CITY_COMPONENT) {
        NSString *provinceIndex = [NSString stringWithFormat: @"%lu", (unsigned long)[province indexOfObject: selectedProvince]];
        NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: [areaDic objectForKey: provinceIndex]];
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [tmp objectForKey: selectedProvince]];
        NSArray *dicKeyArray = [dic allKeys];
        NSArray *sortedArray = [dicKeyArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
            
            if ([obj1 integerValue] > [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedDescending;
            }
            
            if ([obj1 integerValue] < [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedAscending;
            }
            return (NSComparisonResult)NSOrderedSame;
        }];
        
        NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary: [dic objectForKey: [sortedArray objectAtIndex: row]]];
        NSArray *cityKeyArray = [cityDic allKeys];
        
        district = [[NSArray alloc] initWithArray: [cityDic objectForKey: [cityKeyArray objectAtIndex:0]]];
        [picker selectRow: 0 inComponent: DISTRICT_COMPONENT animated: YES];
        [picker reloadComponent: DISTRICT_COMPONENT];
    }
    
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (component == PROVINCE_COMPONENT) {
        return 80;
    }
    else if (component == CITY_COMPONENT) {
        return 100;
    }
    else {
        return 115;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *myView = nil;
    
    if (component == PROVINCE_COMPONENT) {
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 78, 30)] ;
        myView.textAlignment = 1;
        myView.text = [province objectAtIndex:row];
        myView.font = [UIFont systemFontOfSize:14];
        myView.backgroundColor = [UIColor clearColor];
    }
    else if (component == CITY_COMPONENT) {
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 95, 30)] ;
        myView.textAlignment = 1;
        myView.text = [city objectAtIndex:row];
        myView.font = [UIFont systemFontOfSize:14];
        myView.backgroundColor = [UIColor clearColor];
    }
    else {
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 110, 30)] ;
        myView.textAlignment = 1;
        myView.text = [district objectAtIndex:row];
        myView.font = [UIFont systemFontOfSize:14];
        myView.backgroundColor = [UIColor clearColor];
    }
    
    return myView;
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
