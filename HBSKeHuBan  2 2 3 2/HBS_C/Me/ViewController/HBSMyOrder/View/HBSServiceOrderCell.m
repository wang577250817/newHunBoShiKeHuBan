//
//  HBSServiceOrderCell.m
//  HBS_C
//
//  Created by 王 世江 on 16/11/9.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSServiceOrderCell.h"
#import "PayMoneyViewController.h"

@interface HBSServiceOrderCell ()
@property (nonatomic, strong) UIView *grayView;
@property (nonatomic, strong) UILabel *typeLabel;//状态label
@property (nonatomic, strong) UILabel *nameLabel;//名字label
@property (nonatomic, strong) UILabel *phoneLabel;//电话label
@property (nonatomic, strong) UILabel *serviceTimeLabel;//服务时间label
@property (nonatomic, strong) UILabel *grayLabel;//灰线
@property (nonatomic, strong) UILabel *shopNameLabel;//店名label
@property (nonatomic, strong) UILabel *grayLabel1;//灰线1
@property (nonatomic, strong) UIImageView *goodImage;//商品image
@property (nonatomic, strong) UILabel *goodNameLabel;//商品名称label
@property (nonatomic, strong) UILabel *goodMoneyLabel;//钱数label
@property (nonatomic, strong) UILabel *goodAmountLabel;//商品数量
@property (nonatomic, strong) UILabel *grayLabel2;//灰线2
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
@property (nonatomic, strong) UILabel *roderNameLabel;
@property (nonatomic, strong) UILabel *grayLabel5;//灰线5
@property (nonatomic, strong) UILabel *orderTimeLabel;//下单时间
@property (nonatomic, strong) UILabel *orderContentLabel;//具体下单时间
@property (nonatomic, strong) UILabel *grayLabel6;//灰线6
@property (nonatomic, strong) UIButton *payBtn;//付款btn
@property (nonatomic, strong) UIButton *sureBtn;//确认完成服务
@property (nonatomic, strong) UIButton *waitBtn;//等待服务
@property (nonatomic, strong) UILabel *succesLabel;//成功退款
@property (nonatomic, strong) UILabel *retureMoneyLabel;//退款金额
@property (nonatomic, strong) UILabel *waitPayTimeLabel;//等待付款时间
@property (nonatomic, strong) NSMutableDictionary *payDic;
@property (nonatomic, strong) UILabel *orderStoreID;//订单ID
@property (nonatomic, strong) NSString *orderDetailID;//详情订单
@end
@implementation HBSServiceOrderCell

#pragma mark----初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.grayView = [[UIView alloc]init];
        self.grayView.backgroundColor = HBSColor(229, 229, 229);
        [self addSubview:self.grayView];
        //服务名称
        self.roderNameLabel = [[UILabel alloc]init];
        
        //状态
        self.typeLabel = [[UILabel alloc]init];
        self.typeLabel.font = FONT(14);
        self.typeLabel.textAlignment = NSTextAlignmentCenter;
        self.typeLabel.textColor = HBSColor(128, 128, 128);
//        self.typeLabel.backgroundColor = HBSRandomColor;
        [self.grayView addSubview:self.typeLabel];
        
        //等待买家付款时间
        self.waitPayTimeLabel = [[UILabel alloc]init];
        self.waitPayTimeLabel.font = FONT(14);
        self.waitPayTimeLabel.text = @"2345678";
        self.waitPayTimeLabel.textAlignment = NSTextAlignmentCenter;
        self.waitPayTimeLabel.textColor = HBSColor(128, 128, 128);
//        self.waitPayTimeLabel.backgroundColor = HBSRandomColor;
        [self.grayView addSubview:self.waitPayTimeLabel];
        
        
        //姓名
        self.nameLabel = [[UILabel alloc]init];
        self.nameLabel.font = FONT(14);
        self.nameLabel.textColor = HBSColor(102, 102, 102);
//        self.nameLabel.backgroundColor = HBSRandomColor;
        [self addSubview:self.nameLabel];
        //电话
        self.phoneLabel = [[UILabel alloc]init];
        self.phoneLabel.font = FONT(14);
        self.phoneLabel.textColor = HBSColor(102, 102, 102);
