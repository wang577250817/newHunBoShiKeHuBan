//
//  ShopCarTableViewCell.m
//  HBS_C
//
//  Created by wangzuowen on 16/10/21.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "ShopCarTableViewCell.h"

@interface ShopCarTableViewCell()

{
    NSInteger tt;
}
@property (nonatomic, strong)UIImageView *imgView;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *specLabel;
@property (nonatomic, strong)UILabel *priceLabel;
@property (nonatomic, strong)UILabel *numberLabel;
@property (nonatomic, strong)UIButton *addButton;
@property (nonatomic, strong)UIButton *reduceButton;
@property (nonatomic, strong) UILabel *buyNumLabel;//购买数量
@property (nonatomic, strong) UILabel *grayLabel;

@property (nonatomic, strong)UITextField *numTF;

@end
@implementation ShopCarTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _roundButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_roundButton setImage:[UIImage imageNamed:@"icon_hun@2x"] forState:UIControlStateNormal];
        [_roundButton setImage:[UIImage imageNamed:@"icon_1_2_xuanzhonghong"] forState:UIControlStateSelected];
        
        [self.contentView addSubview:_roundButton];
        
        _imgView = [[UIImageView alloc] init];
        [self.contentView addSubview:_imgView];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = FONT(14);
        _titleLabel.textColor = HEISE;
        [self.contentView addSubview:_titleLabel];
        
        _specLabel = [[UILabel alloc] init];
        _specLabel.font = FONT(12);
        _specLabel.textColor = erlingsiColor;
        [self.contentView addSubview:_specLabel];
        
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = FONT(15);
        _priceLabel.textColor = FENSE;
        [self.contentView addSubview:_priceLabel];
        
        self.buyNumLabel = [[UILabel alloc] init];
        self.buyNumLabel.text = @"购买数量:";
        self.buyNumLabel.font = FONT(14);
//        self.buyNumLabel.backgroundColor = HBSRandomColor;
        self.buyNumLabel.textColor = HEISE;
        [self.contentView addSubview:self.buyNumLabel];
        
        self.grayLabel = [[UILabel alloc]init];
        self.grayLabel.backgroundColor = HBSColor(229, 229, 229);
        self.grayLabel.hidden = NO;
        [self addSubview:self.grayLabel];
        
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.font = FONT(14);
        _numberLabel.textAlignment = NSTextAlignmentRight;
//        _numberLabel.backgroundColor = HBSRandomColor;
        _numberLabel.textColor = HEISE;
        
        [self.contentView addSubview:_numberLabel];
        
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addButton.layer.borderWidth = 2;
        _addButton.layer.borderColor = RANDOMCOLOR(204, 204, 204).CGColor;
        [self.contentView addSubview:_addButton];
        
        _reduceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _reduceButton.layer.borderWidth = 2;
        _reduceButton.layer.borderColor = RANDOMCOLOR(204, 204, 204).CGColor;
        [self.contentView addSubview:_reduceButton];
        
        _numTF = [[UITextField alloc] init];
        _numTF.textAlignment = NSTextAlignmentCenter;
        _numTF.layer.borderWidth = 2;
        _numTF.layer.borderColor = RANDOMCOLOR(204, 204, 204).CGColor;
