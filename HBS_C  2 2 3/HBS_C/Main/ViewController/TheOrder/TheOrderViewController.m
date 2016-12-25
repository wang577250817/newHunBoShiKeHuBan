//
//  TheOrderViewController.m
//  HBS_C
//
//  Created by wangzuowen on 16/10/28.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "TheOrderViewController.h"
#import "PayMoneyViewController.h"

@interface TheOrderViewController ()<UITextFieldDelegate>

@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UITextField *nameTextField;
@property (nonatomic, strong)UILabel *phoneLabel;
@property (nonatomic, strong)UITextField *phoneTextField;
@property (nonatomic, strong)UILabel *timeLabel;
@property (nonatomic, strong)UITextField *timeTextField;
@property (nonatomic, strong)UILabel *line1Label;
@property (nonatomic, strong)UILabel *line2Label;
@property (nonatomic, strong)UIView *view1;
@property (nonatomic, strong)UIView *view2;
@property (nonatomic, strong)UIView *view3;
@property (nonatomic, strong)UIView *view4;
@property (nonatomic, strong)UIView *view5;
@property (nonatomic, strong)UIView *view6;
@property (nonatomic, strong)UIButton *sureButton;
@property (nonatomic, strong)UIButton *rightButton;
@property (nonatomic, strong)UILabel *shopLabel;
@property (nonatomic, strong)UILabel *priceLabel;
@property (nonatomic, strong)UIButton *putButton;
@property (nonatomic, strong)UITextField *liuyanText;


@end

@implementation TheOrderViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)dealloc
{
    _nameTextField.delegate = nil;
    _timeTextField.delegate = nil;
    _phoneTextField.delegate = nil;
    _liuyanText.delegate = nil;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_nameTextField resignFirstResponder];
    [_timeTextField resignFirstResponder];
    [_phoneTextField resignFirstResponder];
    [_liuyanText resignFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RANDOMCOLOR(244, 244, 243);
    self.title = @"确认订单";
    
    [self creatSubViews];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    
    [theTextField resignFirstResponder];
    return YES;
}
- (void)creatSubViews
{
    self.view1 = [[UIView alloc] init];
    self.view1.backgroundColor = WZWwhiteColor;
    [self.view addSubview:self.view1];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textColor = HEISE;
//        self.nameLabel.backgroundColor = [UIColor greenColor];
    self.nameLabel.font = FONT(14);
    self.nameLabel.text = @"姓名";
    [self.view1 addSubview:self.nameLabel];
    
    self.nameTextField = [[UITextField alloc] init];
//    self.nameTextField.backgroundColor = [UIColor grayColor];
    self.nameTextField.textColor = HEISE;
    _nameTextField.returnKeyType = UIReturnKeyDone;
    _nameTextField.delegate = self;
    self.nameTextField.textAlignment = NSTextAlignmentRight;
    self.nameTextField.font = FONT(14);
    self.nameTextField.placeholder = @"请填写您的姓名";
    [self.view1 addSubview:self.nameTextField];
    
    [self.view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(70);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 40));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(60, 40));
    }];
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(WIDTH - 110);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
    self.view2 = [[UIView alloc] init];
    self.view2.backgroundColor = WZWwhiteColor;
    [self.view addSubview:self.view2];
    self.phoneLabel = [[UILabel alloc] init];
    self.phoneLabel.textColor = HEISE;
//        self.phoneLabel.backgroundColor = WZWorangeColor;
    self.phoneLabel.font = FONT(14);
    self.phoneLabel.text = @"联系电话";
    [self.view2 addSubview:self.phoneLabel];
    
    self.phoneTextField = [[UITextField alloc] init];
