//
//  HBSEditViewController.m
//  HBS_C
//
//  Created by 王 世江 on 16/10/26.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSEditViewController.h"

@interface HBSEditViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *leftImage;//返回image
@property (strong, nonatomic) IBOutlet UITextField *nameTextfield;
@property (strong, nonatomic) IBOutlet UIImageView *headImage;//头像image
@property (strong, nonatomic) IBOutlet UILabel *sexLabel;//性别label
@property (strong, nonatomic) IBOutlet UILabel *weddingLabel;//婚期label
@property (strong, nonatomic) IBOutlet UILabel *cityLabel;//城市label
@property (strong, nonatomic) IBOutlet UITextField *weChatTextfield;//微信号textField
@end

@implementation HBSEditViewController
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
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
        
        HBSLog(@"我要拍照");
        
    }]];
    
    [alertController addAction: [UIAlertAction actionWithTitle: @"从相册选取" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.delegate = self;
        [self presentViewController:imagePicker animated:YES completion:^{
            NSLog(@"打开相册");
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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.headImage.image = info[UIImagePickerControllerEditedImage];
    NSLog(@"%@",info);
    [picker dismissViewControllerAnimated:YES completion:^{
        NSLog(@"选照片");
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
    HBSLog(@"婚博士");
    
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
    
    HBSLog(@"提交方法");
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
