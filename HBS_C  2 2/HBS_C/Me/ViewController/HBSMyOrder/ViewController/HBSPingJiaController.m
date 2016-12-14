//
//  HBSPingJiaController.m
//  HBS_C
//
//  Created by 王 世江 on 16/11/18.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSPingJiaController.h"
#import "HBSLPlaceholderTextView.h"
#import "TQStarRatingView.h"

@interface HBSPingJiaController ()<UITextViewDelegate, StarRatingViewDelegate>
{
    float spaceBetweenTextViewWithParentView;
}
@property (strong, nonatomic) IBOutlet UIImageView *leftImage;
@property (nonatomic, strong) HBSLPlaceholderTextView *pingConmentText;//评价内容
@property (nonatomic, strong) UILabel *placeholdLabel;
@property (nonatomic, strong) UILabel *grayLabel;//灰线
@property (nonatomic, strong) UILabel *pingLabel;//维度评价label
@property (nonatomic, strong) UILabel *attitudeLabel;//服务态度
@property (nonatomic, strong) TQStarRatingView *starRatingView;//服务态度星星
@property (nonatomic, strong) NSString *attitudeStr;//态度str
@property (nonatomic, strong) UILabel *qualityLabel;//服务质量
@property (nonatomic, strong) TQStarRatingView *starRatingView1;//服务质量星星
@property (nonatomic, strong) NSString *qualityStr;//质量str
@property (nonatomic, strong) UILabel *languageLabel;//语言沟通
@property (nonatomic, strong) TQStarRatingView *starRatingView2;//语言沟通星星
@property (nonatomic, strong) NSString *languageStr;//语言str
@property (nonatomic, strong) UIButton *publishedBtn;//发表评价
@property (nonatomic, strong) UILabel *endLabel;//修改成功标识
@property (nonatomic, strong) NSDictionary *pingDic;
@end

@implementation HBSPingJiaController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BAISE;
    [self setUpChildControls];
    [self setupStarRatingView];
    
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}
#pragma mark----设置子控件
- (void)setUpChildControls{
    
    //返回箭头
    UITapGestureRecognizer *tapImage = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImage)];
    [self.leftImage addGestureRecognizer:tapImage];
    
    self.pingConmentText = [[HBSLPlaceholderTextView alloc]init];
//    self.pingConmentText.backgroundColor = HBSRandomColor;
    self.pingConmentText.frame = CGRectMake(0, 65, WIDTH, 200);
    self.pingConmentText.tintColor = HEISE;
    self.pingConmentText.placeholderText = @"分享下您的感受吧,其他小伙伴会非常感激的哦!";
    spaceBetweenTextViewWithParentView = 0;
    self.pingConmentText.placeholderColor=RANDOMCOLOR(153, 153, 153);
    [self.view addSubview:self.pingConmentText];
    //灰线
    self.grayLabel = [[UILabel alloc]init];
    self.grayLabel.backgroundColor = HBSColor(229, 229, 229);
    self.grayLabel.frame = CGRectMake(10, 264, WIDTH - 2 * 10, 1);
    [self.view addSubview:self.grayLabel];
    //维度评价label
    self.pingLabel = [[UILabel alloc]init];
    self.pingLabel.textColor = HBSColor(102, 102, 102);
    self.pingLabel.text = @"维度评价";
    self.pingLabel.font = FONT(15);
    self.pingLabel.frame = CGRectMake(10, 279, 120, 20);
    [self.view addSubview:self.pingLabel];
    //服务态度
    self.attitudeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 310, 80, 30)];
    self.attitudeLabel.font = FONT(13);
//    self.attitudeLabel.backgroundColor = HBSRandomColor
    self.attitudeLabel.textColor = HEISE;
    self.attitudeLabel.text = @"服务态度:";
    [self.view addSubview:self.attitudeLabel];
    //服务质量
    self.qualityLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 360, 80, 30)];
    self.qualityLabel.font = FONT(13);
//    self.qualityLabel.backgroundColor = HBSRandomColor
    self.qualityLabel.textColor = HEISE;
    self.qualityLabel.text = @"服务质量:";
    [self.view addSubview:self.qualityLabel];
        //语言沟通
    self.languageLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 410, 80, 30)];
    self.languageLabel.font = FONT(13);
//    self.languageLabel.backgroundColor = HBSRandomColor
    self.languageLabel.textColor = HEISE;
    self.languageLabel.text = @"服务质量:";
    [self.view addSubview:self.languageLabel];
    //发表评价
    self.publishedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.publishedBtn setImage:[UIImage imageNamed:@"button_1_2_3_hongfabiaopingjia"] forState:UIControlStateNormal];
    self.publishedBtn.frame = CGRectMake((WIDTH - 120) / 2, 500, 120, 36);
    [self.publishedBtn addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.publishedBtn];

}
- (void)returnText:(ReloadBlock)block
{
    self.reloadBlock = block;
}

