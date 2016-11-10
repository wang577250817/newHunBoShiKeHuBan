//
//  HBSOrderCell.m
//  HBS_C
//
//  Created by 王 世江 on 16/11/4.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSOrderCell.h"
#import "HBSOrderModel.h"
#import "HBSOrderGoodView.h"

@interface HBSOrderCell ()
@property (nonatomic, strong) UILabel *shopNameLabel;//店名label
@property (nonatomic, strong) UILabel *stateLabel;//状态label
@property (nonatomic, strong) UILabel *grayLabel;//灰线label
#pragma mark----服务的数据
@property (nonatomic, strong) UIImageView *serviceImage;//服务image
@property (nonatomic, strong) UILabel *serviceNameLabel;//服务label
@property (nonatomic, strong) UILabel *serviceTimeLabel;//服务label
@property (nonatomic, strong) UILabel *grayLabel1;//灰线label
@property (nonatomic, strong) UILabel *moneyLabel;//总计label
@property (nonatomic, strong) UIButton *serviceWaitBtn;//等待买家付款btn
@property (nonatomic, strong) UIButton *serviceCancesOrderBtn;//等待买家付款btn
@property (nonatomic, strong) UIButton *serviceSureOrderBtn;//等待服务btn
@property (nonatomic, strong) UIButton *serviceFaOrderBtn;//等待服务btn
@property (nonatomic, strong) UIButton *serviceCompleteOrderBtn;//待服务btn
#pragma mark----商品的状态
@property (nonatomic, strong) UIImageView *goodsImage;//商品image
@property (nonatomic, strong) UIButton *goodsWaitFaHuoImage;//待发货btn
@property (nonatomic, strong) UIButton *goodsHasFaHuoImage;//已发货btn
@property (nonatomic, strong) UIButton *goodsHasCompleteImage;//交易成功
@property (nonatomic, strong)  HBSOrderGoodView *orderGoodView;



@end
@implementation HBSOrderCell

#pragma mark----初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.backgroundColor = HBSRandomColor;
    //店铺名称
    self.shopNameLabel = [[UILabel alloc]init];
    self.shopNameLabel.text = @"城祥不要脸店";
    self.shopNameLabel.backgroundColor = HBSRandomColor;
    self.shopNameLabel.font = FONT(13);
    self.shopNameLabel.textColor = HBSColor(102, 102, 102);
    [self addSubview:self.shopNameLabel];
    //服务状态
    self.stateLabel = [[UILabel alloc]init];
    self.stateLabel.text = @"城祥真的不要脸";
    self.stateLabel.backgroundColor = HBSRandomColor;
    self.stateLabel.textAlignment = NSTextAlignmentRight;
    self.stateLabel.font = FONT(13);
    self.stateLabel.textColor = FENSE;
    [self addSubview:self.stateLabel];
    //灰线
    self.grayLabel = [[UILabel alloc]init];
    self.grayLabel.backgroundColor = HBSColor(229, 229, 229);
    [self addSubview:self.grayLabel];
#pragma mark----服务的初始化
    //服务图片
    self.serviceImage = [[UIImageView alloc]init];
    [self.serviceImage setImage:[UIImage imageNamed:@"backImage"]];
    [self addSubview:self.serviceImage];
    //服务名称
    self.serviceNameLabel = [[UILabel alloc]init];
    self.serviceNameLabel.text = @"城祥制造城祥制造城祥制造城祥制造城祥制造城祥制造城祥制造城祥制造城祥制造";
    self.serviceNameLabel.numberOfLines = 0;
    self.serviceNameLabel.backgroundColor = HBSRandomColor;
    self.serviceNameLabel.font = FONT(14);
    self.serviceNameLabel.textColor = HEISE;
    [self addSubview:self.serviceNameLabel];
    //服务时间
    self.serviceTimeLabel = [[UILabel alloc]init];
    self.serviceTimeLabel.text = @"2016-11-5";
    self.serviceTimeLabel.backgroundColor = HBSRandomColor;
    self.serviceTimeLabel.font = FONT(13);
    self.serviceTimeLabel.textColor = HBSColor(102, 102, 102);
    [self addSubview:self.serviceTimeLabel];
    //灰线1
    self.grayLabel1 = [[UILabel alloc]init];
    self.grayLabel1.backgroundColor = HBSColor(229, 229, 229);
    [self addSubview:self.grayLabel1];
    //总计钱数
    self.moneyLabel = [[UILabel alloc]init];
    self.moneyLabel.textColor = FENSE;
    self.moneyLabel.font = FONT(13);
    self.moneyLabel.text = @"总计:";
    self.moneyLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.moneyLabel];

    
    //等待买家付款btn
    self.serviceWaitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.serviceWaitBtn setBackgroundImage:[UIImage imageNamed:@"button_1_2_3_fukuan"] forState:UIControlStateNormal];
    [self addSubview:self.serviceWaitBtn];
    //取消订单btn
    self.serviceCancesOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.serviceCancesOrderBtn setBackgroundImage:[UIImage imageNamed:@"button_1_2_3_quxiadingdan"] forState:UIControlStateNormal];
    [self addSubview:self.serviceCancesOrderBtn];
    //等待服务btn
    self.serviceSureOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.serviceSureOrderBtn setBackgroundImage:[UIImage imageNamed:@"button_1_2_3_querenwanchengdingdan"] forState:UIControlStateNormal];
    [self addSubview:self.serviceSureOrderBtn];
    
    //发表评价btn
    self.serviceFaOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.serviceFaOrderBtn setBackgroundImage:[UIImage imageNamed:@"button_1_2_3_fabiaopingjia"] forState:UIControlStateNormal];
    [self addSubview:self.serviceFaOrderBtn];
    //已经确认完成btn
    self.serviceCompleteOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.serviceCompleteOrderBtn setBackgroundImage:[UIImage imageNamed:@"button_1_2_3_yiquerenwanchengfuwu"] forState:UIControlStateNormal];
    [self addSubview:self.serviceCompleteOrderBtn];
