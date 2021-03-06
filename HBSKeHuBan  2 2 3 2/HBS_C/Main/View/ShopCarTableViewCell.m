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

@property (nonatomic, strong)UITextField *numTF;
@property (nonatomic, strong) UILabel *endLabel;//修改成功标识

@end
@implementation ShopCarTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _roundButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_roundButton setImage:[UIImage imageNamed:@"icon_hun@2x"] forState:UIControlStateNormal];
        [_roundButton setImage:[UIImage imageNamed:@"icon_1_2_xuanzhonghong"] forState:UIControlStateSelected];
        //        self.roundButton.backgroundColor = [UIColor orangeColor];
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
        
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.font = FONT(14);
        _numberLabel.textColor = HEISE;
        [self.contentView addSubview:_numberLabel];
        
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addButton.layer.borderWidth = 2;
        //        [_addButton setBackgroundColor:[UIColor redColor]];
        _addButton.layer.borderColor = RANDOMCOLOR(204, 204, 204).CGColor;
        [self.contentView addSubview:_addButton];
        
        _reduceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _reduceButton.layer.borderWidth = 2;
        _reduceButton.layer.borderColor = RANDOMCOLOR(204, 204, 204).CGColor;
        [self.contentView addSubview:_reduceButton];
        
        _numTF = [[UITextField alloc] init];
        _numTF.textAlignment = NSTextAlignmentCenter;
        _numTF.layer.borderWidth = 2;
        _numTF.keyboardType = UIKeyboardTypeNumberPad;
        _numTF.layer.borderColor = RANDOMCOLOR(204, 204, 204).CGColor;
        _numTF.textColor = HEISE;
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
        if ([_numTF.text integerValue] == 0) {
            
            self.endLabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH / 2 - 90, HEIGHT / 2 - 200, 180, 25)];
            self.endLabel.backgroundColor = [UIColor blackColor];
            self.endLabel.alpha = 0.8;
            _endLabel.layer.cornerRadius = 5;
            _endLabel.layer.masksToBounds = YES;
            _endLabel.textColor = BAISE;
            _endLabel.text = @"亲* 超出数量范围哦!";
            _endLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:self.endLabel];
            CATransition * transion = [CATransition animation];
            transion.type = @"push";//设置动画方式
            transion.subtype = @"fromBottom";//设置动画从那个方向开始
            [_endLabel.layer addAnimation:transion forKey:nil];
            
            //Label.layer 添加动画
            //设置延时效果
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(),^{
                [_endLabel removeFromSuperview];
                self.numTF.text = @"1";
                
                _numTF.hidden = YES;
                _addButton.hidden = YES;
                _reduceButton.hidden = YES;
                
            });
            
        }else{
            
            if ([_numTF.text integerValue] != tt) {
                self.blockNum([_numTF.text integerValue]);
            }
            _numTF.hidden = YES;
            _addButton.hidden = YES;
            _reduceButton.hidden = YES;
            
        }
        
    }else{
        _numTF.userInteractionEnabled = YES;
        _addButton.userInteractionEnabled = YES;
        _reduceButton.userInteractionEnabled = YES;
        //        _roundButton.userInteractionEnabled = YES;
        _numTF.hidden = NO;
        _addButton.hidden = NO;
        _reduceButton.hidden = NO;
    }
}
- (void)addAction
{
    _numTF.text = [NSString stringWithFormat:@"%ld", [self.numTF.text integerValue] + 1];
    _numberLabel.text = [NSString stringWithFormat:@"购买数量:%@", self.numTF.text];
    self.block([self.numTF.text integerValue]);
}
- (void)reduceAction
{
    if ([_numTF.text integerValue] != 1) {
        _numTF.text = [NSString stringWithFormat:@"%ld", [self.numTF.text integerValue] - 1];
        _numberLabel.text = [NSString stringWithFormat:@"购买数量:%@", self.numTF.text];
        self.block([self.numTF.text integerValue]);
    }else if ([self.numTF.text integerValue] == 1){
        
        self.endLabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH / 2 - 145, HEIGHT / 2 - 200, 300, 25)];
        self.endLabel.backgroundColor = [UIColor blackColor];
        self.endLabel.alpha = 0.6;
        _endLabel.layer.cornerRadius = 5;
        _endLabel.layer.masksToBounds = YES;
        _endLabel.textColor = BAISE;
        _endLabel.text = @"亲* 不能再减了哦 再减宝贝就不见了!";
        _endLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.endLabel];
        CATransition * transion = [CATransition animation];
        transion.type = @"push";//设置动画方式
        transion.subtype = @"fromTop";//设置动画从那个方向开始
        [_endLabel.layer addAnimation:transion forKey:nil];
        
        //Label.layer 添加动画
        //设置延时效果
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(),^{
            
            [_endLabel removeFromSuperview];
            
            
        });
        
        
    }
}
- (void)setUp_UI
{
    [self.roundButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(60);
        make.size.mas_equalTo(CGSizeMake(25, 30));
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
        make.left.mas_equalTo(_imgView.mas_left);
        make.top.mas_equalTo(_imgView.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(120, 20));
    }];
    [self.okButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WIDTH - 20 * WSHIPEI - 30);
        make.top.mas_equalTo(_numberLabel.mas_top).offset(-4);
        make.size.mas_equalTo(CGSizeMake(30, 28));
    }];
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_okButton.mas_left).offset(-10 * WSHIPEI);
        make.top.mas_equalTo(_numberLabel.mas_top).offset(-7);
        make.size.mas_equalTo(CGSizeMake(36, 28));
    }];
    [self.numTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_addButton.mas_left);
        make.top.mas_equalTo(_numberLabel.mas_top).offset(-7);
        make.size.mas_equalTo(CGSizeMake(66, 28));
    }];
    [self.reduceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_numTF.mas_left);
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
    _numberLabel.text = [NSString stringWithFormat:@"购买数量:%@", dic[@"goods_quantity"]];
    if ([dic[@"goods_specification"] isEqualToString:@""] || [dic[@"goods_specification"] isEqual:[NSNull null]]) {
        self.specLabel.text = @"";
    }else{
        
        self.specLabel.text = [NSString stringWithFormat:@"{%@}", dic[@"goods_specification"]];
    }
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
