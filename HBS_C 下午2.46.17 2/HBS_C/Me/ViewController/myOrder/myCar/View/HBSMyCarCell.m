//
//  HBSMyCarCell.m
//  HBS_C
//
//  Created by 王 世江 on 16/11/10.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSMyCarCell.h"
#import "HBSMyCarModel.h"

@interface HBSMyCarCell ()
@property (nonatomic, strong) UIImageView *storeGoodImage;//商品图片
@property (nonatomic, strong) UILabel *storeNameLabel;//商品名字
@property (nonatomic, strong) UILabel *storeSpecLabel;//商品规格
@property (nonatomic, strong) UILabel *storeSpriceLabel;//商品价格
@property (nonatomic, strong) UIButton *editBtn;//编辑按钮
@property (nonatomic, strong) UILabel *buyNumLabel;//购买数量
@property (nonatomic, strong) UILabel *quantityNumLabel;//商品数量
@property (nonatomic, strong) UILabel *bottomLabel;
@property (nonatomic, strong) NSString *goodRec_id;
@property (nonatomic, strong) UIButton *selectBtn;//筛选按钮

@end
//循环引用标识
static NSString *HBSMyCarCellID = @"Car";
@implementation HBSMyCarCell
//实现方法
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    HBSMyCarCell *cell = [tableView dequeueReusableCellWithIdentifier:HBSMyCarCellID];
    if (cell == nil) {
        
        cell = [[HBSMyCarCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HBSMyCarCellID];
        
    }
    return cell;
}
#pragma mark----初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.backgroundColor = HBSRandomColor;
        //商品图片
        self.storeGoodImage = [[UIImageView alloc]init];
        self.storeGoodImage.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.storeGoodImage];
        //商品名字
        self.storeNameLabel = [[UILabel alloc]init];
        self.storeNameLabel.font = FONT(14);
        self.storeNameLabel.textColor = HEISE;
        self.storeNameLabel.numberOfLines = 0;
//        self.storeNameLabel.backgroundColor = HBSRandomColor;
        [self addSubview:self.storeNameLabel];
        //商品规格
        self.storeSpecLabel = [[UILabel alloc]init];
        self.storeSpecLabel.font = FONT(10);
        self.storeSpecLabel.textColor = HBSColor(102, 102, 102);
//        self.storeSpecLabel.backgroundColor = HBSRandomColor;
        [self addSubview:self.storeSpecLabel];
        //商品价格
        self.storeSpriceLabel = [[UILabel alloc]init];
        self.storeSpriceLabel.font = FONT(14);
        self.storeSpriceLabel.textColor = FENSE;
//        self.storeSpriceLabel.backgroundColor = HBSRandomColor;
        [self addSubview:self.storeSpriceLabel];
        //编辑按钮
        self.editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [self.editBtn setTitle:@"完成" forState:UIControlStateSelected];
        [self.editBtn setTitleColor:FENSE forState:UIControlStateNormal];
        [self.editBtn setTitleColor:HEISE forState:UIControlStateSelected];
//        self.editBtn.backgroundColor = HBSRandomColor;
        self.editBtn.titleLabel.font = FONT(14);
        [self.editBtn addTarget:self action:@selector(editBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.editBtn];
        //购买数量
        self.buyNumLabel = [[UILabel alloc]init];
        self.buyNumLabel.font = FONT(14);
        self.buyNumLabel.textColor = HEISE;
        self.buyNumLabel.text = @"购买数量:";
//        self.buyNumLabel.backgroundColor = HBSRandomColor;
        [self addSubview:self.buyNumLabel];
        //商品数量
        self.quantityNumLabel = [[UILabel alloc]init];
        self.quantityNumLabel.font = FONT(15);
        self.quantityNumLabel.textColor = HEISE;
        self.quantityNumLabel.textAlignment = NSTextAlignmentRight;
//        self.quantityNumLabel.backgroundColor = HBSRandomColor;
        [self addSubview:self.quantityNumLabel];
        
        self.bottomLabel = [[UILabel alloc]init];
        self.bottomLabel.backgroundColor = [UIColor blueColor];
        [self addSubview:self.bottomLabel];
        
        //筛选按钮
        self.selectBtn = [[UIButton alloc]init];
        [self.selectBtn setImage:[UIImage imageNamed:@"icon_1_2_xuanzekuang"] forState:UIControlStateNormal];
        [self.selectBtn setImage:[UIImage imageNamed:@"icon_1_2_xuanzhonghong"] forState:UIControlStateSelected];
//        self.selectBtn.tag = 0;
        [self.selectBtn addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.selectBtn];
        //添加按钮
        self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.addBtn setImage:[UIImage imageNamed:@"icon_1_2_youkuang"] forState:UIControlStateNormal];
        self.addBtn.tag = 1;
        [self.addBtn addTarget:self action:@selector(goodsCountNumClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.addBtn];
        //数量
        self.numbersTf = [[UITextField alloc]init];
        self.numbersTf.textAlignment = 1;
//        self.numbersTf.backgroundColor = HBSRandomColor;
        self.numbersTf.userInteractionEnabled = NO;
        [self addSubview:self.numbersTf];
        //减少按钮
        self.reduceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.reduceBtn setImage:[UIImage imageNamed:@"icon_1_2_zuokuang"] forState:UIControlStateNormal];
        self.reduceBtn.tag = 2;
        [self.reduceBtn addTarget:self action:@selector(goodsCountNumClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.reduceBtn];
        
        
    }
    
    return self;
}
#pragma mark----布局
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.storeGoodImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self).offset(38);
        make.top.mas_equalTo(self).offset(10);
        make.size.mas_equalTo(CGSizeMake(90, 90));
        
    }];
    
    [self.storeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self.storeGoodImage).offset(100);
        make.top.mas_equalTo(self).offset(12);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 150, 35));
        
    }];
    
    [self.storeSpecLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self.storeGoodImage).offset(100);
        make.top.mas_equalTo(self.storeNameLabel).offset(45);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 150, 15));
        
    }];
    
    [self.storeSpriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self.storeGoodImage).offset(100);
        make.top.mas_equalTo(self.storeSpecLabel).offset(25);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 150, 15));
        
    }];
    
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self).offset(10);
        make.top.mas_equalTo(self.storeGoodImage).offset(117);
        make.size.mas_equalTo(CGSizeMake(40, 15));
        
    }];
    
    [self.buyNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.editBtn).offset(76);
        make.top.mas_equalTo(self.storeGoodImage).offset(117);
        make.size.mas_equalTo(CGSizeMake(80, 15));
        
    }];
    
    [self.quantityNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self).offset(-10);
        make.top.mas_equalTo(self.storeGoodImage).offset(117);
        make.size.mas_equalTo(CGSizeMake(80, 15));
        
    }];
    
    self.selectBtn.frame = CGRectMake(10, 50, 18, 18);
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self).offset(-10);
        make.top.mas_equalTo(self.storeGoodImage).offset(107);
        make.size.mas_equalTo(CGSizeMake(38, 28));
        
    }];
    [self.numbersTf mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.mas_equalTo(self.addBtn).offset(-38);
        make.top.mas_equalTo(self.storeGoodImage).offset(107);
        make.size.mas_equalTo(CGSizeMake(60, 28));

        
    }];
    
    [self.reduceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.numbersTf).offset(-60);
        make.top.mas_equalTo(self.storeGoodImage).offset(107);
        make.size.mas_equalTo(CGSizeMake(38, 28));
        
    }];

    
    
