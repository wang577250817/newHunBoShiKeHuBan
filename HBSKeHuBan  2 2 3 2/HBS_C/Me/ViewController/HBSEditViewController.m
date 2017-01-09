//
//  HBSEditViewController.m
//  HBS_C
//
//  Created by 王 世江 on 16/10/26.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//
#import "HBSEditViewController.h"
#import "MeViewController.h"
@interface HBSEditViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *leftImage;//返回image
@property (strong, nonatomic) IBOutlet UITextField *nameTextfield;
@property (strong, nonatomic) IBOutlet UIImageView *headImage;//头像image
@property (strong, nonatomic) IBOutlet UILabel *sexLabel;//性别label
@property (strong, nonatomic) IBOutlet UILabel *weddingLabel;//婚期label
@property (strong, nonatomic) IBOutlet UILabel *cityLabel;//城市label
@property (strong, nonatomic) IBOutlet UITextField *
weChatTextfield;//微信号textField
@property (nonatomic, strong) NSString *headStr;//头像字符串

@property (nonatomic, strong) NSString *districtStr;//区的ID


@end
@implementation HBSEditViewController
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
     [self getupData];
}
- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
     [self alertWithTitle:@"修改成功" message:nil sure:nil cancel:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BAISE;
    [self setUpChildControls];
   
    
}
#pragma mark----设置子控件
- (void)setUpChildControls{
    
    //返回image
    UITapGestureRecognizer *leftImage = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImage)];
    [self.leftImage addGestureRecognizer:leftImage];
    
    //头像image
    UITapGestureRecognizer *headImage = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickHeadImage)];
    [self.headImage addGestureRecognizer:headImage];
    
    //性别label
    UITapGestureRecognizer *tapSexLabel = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicktapSexLabel)];
    [self.sexLabel addGestureRecognizer:tapSexLabel];
    
    //婚期label
    UITapGestureRecognizer *tapweddingLabel = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicktapWeddingLabel)];
    [self.weddingLabel addGestureRecognizer:tapweddingLabel];
    
    //城市label
    UITapGestureRecognizer *tapCityLabel = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicktapCityLabel)];
    [self.cityLabel addGestureRecognizer:tapCityLabel];
    
}
#pragma mark----获取数据
- (void)getupData{
    
    self.nameTextfield.text = self.getEditDic[@"user_real_name"];
    self.weddingLabel.text = self.getEditDic[@"user_wedding_day"];
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:self.getEditDic[@"user_head_pic"]] placeholderImage:ZHANWEI];
    self.weChatTextfield.text = self.getEditDic[@"user_weixin"];
    self.cityLabel.text = self.getEditDic[@"user_region_name"];
    if ([self.getEditDic[@"user_gender"]isEqualToString:@"0"]) {
        self.sexLabel.text = @"保密";
    } else if ([self.getEditDic[@"user_gender"]isEqualToString:@"1"]) {
        self.sexLabel.text = @"新郎";
    }else{
          self.sexLabel.text = @"新娘";
    }
}
#pragma mark----修改头像方法
- (void)clickHeadImage{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *picker = [[UIImagePickerController alloc]init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            [self presentViewController:picker animated:YES completion:nil];
        }
        
    }]];
    
    [alertController addAction: [UIAlertAction actionWithTitle: @"从相册选取" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.delegate = self;
        [self presentViewController:imagePicker animated:YES completion:^{
          
        }];
        
        HBSLog(@"我要从相册中获取");
     
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"取消" style: UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController: alertController animated: YES completion: nil];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        NSLog(@"取消");
    }];
}
#pragma mark----获取完图片会进入到这个方法里面
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.headImage.image = info[UIImagePickerControllerEditedImage];
    NSData *data = UIImageJPEGRepresentation(self.headImage.image, 1.0f);
    self.headStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
}
#pragma mark----性别的方法
- (void)clicktapSexLabel{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"新郎" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UILabel *groomLabel = [[UILabel alloc]init];
        groomLabel.text = @"新郎";
        self.sexLabel.text = groomLabel.text;
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"新娘" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UILabel *brideLabel = [[UILabel alloc]init];
        brideLabel.text = @"新娘";
        self.sexLabel.text = brideLabel.text;
    
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"保密" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UILabel *secrectLabel = [[UILabel alloc]init];
        secrectLabel.text = @"保密";
        self.sexLabel.text = secrectLabel.text;
        
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"取消" style: UIAlertActionStyleCancel handler:nil]];
    [self presentViewController: alertController animated: YES completion: nil];

}
#pragma mark----婚期的实现方法
- (void)clicktapWeddingLabel{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    __block  UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = 1;
    datePicker.frame = CGRectMake(- 20, 0, [UIScreen mainScreen].bounds.size.width, 216);
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSDateFormatter *formattor = [[NSDateFormatter alloc] init];
        formattor.dateFormat = @"yyyy-MM-dd";
        NSString *timestamp = [formattor stringFromDate:datePicker.date];
     
        self.weddingLabel.text = timestamp;
        
    }];
    [alertController.view addSubview:datePicker];
    [alertController addAction:cancleAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
#pragma mark----城市地区的实现方法
- (void)clicktapCityLabel{
   
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
    picker11 = [[UIPickerView alloc] initWithFrame: CGRectMake(0, 0, WIDTH, 240)];
    picker11.dataSource = self;
    picker11.delegate = self;
    picker11.showsSelectionIndicator = YES;
    [picker11 selectRow: 0 inComponent: 0 animated: YES];
    
    selectedProvince = [province objectAtIndex: 0];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSInteger provinceIndex = [picker11 selectedRowInComponent: PROVINCE_COMPONENT];
        NSInteger cityIndex = [picker11 selectedRowInComponent: CITY_COMPONENT];
        NSInteger districtIndex = [picker11 selectedRowInComponent: DISTRICT_COMPONENT];
        
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
        NSLog(@"城市选择%@", showMsg);
        self.cityLabel.text = showMsg;
        
    }];
    
    [alertController.view addSubview:picker11];
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
        NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: [areaDic objectForKey: [NSString stringWithFormat:@"%d", (int)row]]];
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
        [picker11 selectRow: 0 inComponent: CITY_COMPONENT animated: YES];
        [picker11 selectRow: 0 inComponent: DISTRICT_COMPONENT animated: YES];
        [picker11 reloadComponent: CITY_COMPONENT];
        [picker11 reloadComponent: DISTRICT_COMPONENT];
        
    }
    else if (component == CITY_COMPONENT) {
        NSString *provinceIndex = [NSString stringWithFormat: @"%d", (int)[province indexOfObject: selectedProvince]];
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
        [picker11 selectRow: 0 inComponent: DISTRICT_COMPONENT animated: YES];
        [picker11 reloadComponent: DISTRICT_COMPONENT];
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
#pragma mark----提交方法
- (IBAction)submitBtn:(UIButton *)sender {
    
    if (self.nameTextfield.text.length > 14 || self.weChatTextfield.text.length > 14) {
        
        [self alertWithTitle:@"最多只能输入20字哦" message:nil sure:nil cancel:nil];
        
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = userToken;
    params[@"id"] = [ProjectCache getLoginMessage][@"user_id"];
    params[@"user_real_name"] = self.nameTextfield.text;
    params[@"user_gender"] = self.sexLabel.text;
    params[@"user_wedding_day"] = self.weddingLabel.text;
    params[@"user_head"] = self.headStr;
    params[@"user_region_id"] = self.districtStr;
    params[@"user_weixin"] = self.weChatTextfield.text;
    params[@"region_name"] = self.cityLabel.text;
    
    if ([self checkWIFI]) {
        [self showLoadingViewWithMessage];
        
        [HBSNetWork putUrl:[NSString stringWithFormat:@"%@user/%@",HBSNetAdress, params[@"id"]] parame:params header:nil cookie:nil result:^(id result) {
            
            if ([result[@"code"]integerValue] == 200) {
                

                MeViewController *my = [[MeViewController alloc]init];
                
                [self.tabBarController.tabBar setHidden:NO];
                [self.navigationController pushViewController:my animated:YES];
                
            }
            [self removeLodingView];
            
        }];
        
    }
}
#pragma mark----返回箭头
- (void)clickImage{
    
    [self.navigationController popViewControllerAnimated:YES];
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [UIView animateWithDuration:0.25 animations:^{
        
        [self.view endEditing:YES];
    }];
}
@end
