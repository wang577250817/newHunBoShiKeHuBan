


//
//  HBSFooterView.m
//  HBS_C
//
//  Created by 王 世江 on 16/11/10.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSFooterView.h"
#import "PayMoneyViewController.h"

@interface HBSFooterView ()
@property (nonatomic, strong) UILabel *grayLabel;
@property (nonatomic, strong) UILabel *buyManLabel;//买家留言
@property (nonatomic, strong) UILabel *buyContentLabel;//留言内容
@property (nonatomic, strong) UIButton *phoneBtn;//打电话btn
@property (nonatomic, strong) UIButton *chatBtn;//聊天btn
@property (nonatomic, strong) UILabel *grayLabel3;//灰线3
@property (nonatomic, strong) UILabel *allMoneyLabel;//总计金额
@property (nonatomic, strong) UILabel *moneyNumLabel;//具体金额
@property (nonatomic, strong) UILabel *grayLabel4;//灰线4
@property (nonatomic, strong) UILabel *orderLabel;//订单编号
@property (nonatomic, strong) UILabel *orderNumLabel;//订单编号内容
@property (nonatomic, strong) UILabel *grayLabel5;//灰线5
@property (nonatomic, strong) UILabel *orderTimeLabel;//下单时间
@property (nonatomic, strong) UILabel *orderContentLabel;//具体下单时间
@property (nonatomic, strong) UILabel *grayLabel6;//灰线6
@property (nonatomic, strong) UILabel *retureMoneyLabel;//退款label
@property (nonatomic, strong) UIButton *hasBtn;//卖家已发货
@property (nonatomic, strong) UIButton *waitBtn;//等待卖家发货
@property (nonatomic, strong) UIButton *successBtn;//交易成功
@property (nonatomic, strong) UIButton *payBtn;//付款
@property (nonatomic, strong) NSMutableDictionary *payDic;
@property (nonatomic, strong) UILabel *roderNameLabel;//商品名称
@property (nonatomic, strong) UILabel *orderStoreID;//订单ID

@property (nonatomic, strong) NSString *orderDetailID;//订单详情id

@end


@implementation HBSFooterView
#pragma mark----初始化
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.grayLabel = [[UILabel alloc]init];
        self.grayLabel.backgroundColor = HBSColor(229, 229, 229);
        [self addSubview:self.grayLabel];
        //买家留言
        self.buyManLabel = [[UILabel alloc]init];
        self.buyManLabel.font = FONT(14);
        self.buyManLabel.textColor = HEISE;
        self.buyManLabel.text = @"买家留言:";
//        self.buyManLabel.backgroundColor = HBSRandomColor;
        [self addSubview:self.buyManLabel];
        //商品名称
        self.roderNameLabel = [[UILabel alloc]init];
        //买家留言内容
        self.buyContentLabel = [[UILabel alloc]init];
        self.buyContentLabel.font = FONT(14);
        self.buyContentLabel.textColor = HBSColor(153, 153, 153);
//        self.buyContentLabel.text = @"城祥大傻逼城祥大傻逼城祥大傻逼城祥大傻逼城祥大傻逼城祥大傻逼城祥大傻逼城祥大傻逼城祥大傻逼城祥大傻逼";
        self.buyContentLabel.numberOfLines = 0;