//    self.phoneTextField.backgroundColor = WZWgrayColor;
    self.phoneTextField.textColor = HEISE;
    self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    _phoneTextField.returnKeyType = UIReturnKeyDone;
    _phoneTextField.delegate = self;
    self.phoneTextField.textAlignment = NSTextAlignmentRight;
    self.phoneTextField.font = FONT(14);
    self.phoneTextField.placeholder = @"请填写您的手机号";
    [self.view2 addSubview:self.phoneTextField];
    
    [self.view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(111);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 40));
    }];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(60, 40));
    }];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(WIDTH - 140);
        make.size.mas_equalTo(CGSizeMake(130, 40));
    }];
    
    self.view3 = [[UIView alloc] init];
    self.view3.backgroundColor = WZWwhiteColor;
    [self.view addSubview:self.view3];
    
    
    
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.textColor = HEISE;
//        self.timeLabel.backgroundColor = WZWmagentaColor;
    self.timeLabel.font = FONT(14);
    if ([self.dataDic[@"goods_cate_id"] isEqualToString:@"11"]) {
        _timeLabel.text = @"服务时间(选填)";
    }else{
        NSMutableAttributedString *sstr = [[NSMutableAttributedString alloc] initWithString:@"服务时间(婚期)"];
        [sstr addAttribute:NSForegroundColorAttributeName value:FENSE range:NSMakeRange(5,2)];
        self.timeLabel.attributedText = sstr;
    }
    
    [self.view3 addSubview:self.timeLabel];
    
    self.timeTextField = [[UITextField alloc] init];
    self.timeTextField.textColor = HEISE;
    self.timeTextField.userInteractionEnabled = NO;
    self.timeTextField.font = FONT(13);
    _timeTextField.delegate = self;
    self.timeTextField.textAlignment = NSTextAlignmentRight;
    self.timeTextField.placeholder = @"请选择服务日期";
    [self.view3 addSubview:self.timeTextField];
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightButton addTarget:self action:@selector(chooseTime) forControlEvents:UIControlEventTouchUpInside];
    //    self.rightButton.backgroundColor = [UIColor magentaColor];
    [self.view3 addSubview:self.rightButton];
    UIImageView *rightButton1 = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH - 20, 16, 10, 10)];
    rightButton1.image = [UIImage imageNamed:@"icon_1_2_youjiantou@2x"];
    //    rightButton1.backgroundColor = [UIColor magentaColor];
    [self.view3 addSubview:rightButton1];
    
    [self.view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(152);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 40));
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    [self.timeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(WIDTH - 130);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(WIDTH / 2);
        make.size.mas_equalTo(CGSizeMake(WIDTH / 2, 40));
    }];
    
    self.view4 = [[UIView alloc] initWithFrame:CGRectMake(0, 200, WIDTH, 88)];
    self.view4.backgroundColor = WZWwhiteColor;
    [self.view addSubview:self.view4];
    
    UILabel *tishiLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, WIDTH - 20, 20)];
    tishiLabel.font = FONT(13);
    tishiLabel.textColor = RANDOMCOLOR(153, 153, 153);
    [self.view4 addSubview:tishiLabel];
    if ([self.dataDic[@"goods_cate_id"] isEqualToString:@"11"]) {
        tishiLabel.text = @"具体的拍摄时间,可与商家商议";
    }else{
        tishiLabel.text = @"为保障您的权益,一定要认真填写服务时间哦!";
    }

    UILabel *line4Label = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, WIDTH, 1)];
    line4Label.backgroundColor = RANDOMCOLOR(243, 243, 244);
    [self.view4 addSubview:line4Label];
    UILabel *liuyanLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 30, 30)];
    liuyanLabel.font = FONT(13);
    liuyanLabel.textColor = HEISE;
    liuyanLabel.text = @"留言";
    [self.view4 addSubview:liuyanLabel];
    self.liuyanText = [[UITextField alloc] initWithFrame:CGRectMake(WIDTH / 3 - 10, 50, WIDTH / 3 * 2 + 10, 30)];
    _liuyanText.returnKeyType = UIReturnKeyDone;
    _liuyanText.font = FONT(13);
    _liuyanText.delegate = self;
    _liuyanText.placeholder = @"选填(建议填写和商家达成一致的留言)";
    [self.view4 addSubview:_liuyanText];