- (void)setupStarRatingView
{
     //服务质量星星
    _starRatingView = [[TQStarRatingView alloc] initWithFrame:CGRectMake(WIDTH - 210, 310 * HSHIPEI, 200, 30) numberOfStar:kNUMBER_OF_STAR];
//    self.starRatingView.backgroundColor = HBSRandomColor;
    _starRatingView.delegate = self;
    [self.view addSubview:_starRatingView];
    //服务态度星星
    _starRatingView1 = [[TQStarRatingView alloc] initWithFrame:CGRectMake(WIDTH - 210, 360 * HSHIPEI, 200, 30) numberOfStar:kNUMBER_OF_STAR];
    _starRatingView1.delegate = self;
    [self.view addSubview:_starRatingView1];
    //语言沟通星星
    _starRatingView2 = [[TQStarRatingView alloc] initWithFrame:CGRectMake(WIDTH - 210, 410 * HSHIPEI, 200, 30) numberOfStar:kNUMBER_OF_STAR];
    _starRatingView2.delegate = self;
    [self.view addSubview:_starRatingView2];
    
    if ([self.pingComment isEqualToString:@""]) {
        [_starRatingView setScore:0 withAnimation:YES];
        [_starRatingView1 setScore:0 withAnimation:YES];
        [_starRatingView2 setScore:0 withAnimation:YES];
    }else{
        float f1 = [self.pingAttitude floatValue] / 5;
        float f2 = [self.pingAppearance floatValue] / 5;
        float f3 = [self.pingLanguage floatValue] / 5;
        [_starRatingView setScore:f1 withAnimation:YES];
        [_starRatingView1 setScore:f2 withAnimation:YES];
        [_starRatingView2 setScore:f3 withAnimation:YES];
        
        self.pingConmentText.text = self.pingComment;
        
        
    }
}
#pragma mark----实现发表评价的方法
- (void)publishClick{
    
    [self.pingConmentText resignFirstResponder];
    
    
     if ([self.pingConmentText.text isEqualToString:@""]){
        
        [self alertWithTitle:@"请您输入评论内容" message:nil sure:nil cancel:nil];
        
     }else if (self.pingConmentText.text.length > 1000){
         
         [self alertWithTitle:@"您评价的内容最多1000字" message:nil sure:nil cancel:nil];
         
     }else if ([self.pingAttitude isEqual:@"0"] || [self.pingAppearance isEqual:@"0"] || [self.pingLanguage isEqual:@"0"]) {
        
        [self alertWithTitle:@"请您给个好评" message:nil sure:nil cancel:nil];
    
    }else{
    
    
    if ([self checkWIFI]) {
        [self showLoadingViewWithMessage];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"id"] = self.pingID;
        params[@"comment"] = self.pingConmentText.text;
        params[@"attitude"] = self.attitudeStr;
        params[@"appearance"] = self.qualityStr;
        params[@"language"] = self.languageStr;
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.securityPolicy.validatesDomainName = YES;
        [manager POST:[NSString stringWithFormat:@"%@/order/%@/comment",HBSNetAdress,params[@"id"]] parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if ([responseObject[@"code"]integerValue] == 200) {
                
                self.pingDic = responseObject[@"result"];
               
                [self setupSuccessedLabel];
                
                HBSLog(@"%@", self.pingDic);
                
            }else if ([responseObject[@"code"]integerValue] == 201){
                
                HBSLog(@"%@", responseObject);
                
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            HBSLog(@"%@", error);
            
        }];
    }
    
    }
}
#pragma mark----评价成功弹框
- (void)setupSuccessedLabel{
    
    self.endLabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH / 2 - 60, HEIGHT / 2 - 25, 120, 50)];
    self.endLabel.backgroundColor = [UIColor blackColor];
    self.endLabel.alpha = 0.5;
    _endLabel.layer.cornerRadius = 10;
    _endLabel.layer.masksToBounds = YES;
    _endLabel.textColor = BAISE;
    _endLabel.text = @"评价成功!";
    _endLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.endLabel];
    CATransition * transion = [CATransition animation];
    transion.type = @"push";//设置动画方式
    transion.subtype = @"fromBottom";//设置动画从那个方向开始
    [_endLabel.layer addAnimation:transion forKey:nil];
    //Label.layer 添加动画
    //设置延时效果
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(),^{
        [_endLabel removeFromSuperview];
        [self.navigationController popViewControllerAnimated:YES];
    });
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.pingConmentText resignFirstResponder];
}
- (void)textViewDidChange:(UITextView *)textView {
    NSInteger number = [textView.text length];
    if (number > 0) {
        self.placeholdLabel.hidden = YES;
    }else{
        _placeholdLabel.hidden = NO;
    }
    
}

-(void)starRatingView:(TQStarRatingView *)view score:(float)score
{
    [self.pingConmentText resignFirstResponder];
    if (view == _starRatingView) {
        self.attitudeStr = [NSString stringWithFormat:@"%f", (float)(score * 5)];
        NSLog(@"%.1f", (float)score);
    }else if(view == _starRatingView1){
        self.qualityStr = [NSString stringWithFormat:@"%f", (float)(score * 5)];
        
         NSLog(@"%.1f", (float)score);
    }else{
        self.languageStr = [NSString stringWithFormat:@"%f", (float)(score * 5)];
         NSLog(@"%.1f", (float)score);
    }
    
}
#pragma mark----返回箭头
- (void)clickImage{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