//        self.numTF.userInteractionEnabled = NO;
        _numTF.textColor = HEISE;
        self.numTF.tintColor = [UIColor grayColor];
        self.numTF.keyboardType = UIKeyboardTypeNumberPad;
        _numTF.font = FONT(15);
        [self.contentView addSubview:_numTF];
        
        _okButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _okButton.titleLabel.font = FONT(14);
        [_okButton setTitle:@"编辑" forState:UIControlStateNormal];
        [_okButton setTitle:@"完成" forState:UIControlStateSelected];
        [_okButton setTitleColor:FENSE forState:UIControlStateNormal];
        [_okButton setTitleColor:HEISE forState:UIControlStateSelected];
        [_okButton addTarget:self action:@selector(okAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_okButton];
        
        
        [self.addButton setTitleColor:HEISE forState:UIControlStateNormal];
        [self.reduceButton setTitleColor:HEISE forState:UIControlStateNormal];
        [self.addButton setTitle:@"+" forState:0];
        [self.reduceButton setTitle:@"-" forState:0];
        [self.addButton addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
        [self.reduceButton addTarget:self action:@selector(reduceAction) forControlEvents:UIControlEventTouchUpInside];
        
        _numTF.userInteractionEnabled = NO;
        _addButton.userInteractionEnabled = NO;
        _reduceButton.userInteractionEnabled = NO;
//        _roundButton.userInteractionEnabled = NO;
        _numTF.hidden = YES;
        _addButton.hidden = YES;
        _reduceButton.hidden = YES;
        [self setUp_UI];
    }
    return self;
}
- (void)okAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (!sender.selected) {
        _numTF.userInteractionEnabled = NO;
        _addButton.userInteractionEnabled = NO;
        _reduceButton.userInteractionEnabled = NO;
//        _roundButton.userInteractionEnabled = NO;
        if ([_numTF.text integerValue] != tt) {
            self.blockNum([_numTF.text integerValue]);
        }
        _numTF.hidden = YES;
        _addButton.hidden = YES;
        _reduceButton.hidden = YES;
        self.numberLabel.hidden = NO;
    }else{
        _numTF.userInteractionEnabled = YES;
        _addButton.userInteractionEnabled = YES;
        _reduceButton.userInteractionEnabled = YES;
//        _roundButton.userInteractionEnabled = YES;
        _numTF.hidden = NO;
        _addButton.hidden = NO;
        _reduceButton.hidden = NO;
        self.numberLabel.hidden = YES;
    }
}
- (void)addAction
{
    _numTF.text = [NSString stringWithFormat:@"%ld", [self.numTF.text integerValue] + 1];
    _numberLabel.text = [NSString stringWithFormat:@"*%@", self.numTF.text];
    self.block([self.numTF.text integerValue]);
}
- (void)reduceAction
{
    if ([_numTF.text integerValue] != 1) {
        _numTF.text = [NSString stringWithFormat:@"%ld", [self.numTF.text integerValue] - 1];
        _numberLabel.text = [NSString stringWithFormat:@"*%@", self.numTF.text];
        self.block([self.numTF.text integerValue]);
    }
}
- (void)setUp_UI
{
    [self.roundButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(60);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];

    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_roundButton.mas_right).offset(10);
        make.top.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(90 * WSHIPEI, 90 * WSHIPEI));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_imgView.mas_right).offset(10);
        make.top.mas_equalTo(_imgView.mas_top);
        make.size.mas_equalTo(CGSizeMake((WIDTH - 145) * WSHIPEI, 40));
    }];
    [self.specLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLabel.mas_left);
        make.top.mas_equalTo(_titleLabel.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake((WIDTH - 148) * WSHIPEI, 10));
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLabel.mas_left);
        make.top.mas_equalTo(_specLabel.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake((WIDTH - 148) * WSHIPEI, 20));
    }];
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(_imgView.mas_left);
        make.right.mas_equalTo(self).offset(-5);
        make.top.mas_equalTo(_imgView.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(120, 20));
    }];
    [self.okButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(WIDTH - 20 * WSHIPEI - 230);
        make.left.mas_equalTo(self).offset(20);
        make.top.mas_equalTo(_numberLabel.mas_top).offset(-4);
        make.size.mas_equalTo(CGSizeMake(30, 28));
    }];
    [self.buyNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.okButton).offset(40);
        make.top.mas_equalTo(_numberLabel.mas_top).offset(0);
        make.size.mas_equalTo(CGSizeMake(65, 20));
        
    }];
    [self.grayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.buyNumLabel).offset(37);
        make.left.mas_equalTo(self).offset(10);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 2 * 10, 1));
    }];
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(_okButton.mas_left).offset(-40 * WSHIPEI);
        make.right.mas_equalTo(self).offset(-10);
        make.top.mas_equalTo(_numberLabel.mas_top).offset(-7);
        make.size.mas_equalTo(CGSizeMake(36, 28));
    }];
    [self.numTF mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(_addButton.mas_left);
        make.right.mas_equalTo(self.addButton).offset(-36);
        make.top.mas_equalTo(_numberLabel.mas_top).offset(-7);
        make.size.mas_equalTo(CGSizeMake(64, 28));
    }];
    [self.reduceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.numTF).offset(-60);
        make.top.mas_equalTo(_numberLabel.mas_top).offset(-7);
        make.size.mas_equalTo(CGSizeMake(36, 28));
    }];
    
//    self.numTF.text = @"1";
//    self.numberLabel.text = @"购买数量:00000";
    
}
- (void)setDic:(NSMutableDictionary *)dic
{
    _dic = dic;
    [_imgView sd_setImageWithURL:WZWURLWithString(dic[@"goods_image"]) placeholderImage:ZHANWEI];
    _titleLabel.text = dic[@"goods_name"];
    _priceLabel.text = [NSString stringWithFormat:@"¥%@", dic[@"goods_price"]];
    _numTF.text = dic[@"goods_quantity"];
    _numberLabel.text = [NSString stringWithFormat:@"*%@", dic[@"goods_quantity"]];
    self.specLabel.text = [NSString stringWithFormat:@"{%@}", dic[@"goods_specification"]];
    tt = [dic[@"goods_quantity"] integerValue];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