#pragma mark -服务资料
    UIView *shopView = [[UIView alloc] initWithFrame:CGRectMake(0, 298, WIDTH, 150)];
    shopView.backgroundColor = WZWwhiteColor;
    [self.view addSubview:shopView];
    self.shopLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, WIDTH, 20)];
    self.shopLabel.font = FONT(13);
    self.shopLabel.textColor = HEISE;
    self.shopLabel.text = self.dataDic[@"goods_store_name"];
    [shopView addSubview:self.shopLabel];
    UILabel *line6Label = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, WIDTH, 1)];
    line6Label.backgroundColor = RANDOMCOLOR(243, 243, 244);
    [shopView addSubview:line6Label];
    
    UIImageView *shopImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 55, 136, 76)];
    shopImage.backgroundColor = BEIJINGSE;
    [shopImage sd_setImageWithURL:WZWURLWithString(self.dataDic[@"goods_image_url"][0]) placeholderImage:ZHANWEI];
    [shopView addSubview:shopImage];
    
    MyLabel *goodsName = [[MyLabel alloc] initWithFrame:CGRectMake(156, 50, WIDTH - 166, 60)];
    [goodsName setVerticalAlignment:VerticalAlignmentTop];
    goodsName.numberOfLines = 0;
    goodsName.font = FONT(13);
    goodsName.text = self.dataDic[@"goods_name"];
    goodsName.textColor = HEISE;
    [shopView addSubview:goodsName];
    UILabel *priceL = [[UILabel alloc] initWithFrame:CGRectMake(156, 110, WIDTH - 166, 20)];
    priceL.textColor = FENSE;
    priceL.font = FONT(13);
    [shopView addSubview:priceL];
    
    
    self.view5 = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT - (49 * HSHIPEI), WIDTH, 49 * HSHIPEI)];
    self.view5.backgroundColor = WZWwhiteColor;
    [self.view addSubview:self.view5];
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(100 * WSHIPEI, 0, 150 * WSHIPEI, 49 * HSHIPEI)];
    self.priceLabel.textColor = HEISE;
    
    [self.view5 addSubview:self.priceLabel];
    
    
    self.putButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.putButton.frame = CGRectMake(255 * WSHIPEI, 0, 120 * WSHIPEI, 49 * HSHIPEI);
    self.putButton.backgroundColor = FENSE;
    [self.putButton addTarget:self action:@selector(putOrder) forControlEvents:UIControlEventTouchUpInside];
    [self.putButton setTitle:@"提交订单" forState:UIControlStateNormal];
    [self.view5 addSubview:self.putButton];
    
    
    if ([_dataDic[@"goods_spec"] count] != 0) {
        
        priceL.text = [NSString stringWithFormat:@"¥%@", self.dataDic[@"goods_spec"][_choosePage][@"goods_price"]];
        self.priceLabel.text = [NSString stringWithFormat:@"合计:¥%@", self.dataDic[@"goods_spec"][_choosePage][@"goods_price"]];
    }else{
        priceL.text = [NSString stringWithFormat:@"¥%@", self.dataDic[@"goods_price"]];
        self.priceLabel.text = [NSString stringWithFormat:@"合计:¥%@", self.dataDic[@"goods_price"]];
    }
}
#pragma mark - 提交订单
#if 1
- (void)putOrder
{
    NSString *str = self.phoneTextField.text;
    if (![str checkPhoneNumInput]) {
        [self creatAlertViewOne:@"请填写正确的电话号码" message:nil sureStr:@"确定" sureAction:^(id result) {
            
        }];
        return;
    }
    else if (![self.dataDic[@"goods_cate_id"] isEqualToString:@"11"] && [self.timeTextField.text isEqualToString:@""]) {
        [self creatAlertViewOne:@"请填写时间" message:nil sureStr:@"确定" sureAction:^(id result) {
            
        }];
        return;
    }
    else if([self.nameTextField.text isEqualToString:@""]){
        [self creatAlertViewOne:@"请填写姓名" message:nil sureStr:@"确定" sureAction:^(id result) {
            
        }];
        return;
    }
    [self showLoadingViewWithMessage];
    //token header
    NSMutableDictionary *dic = [@{@"user_id":[ProjectCache getLoginMessage][@"user_id"],
                                  @"name":self.nameTextField.text,
                                  @"service_time":self.timeTextField.text?self.timeTextField.text:@"",
                                  @"phone":self.phoneTextField.text,
                                  @"amount":self.dataDic[@"goods_price"],
                                  @"goods_id":self.dataDic[@"goods_id"],
                                  @"spec_id":[self.specId isEqualToString:@""]?self.specId:@"",
                                  @"note":self.liuyanText.text}
                                mutableCopy];
    [HBSNetWork postUrl:[NSString stringWithFormat:@"%@order/service", HBSNetAdress] parame:dic header:@"c02b68e88c44385f56064ce4cd49b319" cookie:nil result:^(id result) {
        if ([result[@"code"] integerValue] == 200) {
            PayMoneyViewController *payVC = [[PayMoneyViewController alloc] init];
            payVC.dicInfo = result[@"result"];
            [self.navigationController pushViewController:payVC animated:YES];
        }
        [self removeLodingView];
    }];
}
#endif
- (void)chooseTime
{
    [self action:nil];
}
#pragma mark - 时间选择器的方法
-(void) action:(id)sender{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    __block  UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = 1;
    datePicker.frame = CGRectMake(- 20, 0, [UIScreen mainScreen].bounds.size.width, 216);
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSDateFormatter *formattor = [[NSDateFormatter alloc] init];
        formattor.dateFormat = @"yyyy-MM-dd";
        NSString *timestamp = [formattor stringFromDate:datePicker.date];
        
        self.timeTextField.text = timestamp;
        
    }];
    [alertController.view addSubview:datePicker];
    [alertController addAction:cancleAction];
    [self presentViewController:alertController animated:YES completion:nil];
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
