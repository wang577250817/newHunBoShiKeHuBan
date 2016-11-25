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
@end
@implementation HBSEditViewController
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}
- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
     [self alertWithTitle:@"修改成功" message:nil sure:nil cancel:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BAISE;
    [self setUpChildControls];
    [self getupData];
    
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
//    NSLog(@"23456789%@",info);
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
    
    [self alertWithTitle:@"即将上线 敬请期待" message:nil sure:nil cancel:nil];
    
}
#pragma mark----提交方法
- (IBAction)submitBtn:(UIButton *)sender {
    
    if (self.nameTextfield.text.length > 14 || self.weChatTextfield.text.length > 14) {
        
        [self alertWithTitle:@"最多只能输入20字哦" message:nil sure:nil cancel:nil];
        
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = userToken;
    params[@"id"] = user_id_find;
    params[@"user_real_name"] = self.nameTextfield.text;
    params[@"user_gender"] = self.sexLabel.text;
    params[@"user_wedding_day"] = self.weddingLabel.text;
    params[@"user_head"] = self.headStr;
    params[@"user_region_id"] = @"傻逼城祥";
    params[@"user_weixin"] = self.weChatTextfield.text;
    
    if ([self checkWIFI]) {
        [self showLoadingViewWithMessage];
        
        [HBSNetWork putUrl:[NSString stringWithFormat:@"%@user/1036",HBSNetAdress] parame:params cookie:nil result:^(id result) {
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