//        self.phoneLabel.backgroundColor = HBSRandomColor;
        self.phoneLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.phoneLabel];
        //服务时间
        self.serviceTimeLabel = [[UILabel alloc]init];
        self.serviceTimeLabel.font = FONT(14);
        self.serviceTimeLabel.textColor = HBSColor(102, 102, 102);
//        self.serviceTimeLabel.backgroundColor = HBSRandomColor;
        [self addSubview:self.serviceTimeLabel];
        //灰线0
        self.grayLabel = [[UILabel alloc]init];
        self.grayLabel.backgroundColor = HBSColor(229, 229, 229);
        [self addSubview:self.grayLabel];
        //店铺名称
        self.shopNameLabel = [[UILabel alloc]init];
        self.shopNameLabel.textColor = HEISE;
        self.shopNameLabel.font = FONT(13);
        self.shopNameLabel.text = @"城祥傻逼点";
//        self.shopNameLabel.backgroundColor = HBSRandomColor;
        [self addSubview:self.shopNameLabel];
        //灰线1
        self.grayLabel1 = [[UILabel alloc]init];
        self.grayLabel1.backgroundColor = HBSColor(229, 229, 229);
        [self addSubview:self.grayLabel1];
        //商品image
        self.goodImage = [[UIImageView alloc]init];
        [self addSubview:self.goodImage];
        //商品名称
        self.goodNameLabel = [[UILabel alloc]init];
        self.goodNameLabel.textColor = HEISE;
        self.goodNameLabel.font = FONT(14);
        self.goodNameLabel.numberOfLines = 0;
//        self.goodNameLabel.backgroundColor = HBSRandomColor;
        [self addSubview:self.goodNameLabel];
        //商品钱数
        self.goodMoneyLabel = [[UILabel alloc]init];
        self.goodMoneyLabel.textColor = FENSE;
//        self.goodMoneyLabel.backgroundColor = HBSRandomColor;
        self.goodMoneyLabel.font = FONT(15);
        [self addSubview:self.goodMoneyLabel];
        //商品数量
        self.goodAmountLabel = [[UILabel alloc]init];
        self.goodAmountLabel.font = FONT(15);
        self.goodAmountLabel.textColor = HEISE;
//        self.goodAmountLabel.backgroundColor = HBSRandomColor;
        self.goodAmountLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.goodAmountLabel];
        //灰线2
        self.grayLabel2 = [[UILabel alloc]init];
        self.grayLabel2.backgroundColor = HBSColor(229, 229, 229);
        [self addSubview:self.grayLabel2];
        //买家留言
        self.buyManLabel = [[UILabel alloc]init];
        self.buyManLabel.font = FONT(14);
        self.buyManLabel.textColor = HEISE;
        self.buyManLabel.text = @"买家留言:";