#pragma mark----商品的初始化
    self.goodsImage = [[UIImageView alloc]init];
    [self.goodsImage setImage:[UIImage imageNamed:@"backImage"]];
    [self addSubview:self.goodsImage];
    //待发货btn
    self.goodsWaitFaHuoImage = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.goodsWaitFaHuoImage setBackgroundImage:[UIImage imageNamed:@"button_1_2_hui_querenshouhuo"] forState:UIControlStateNormal];
    [self addSubview:self.goodsWaitFaHuoImage];
    //已发货btn
    self.goodsHasFaHuoImage = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.goodsHasFaHuoImage setBackgroundImage:[UIImage imageNamed:@"button_1_2_hong_querenshouhuo"] forState:UIControlStateNormal];
    [self addSubview:self.goodsHasFaHuoImage];
    //已完成btn
    self.goodsHasCompleteImage = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.goodsHasCompleteImage setBackgroundImage:[UIImage imageNamed:@"button_yiquerenshouhuo"] forState:UIControlStateNormal];
    [self addSubview:self.goodsHasCompleteImage];
    
    return self;
}
#pragma mark----布局
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self).offset(10);
        make.top.mas_equalTo(self).offset(15);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 140, 15));
        
    }];
    
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.mas_equalTo(self).offset(-10);
        make.top.mas_equalTo(self).offset(15);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 260, 15));
        
    }];
    
    [self.grayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self).offset(10);
        make.top.mas_equalTo(self.stateLabel).offset(30);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 2 * 10, 1));
        
    }];
#pragma mark----服务的布局
    [self.serviceImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self).offset(10);
        make.top.mas_equalTo(self.grayLabel).offset(15);
        make.size.mas_equalTo(CGSizeMake(136, 76));
        
    }];
    
    [self.serviceNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self.serviceImage).offset(151);
        make.top.mas_equalTo(self.grayLabel).offset(17);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 170, 40));
    }];
    
    [self.serviceTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.serviceNameLabel).offset(58);
        make.left.mas_equalTo(self.serviceImage).offset(151);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 170, 15));
        
    }];
    
    [self.grayLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self).offset(10);
        make.top.mas_equalTo(self.serviceImage).offset(91);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 2 * 10, 1));
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.grayLabel1).offset(15);
        make.right.mas_equalTo(self).offset(-10);
        make.size.mas_equalTo(CGSizeMake(150, 15));
        
    }];
    
    [self.serviceWaitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.mas_equalTo(self).offset(-15);
        make.right.mas_equalTo(self).offset(-10);
        make.size.mas_equalTo(CGSizeMake(90, 28));
        
    }];
    
    [self.serviceCancesOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.mas_equalTo(self).offset(-15);
        make.right.mas_equalTo(self.serviceWaitBtn).offset(-102);
        make.size.mas_equalTo(CGSizeMake(80, 28));
        
    }];
    
    [self.serviceSureOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.mas_equalTo(self).offset(-15);
        make.right.mas_equalTo(self).offset(-10);
        make.size.mas_equalTo(CGSizeMake(110, 28));
        
    }];
    
    [self.serviceFaOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.mas_equalTo(self).offset(-15);
        make.right.mas_equalTo(self).offset(-10);
        make.size.mas_equalTo(CGSizeMake(80, 28));
        
    }];
    
    [self.serviceCompleteOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.mas_equalTo(self).offset(-15);
        make.right.mas_equalTo(self.serviceFaOrderBtn).offset(-102);
        make.size.mas_equalTo(CGSizeMake(110, 28));
        
    }];