//        self.buyContentLabel.backgroundColor = HBSRandomColor;
        [self addSubview:self.buyContentLabel];
        //打电话button
        self.phoneBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.phoneBtn setBackgroundImage:[UIImage imageNamed:@"button_phone"] forState:UIControlStateNormal];
        [self.phoneBtn addTarget:self action:@selector(clickPhone:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.phoneBtn];
        //聊天button
        self.chatBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.chatBtn setBackgroundImage:[UIImage imageNamed:@"button_talk"] forState:UIControlStateNormal];
        [self.chatBtn addTarget:self action:@selector(clickTalk:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.chatBtn];
        //灰线3
        self.grayLabel3 = [[UILabel alloc]init];
        self.grayLabel3.backgroundColor = HBSColor(229, 229, 229);
        [self addSubview:self.grayLabel3];
        //合计金额
        self.allMoneyLabel = [[UILabel alloc]init];
        self.allMoneyLabel.font = FONT(14);
        self.allMoneyLabel.textColor = HEISE;
        self.allMoneyLabel.text = @"合计金额:";
//        self.allMoneyLabel.backgroundColor = HBSRandomColor;
        [self addSubview:self.allMoneyLabel];
        //具体金额
        self.moneyNumLabel = [[UILabel alloc]init];
        self.moneyNumLabel.font = FONT(14);
        self.moneyNumLabel.textColor = FENSE;
        self.moneyNumLabel.textAlignment = NSTextAlignmentRight;
//        self.moneyNumLabel.backgroundColor = HBSRandomColor;
        [self addSubview:self.moneyNumLabel];
        //灰线4
        self.grayLabel4 = [[UILabel alloc]init];
        self.grayLabel4.backgroundColor = HBSColor(229, 229, 229);
        [self addSubview:self.grayLabel4];
        //订单编号
        self.orderLabel = [[UILabel alloc]init];
        self.orderLabel.font = FONT(14);
        self.orderLabel.text = @"订单编号:";
        self.orderLabel.textColor = HEISE;
//        self.orderLabel.backgroundColor = HBSRandomColor;
        [self addSubview:self.orderLabel];
        //具体订单编号
        self.orderNumLabel = [[UILabel alloc]init];
        self.orderNumLabel.font = FONT(14);
        self.orderNumLabel.textColor = HBSColor(102, 102, 102);
        self.orderNumLabel.textAlignment = NSTextAlignmentRight;
//        self.orderNumLabel.backgroundColor = HBSRandomColor;
        [self addSubview:self.orderNumLabel];
        //订单ID
        self.orderStoreID = [[UILabel alloc]init];
        //灰线5
        self.grayLabel5 = [[UILabel alloc]init];
        self.grayLabel5.backgroundColor = HBSColor(229, 229, 229);
        [self addSubview:self.grayLabel5];
        //下单时间
        self.orderTimeLabel = [[UILabel alloc]init];
        self.orderTimeLabel.font = FONT(14);
        self.orderTimeLabel.text = @"下单时间:";
        self.orderTimeLabel.textColor = HEISE;
//        self.orderTimeLabel.backgroundColor = HBSRandomColor;
        [self addSubview:self.orderTimeLabel];
        //具体下单时间
        self.orderContentLabel = [[UILabel alloc]init];
        self.orderContentLabel.font = FONT(14);
        self.orderContentLabel.textColor = HBSColor(102, 102, 102);
        self.orderContentLabel.textAlignment = NSTextAlignmentRight;
//        self.orderContentLabel.backgroundColor = HBSRandomColor;
        [self addSubview:self.orderContentLabel];
        //灰线6
        self.grayLabel6 = [[UILabel alloc]init];
        self.grayLabel6.backgroundColor = HBSColor(229, 229, 229);
        [self addSubview:self.grayLabel6];
        //成功退款金额label
        self.retureMoneyLabel = [[UILabel alloc]init];
        self.retureMoneyLabel.font = FONT(14);
        self.retureMoneyLabel.textColor = FENSE;
//        self.retureMoneyLabel.backgroundColor = HBSRandomColor;
        [self addSubview:self.retureMoneyLabel];
        //已经发货btn
        self.hasBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.hasBtn setBackgroundImage:[UIImage imageNamed:@"button_1_2_hong_querenshouhuo"] forState:UIControlStateNormal];
        [self.hasBtn addTarget:self action:@selector(clickSureShouhuoBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.hasBtn];
        //等待卖家发货btn
        self.waitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.waitBtn setBackgroundImage:[UIImage imageNamed:@"button_1_2_hui_querenshouhuo"] forState:UIControlStateNormal];
        [self addSubview:self.waitBtn];
        //交易成功btn
        self.successBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.successBtn setBackgroundImage:[UIImage imageNamed:@"button_yiquerenshouhuo"] forState:UIControlStateNormal];
        self.successBtn.userInteractionEnabled = NO;
        [self addSubview:self.successBtn];
        //付款btn
        self.payBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.payBtn setBackgroundImage:[UIImage imageNamed:@"button_1_2_3_fukuan"] forState:UIControlStateNormal];
        [self.payBtn addTarget:self action:@selector(payClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.payBtn];

    }
    
    return self;
    
}
#pragma mark----布局
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.grayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self).offset(0);
        make.left.mas_equalTo(self).offset(10);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 2 * 10, 1));
        
    }];
    
    [self.buyManLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self).offset(10);
        make.top.mas_equalTo(self.grayLabel).offset(10);
        make.size.mas_equalTo(CGSizeMake(65, 15));
        
    }];
    
    [self.buyContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.buyManLabel).offset(75);
        make.top.mas_equalTo(self.grayLabel).offset(10);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 95, 55));
        
    }];
    
    [self.phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self).offset(-10);
        make.top.mas_equalTo(self.buyContentLabel).offset(70);
        make.size.mas_equalTo(CGSizeMake(80, 22));
        
    }];
    
    [self.chatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.phoneBtn).offset(-92);
        make.top.mas_equalTo(self.buyContentLabel).offset(70);
        make.size.mas_equalTo(CGSizeMake(80, 22));
        
    }];
    
    [self.grayLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneBtn).offset(37);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 5));
        
    }];
    
    [self.allMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self).offset(10);
        make.top.mas_equalTo(self.grayLabel3).offset(20);
        make.size.mas_equalTo(CGSizeMake(65, 15));
        
    }];
    
    [self.moneyNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self).offset(-10);
        make.top.mas_equalTo(self.grayLabel3).offset(20);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 95, 15));
        
    }];
    
    [self.grayLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.grayLabel3).offset(44);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 5));
        
    }];
    
    [self.orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self).offset(10);
        make.top.mas_equalTo(self.grayLabel4).offset(15);
        make.size.mas_equalTo(CGSizeMake(65, 15));
        
    }];
    
    [self.orderNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self).offset(-10);
        make.top.mas_equalTo(self.grayLabel4).offset(15);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 95, 15));
        
    }];
    
    [self.grayLabel5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.grayLabel4).offset(44);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 1));
        
    }];
    
    [self.orderTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self).offset(10);
        make.top.mas_equalTo(self.grayLabel5).offset(10);
        make.size.mas_equalTo(CGSizeMake(65, 15));
        
    }];
    
    [self.orderContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self).offset(-10);
        make.top.mas_equalTo(self.grayLabel5).offset(10);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 95, 15));
        
    }];
    
    [self.grayLabel6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.grayLabel5).offset(44);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 1));
        
    }];

    [self.retureMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self).offset(10);
        make.top.mas_equalTo(self.grayLabel6).offset(10);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 150, 15));
        
    }];
   
    [self.hasBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self).offset(-10);
        make.top.mas_equalTo(self.grayLabel6).offset(10);
        make.size.mas_equalTo(CGSizeMake(90, 28));
        
    }];
    
    [self.waitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self).offset(-10);
        make.top.mas_equalTo(self.grayLabel6).offset(10);
        make.size.mas_equalTo(CGSizeMake(90, 28));
        
    }];
    
    [self.successBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self).offset(-10);
        make.top.mas_equalTo(self.grayLabel6).offset(10);
        make.size.mas_equalTo(CGSizeMake(110, 28));
        
    }];
    
    [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self).offset(-10);
        make.top.mas_equalTo(self.grayLabel6).offset(10);
        make.size.mas_equalTo(CGSizeMake(90, 28));
        
    }];

}
#pragma mark----赋值
- (void)setGoodFooterDic:(NSMutableDictionary *)goodFooterDic{
    
    _goodFooterDic = goodFooterDic;

    self.buyContentLabel.text = goodFooterDic[@"message"];
    self.moneyNumLabel.text = goodFooterDic[@"order_amount"];
    self.orderNumLabel.text = goodFooterDic[@"order_sn"];
    self.orderContentLabel.text = goodFooterDic[@"add_time"];
    self.roderNameLabel.text = goodFooterDic[@"order_store_name"];
    self.orderStoreID.text = goodFooterDic[@"order_store_id"];
    self.orderDetailID = goodFooterDic[@"order_detail_id"];
    NSMutableAttributedString *returnLabel = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"成功退款:已退款 ¥%@", goodFooterDic[@"order_amount"]]];
    [returnLabel addAttribute:NSForegroundColorAttributeName value:HEISE range:NSMakeRange(0, 8)];
    self.retureMoneyLabel.attributedText = returnLabel;
    NSLog(@"%@123456789", self.payDic);
    if ([goodFooterDic[@"order_status"]isEqualToString:@"已退款"]) {
        self.retureMoneyLabel.hidden = NO;
    }else{
        self.retureMoneyLabel.hidden = YES;
    }
    if ([goodFooterDic[@"order_status"]isEqualToString:@"卖家已发货"]) {
        self.hasBtn.hidden = NO;
    }else{
        self.hasBtn.hidden = YES;
    }

    if ([goodFooterDic[@"order_status"]isEqualToString:@"等待卖家发货"]) {
        self.waitBtn.hidden = NO;
    }else{
        self.waitBtn.hidden = YES;
    }
    if ([goodFooterDic[@"order_status"]isEqualToString:@"交易成功"]) {
        self.successBtn.hidden = NO;
    }else{
        self.successBtn.hidden = YES;
    }
    if ([goodFooterDic[@"order_status"]isEqualToString:@"等待买家付款"]) {
        self.payBtn.hidden = NO;
    }else{
        self.payBtn.hidden = YES;
    }
    
}
//打电话的代理
- (void)clickPhone:(UIButton *)btn{
    
    if ([self.delegate respondsToSelector:@selector(phoneCallDelegate:WithclickPhone:)]) {
        
        [self.delegate phoneCallDelegate:self WithclickPhone:btn];
    }
    
}
//聊天代理
- (void)clickTalk:(UIButton *)btn{
    
    if ([self.delegate respondsToSelector:@selector(talkCallDelegate:WithclickTalk:)]) {
        
        [self.delegate talkCallDelegate:self WithclickTalk:btn];
    }
    
}
//付款
- (void)payClick{
    
    self.payDic = [NSMutableDictionary dictionary];
    self.payDic = @{@"order_sn":self.orderNumLabel.text, @"order_amount":self.moneyNumLabel.text, @"order_date":self.orderContentLabel.text, @"order_title":self.roderNameLabel.text, @"order_ids":self.orderStoreID.text}.mutableCopy;
    PayMoneyViewController *payMoney = [[PayMoneyViewController alloc]init];
    UITabBarController *tabBarVC = (UITabBarController *)self.window.rootViewController;
    UINavigationController *nav = tabBarVC.selectedViewController;
    payMoney.dicInfo = self.payDic;
    [nav pushViewController:payMoney animated:YES];
}

//确认收货
- (void)clickSureShouhuoBtn:(UIButton *)btn{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"id"] = self.orderDetailID;
    params[@"user_id"] = [ProjectCache getLoginMessage][@"user_id"];
    params[@"token"] = userToken;
    params[@"order_operate"] = @"1";
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请在收到货后进行确认" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [HBSNetWork putUrl:[NSString stringWithFormat:@"%@order/%@", HBSNetAdress, params[@"id"]] parame:params  header:nil cookie:nil result:^(id result) {
            
            
            if ([result[@"code"]integerValue] == 200) {
                
                if ([self.delegate respondsToSelector:@selector(sureGoodsDelegate:withClickGood:)]) {
                
                    [self.delegate sureGoodsDelegate:self withClickGood:btn];
//                    self.stateLabel.text = @"交易成功";
                    self.hasBtn.hidden = YES;
                    self.successBtn.hidden = NO;
                }
            }
            
        }];
    }];
    [alert addAction:cancelAction];
    [alert addAction:sureAction];
    UITabBarController *tabBarVC = (UITabBarController *)self.window.rootViewController;
    UINavigationController *nav = tabBarVC.selectedViewController;
    [nav presentViewController:alert animated:YES completion:nil];
    
}

@end