//        self.buyManLabel.backgroundColor = HBSRandomColor;
        [self addSubview:self.buyManLabel];
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
        [self.phoneBtn addTarget:self action:@selector(phoneClick:) forControlEvents:UIControlEventTouchUpInside];
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
        //订单ID
        self.orderStoreID = [[UILabel alloc]init];
        //灰线6
        self.grayLabel6 = [[UILabel alloc]init];
        self.grayLabel6.backgroundColor = HBSColor(229, 229, 229);
        [self addSubview:self.grayLabel6];
        //付款button
        self.payBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.payBtn setBackgroundImage:[UIImage imageNamed:@"button_1_2_3_fukuan"] forState:UIControlStateNormal];
        [self.payBtn addTarget:self action:@selector(playClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.payBtn];
        //确认完成服务btn
        self.sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.sureBtn setBackgroundImage:[UIImage imageNamed:@"button_1_2_3_yiquerenwanchengfuwu"] forState:UIControlStateNormal];
        
        [self addSubview:self.sureBtn];
        //等待服务btn
        self.waitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.waitBtn setBackgroundImage:[UIImage imageNamed:@"button_1_2_3_querenwanchengdingdan"] forState:UIControlStateNormal];
        [self.waitBtn addTarget:self action:@selector(sureComplete:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.waitBtn];
        //成功退款label
        self.succesLabel = [[UILabel alloc]init];
        self.succesLabel.font = FONT(14);
        self.succesLabel.text = @"成功退款:已退款";
        self.succesLabel.textColor = HEISE;
//        self.succesLabel.backgroundColor = HBSRandomColor;
        [self addSubview:self.succesLabel];
        //成功退款金额label
        self.retureMoneyLabel = [[UILabel alloc]init];
        self.retureMoneyLabel.font = FONT(14);
        self.retureMoneyLabel.textColor = FENSE;
//        self.retureMoneyLabel.backgroundColor = HBSRandomColor;
        [self addSubview:self.retureMoneyLabel];
        
    }
    
    return self;
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    [self.grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self).offset(1);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 54));
        
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.grayView).offset(15);
        make.left.mas_equalTo(self.grayView).offset(30);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 80, 15));
        
    }];
    
    [self.waitPayTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.typeLabel).offset(20);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 15));
        
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.grayView).offset(75);
        make.left.mas_equalTo(self).offset(10);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 190, 15));
        
    }];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.grayView).offset(75);
        make.right.mas_equalTo(self).offset(-10);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 165, 15));
    }];
    
    [self.serviceTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self).offset(10);
        make.top.mas_equalTo(self.nameLabel).offset(30);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 80, 15));
        
    }];
    
    [self.grayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.serviceTimeLabel).offset(30);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 5));
        
    }];
    
    [self.shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self).offset(10);
        make.top.mas_equalTo(self.grayLabel).offset(15);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 20, 15));
        
    }];
    
    [self.grayLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.shopNameLabel).offset(30);
        make.left.mas_equalTo(self).offset(10);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 2 * 10, 1));
        
    }];
    
    [self.goodImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self).offset(10);
        make.top.mas_equalTo(self.grayLabel1).offset(15);
        make.size.mas_equalTo(CGSizeMake(136, 76));
        
    }];
    
    [self.goodNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self.goodImage).offset(151);
        make.top.mas_equalTo(self.grayLabel1).offset(15);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 170, 35));
        
    }];
    
    [self.goodMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.goodNameLabel).offset(60);
        make.left.mas_equalTo(self.goodImage).offset(151);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 230, 15));
        
    }];
    [self.goodAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.goodNameLabel).offset(60);
        make.right.mas_equalTo(self).offset(-12);
        make.size.mas_equalTo(CGSizeMake(40, 15));
        
    }];
    
    [self.grayLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goodImage).offset(91);
        make.left.mas_equalTo(self).offset(10);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 2 * 10, 1));
        
    }];
    
    [self.buyManLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self).offset(10);
        make.top.mas_equalTo(self.grayLabel2).offset(15);
        make.size.mas_equalTo(CGSizeMake(65, 15));
        
    }];
    [self.buyContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.buyManLabel).offset(75);
        make.top.mas_equalTo(self.grayLabel2).offset(15);
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
    
    [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.mas_equalTo(self).offset(-10);
        make.top.mas_equalTo(self.grayLabel6).offset(10);
        make.size.mas_equalTo(CGSizeMake(90, 28));
        
    }];
    
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.mas_equalTo(self).offset(-10);
        make.top.mas_equalTo(self.grayLabel6).offset(10);
        make.size.mas_equalTo(CGSizeMake(110, 28));
        
    }];
    
    [self.waitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self).offset(-10);
        make.top.mas_equalTo(self.grayLabel6).offset(10);
        make.size.mas_equalTo(CGSizeMake(110, 28));
        
    }];
    
    [self.succesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self).offset(10);
        make.top.mas_equalTo(self.grayLabel6).offset(10);
        make.size.mas_equalTo(CGSizeMake(110, 15));
    }];
    
    [self.retureMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self.succesLabel).offset(110);
        make.top.mas_equalTo(self.grayLabel6).offset(10);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 150, 15));
        
    }];
    
}
- (void)setServiceDic:(NSDictionary *)serviceDic{
    
    _serviceDic = serviceDic;
    
    self.typeLabel.text = serviceDic[@"order_status"];
    self.orderStoreID.text = serviceDic[@"order_store_id"];
    NSMutableAttributedString *nameLabel = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"姓名:%@", serviceDic[@"consignee_name"]]];
    [nameLabel addAttribute:NSForegroundColorAttributeName value:HEISE range:NSMakeRange(0, 3)];
    self.nameLabel.attributedText = nameLabel;
    NSMutableAttributedString *phoneLabel = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"联系手机:%@", serviceDic[@"seller_phone"]]];
    [phoneLabel addAttribute:NSForegroundColorAttributeName value:HEISE range:NSMakeRange(0, 5)];
    self.phoneLabel.attributedText = phoneLabel;
    self.orderDetailID = serviceDic[@"order_detail_id"];
    NSMutableAttributedString *serviceLabel = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"服务时间:%@", serviceDic[@"order_service_time"]]];
    
    [serviceLabel addAttribute:NSForegroundColorAttributeName value:HEISE range:NSMakeRange(0, 4)];
    self.serviceTimeLabel.attributedText = serviceLabel;
    self.shopNameLabel.text = serviceDic[@"order_store_name"];    [self.goodImage sd_setImageWithURL:[NSURL URLWithString:serviceDic[@"order_goods_info"][0][@"goods_image"]] placeholderImage:CZHANWEI];
    self.goodNameLabel.text = serviceDic[@"order_goods_info"][0][@"goods_name"];
    
    
    self.goodMoneyLabel.text = [NSString stringWithFormat:@"¥%@", serviceDic[@"order_goods_info"][0][@"goods_amount"]];
    self.goodAmountLabel.text = [NSString stringWithFormat:@"*%@", serviceDic[@"order_goods_info"][0][@"goods_quantity"]];
    self.buyContentLabel.text = serviceDic[@"message"];
    self.moneyNumLabel.text = [NSString stringWithFormat:@"%@", serviceDic[@"order_amount"]];
    self.orderNumLabel.text = serviceDic[@"order_sn"];
    self.orderContentLabel.text = serviceDic[@"add_time"];
    self.roderNameLabel.text = serviceDic[@"order_store_name"];
    self.retureMoneyLabel.text = [NSString stringWithFormat:@"¥%@", serviceDic[@"order_amount"]];

    if ([serviceDic[@"order_status"] isEqualToString:@"等待买家付款"]) {
        self.waitPayTimeLabel.text = serviceDic[@"order_timestamp"];
        self.payBtn.hidden = NO;
        self.waitPayTimeLabel.hidden = NO;
    }else{
        self.payBtn.hidden = YES;
        self.waitPayTimeLabel.hidden = YES;
    }
    if ([serviceDic[@"order_status"] isEqualToString:@"交易成功"]) {
        self.sureBtn.hidden = NO;
    }else{
        self.sureBtn.hidden = YES;
    }
    if ([serviceDic[@"order_status"] isEqualToString:@"等待服务"]) {
        self.waitBtn.hidden = NO;
    }else{
        self.waitBtn.hidden = YES;
    }
    if ([serviceDic[@"order_status"] isEqualToString:@"已退款"]) {
        self.retureMoneyLabel.hidden = NO;
        self.succesLabel.hidden = NO;
    }else{
        self.retureMoneyLabel.hidden = YES;
        self.succesLabel.hidden = YES;
    }

}
//付款
- (void)playClick{
    
    self.payDic = [NSMutableDictionary dictionary];
    self.payDic = @{@"order_sn":self.orderNumLabel.text, @"order_amount":self.moneyNumLabel.text, @"order_date":self.orderContentLabel.text, @"order_title":self.roderNameLabel.text, @"order_ids":self.orderStoreID.text}.mutableCopy;
    PayMoneyViewController *payMoney = [[PayMoneyViewController alloc]init];
    UITabBarController *tabBarVC = (UITabBarController *)self.window.rootViewController;
    UINavigationController *nav = tabBarVC.selectedViewController;
    payMoney.dicInfo = self.payDic;
    [nav pushViewController:payMoney animated:YES];
    
}
#pragma mark----实现打电话的方法
- (void)phoneClick:(UIButton *)btn{
    
    if ([self.delegate respondsToSelector:@selector(HBSServiceOrderCell:WithPhoneUibutton:)]) {
        
        [self.delegate HBSServiceOrderCell:self WithPhoneUibutton:btn];
        
    }
    
}
//聊天代理
- (void)clickTalk:(UIButton *)btn{
    
    if ([self.delegate respondsToSelector:@selector(talkCallDelegate:WithclickTalk:)]) {
        
        [self.delegate talkCallDelegate:self WithclickTalk:btn];
    }
    
}
#pragma mark----确认完成服务方法
- (void)sureComplete:(UIButton *)btn{
    
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
                
                if ([self.delegate respondsToSelector:@selector(sureCompleteService:WithClickBtn:)]) {
                    
                    [self.delegate sureCompleteService:self WithClickBtn:btn];
                    
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