#pragma mark----商品的布局


    [self.goodsWaitFaHuoImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.mas_equalTo(self).offset(-15);
        make.right.mas_equalTo(self).offset(-10);
        make.size.mas_equalTo(CGSizeMake(90, 28));
    
    }];
    [self.goodsHasFaHuoImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.mas_equalTo(self).offset(-15);
        make.right.mas_equalTo(self).offset(-10);
        make.size.mas_equalTo(CGSizeMake(90, 28));
        
    }];
    
    [self.goodsHasCompleteImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self).offset(-15);
        make.right.mas_equalTo(self).offset(-10);
        make.size.mas_equalTo(CGSizeMake(110, 28));
        
    }];

    
}
- (void)setFrame:(CGRect)frame{
    
    frame.size.height -= 5;
    [super setFrame:frame];
}
- (void)setOrderModel:(HBSOrderModel *)orderModel{
    
    _orderModel = orderModel;
    self.shopNameLabel.text = orderModel.order_store_name;
    self.stateLabel.text = orderModel.order_status;
    
    if ([orderModel.order_type isEqualToString:@"service"]) {
        self.serviceImage.hidden = NO;
        
        if ([orderModel.order_goods_info[0][@"goods_image"]isEqual:[NSNull null]]) {
        }else{
            [self.serviceImage sd_setImageWithURL:[NSURL URLWithString:orderModel.order_goods_info[0][@"goods_image"]] placeholderImage:CZHANWEI];
        }
        self.serviceNameLabel.hidden = NO;
        self.serviceNameLabel.text = orderModel.order_goods_info[0][@"goods_name"];
        self.serviceTimeLabel.hidden = NO;
        self.serviceTimeLabel.text = [NSString stringWithFormat:@"服务时间:%@", orderModel.order_goods_info[0][@"order_service_time"]];
        self.grayLabel1.hidden = NO;
        self.moneyLabel.hidden = NO;
        self.moneyLabel.text = [NSString stringWithFormat:@"总计: ¥%@", orderModel.order_amount];
        if ([orderModel.order_status isEqualToString:@"等待买家付款"]) {
            self.serviceWaitBtn.hidden = NO;
            self.serviceCancesOrderBtn.hidden = NO;
            
        }else{
            self.serviceWaitBtn.hidden = YES;
            self.serviceCancesOrderBtn.hidden = YES;
        }
        if ([orderModel.order_status isEqualToString:@"等待服务"]) {
            self.serviceSureOrderBtn.hidden = NO;
         
        }else{
            self.serviceSureOrderBtn.hidden = YES;
        }
        if ([orderModel.order_status isEqualToString:@"交易成功"]) {
            self.serviceFaOrderBtn.hidden = NO;
            self.serviceCompleteOrderBtn.hidden = NO;
            
        }else{
            self.serviceFaOrderBtn.hidden = YES;
            self.serviceCompleteOrderBtn.hidden = YES;
          
        }
        
        self.goodsImage.hidden = YES;
        self.goodsWaitFaHuoImage.hidden = YES;
        self.goodsHasFaHuoImage.hidden = YES;
        self.goodsHasCompleteImage.hidden = YES;
        self.orderGoodView.hidden = YES;
    }else if ([orderModel.order_type isEqualToString:@"product"]){
     
        self.orderGoodView = [[HBSOrderGoodView alloc]init];
        self.orderGoodView.frame = orderModel.contentG;
        self.orderGoodView.orderModel = orderModel;
        [self addSubview:self.orderGoodView];

        if ([orderModel.order_status isEqualToString:@"等待买家付款"]) {
            self.serviceWaitBtn.hidden = NO;
            self.serviceCancesOrderBtn.hidden = NO;
        }else{
            self.serviceWaitBtn.hidden = YES;
            self.serviceCancesOrderBtn.hidden = YES;
        }
        if ([orderModel.order_status isEqualToString:@"待发货"]) {
            self.goodsWaitFaHuoImage.hidden = NO;
        }else{
            self.goodsWaitFaHuoImage.hidden = YES;
        }
        if ([orderModel.order_status isEqualToString:@"待收货"]) {
            self.goodsHasFaHuoImage.hidden = NO;
        }else{
            self.goodsHasFaHuoImage.hidden = YES;
        }
        if ([orderModel.order_status isEqualToString:@"交易成功"]) {
            self.goodsHasCompleteImage.hidden = NO;
        }else{
            self.goodsHasCompleteImage.hidden = YES;
        }
        self.goodsImage.hidden = NO;
        self.serviceImage.hidden = YES;
        self.serviceNameLabel.hidden = YES;
        self.serviceTimeLabel.hidden = YES;
        self.grayLabel1.hidden = YES;
        self.moneyLabel.hidden = YES;
        self.serviceSureOrderBtn.hidden = YES;
        self.serviceFaOrderBtn.hidden = YES;
        self.serviceCompleteOrderBtn.hidden = YES;
        
    }else{
        self.goodsImage.hidden = NO;
        HBSLog(@"其他");
    }
    
}
@end