//    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//       
//        make.bottom.mas_equalTo(self).offset(1);
//        make.left.mas_equalTo(self).offset(10);
//        make.size.mas_equalTo(CGSizeMake(WIDTH - 2 * 10, 1));
//        
//    }];
    
}

#pragma mark----赋值
- (void)setMyCarModel:(HBSMyCarModel *)myCarModel{
    
    _myCarModel = myCarModel;
    
    self.selectBtn.selected = myCarModel.isSelect;
    [self.storeGoodImage sd_setImageWithURL:[NSURL URLWithString:myCarModel.goods_image] placeholderImage:ZHANWEI];
    self.storeNameLabel.text = myCarModel.goods_name;
    self.storeSpecLabel.text = myCarModel.goods_specification;
    self.numbersTf.text = myCarModel.goods_quantity;//数量
    self.goodRec_id = myCarModel.rec_id;
    
    
    if (self.numbersTf.text.intValue > 1) {
        self.reduceBtn.enabled = YES;
    }
    if ([self.editBtn.titleLabel.text isEqual:@"编辑"]) {
        
        self.addBtn.hidden = YES;
        self.reduceBtn.hidden = YES;
        self.numbersTf.hidden = YES;
     
    }
    self.storeSpriceLabel.text = [NSString stringWithFormat:@"¥%@",myCarModel.goods_price];
    self.quantityNumLabel.text = [NSString stringWithFormat:@"*%@", myCarModel.goods_quantity];
}
#pragma mark----监听数量文本框 编辑完成时调用
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    self.numbersTf = textField;
    if (self.numbersTf.text.intValue < 0) {
        
        self.numbersTf.text = @"1";
    }
    if (self.numbersTf.text.intValue > 999999) {
        
        self.addBtn.enabled = NO;
        self.numbersTf.text = @"999999";
        
    }
    if (self.numbersTf.text.intValue == 1) {
        
        self.reduceBtn.enabled = NO;
    }
    self.chooseCount = self.numbersTf.text.intValue;
    
}

#pragma mark----选择按钮的点击方法
- (void)selectButtonClick:(UIButton *)sender{
    
    if ([self.delegate respondsToSelector:@selector(ShoppingCellDelegate:WithSelectButton:)]) {
        [self.delegate ShoppingCellDelegate:self WithSelectButton:sender];
    }
    
}
#pragma mark----编辑数量的点击方法
- (void)goodsCountNumClick:(UIButton *)sender{
    
    if ([self.delegate respondsToSelector:@selector(ShoppingCellDelegateForGoodsCount:WithCountButton:)]) {
        
        [self.delegate ShoppingCellDelegateForGoodsCount:self WithCountButton:sender];
        
    }
    
}
#pragma mark----编辑按钮实现方法
- (void)editBtnClick:(UIButton *)btn{
    
    btn.selected =! btn.selected;
    if (btn.selected) {
        self.quantityNumLabel.hidden = YES;
       
        self.addBtn.hidden = NO;
        self.reduceBtn.hidden = NO;
        self.numbersTf.hidden = NO;
        
    }else{
       
        self.quantityNumLabel.hidden = NO;       
        self.addBtn.hidden = YES;
        self.reduceBtn.hidden = YES;
        self.numbersTf.hidden = YES;
    
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"id"] = user_id_find;
        params[@"token"] = userToken;
        params[@"rec_id"] = self.goodRec_id;
        params[@"quantity"] = self.numbersTf.text;
        
        
        
        [HBSNetWork putUrl:[NSString stringWithFormat:@"%@cart/%@", HBSNetAdress,params[@"id"]] parame:params cookie:nil result:^(id result) {
            
            if ([result[@"code"]integerValue] == 200) {
                
                HBSLog(@"修改成功");
                [self reloadInputViews];
                
            }else if ([result[@"code"]integerValue] == 400){
                
                HBSLog(@"修改失败");
            }
        }];

        
    }
    
}

@end
