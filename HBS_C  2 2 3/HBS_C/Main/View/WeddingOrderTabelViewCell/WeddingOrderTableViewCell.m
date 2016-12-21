//
//  WeddingOrderTableViewCell.m
//  HBS_C
//
//  Created by wangzuowen on 16/11/3.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "WeddingOrderTableViewCell.h"


@interface WeddingOrderTableViewCell()

@property (nonatomic, strong)UIImageView *imgView;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *specLabel;
@property (nonatomic, strong)UILabel *priceLabel;
@property (nonatomic, strong)UILabel *numberLabel;
//@property (nonatomic, strong)UIButton *addButton;
//@property (nonatomic, strong)UIButton *reduceButton;
//@property (nonatomic, strong)UITextField *numTF;

@end
@implementation WeddingOrderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
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
        _numberLabel.textAlignment = NSTextAlignmentRight;
        _numberLabel.font = FONT(14);
        _numberLabel.textColor = HEISE;
        [self.contentView addSubview:_numberLabel];
        
//        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _addButton.layer.borderWidth = 2;
//        _addButton.layer.borderColor = RANDOMCOLOR(204, 204, 204).CGColor;
//        [self.contentView addSubview:_addButton];
        
//        _reduceButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _reduceButton.layer.borderWidth = 2;
//        _reduceButton.layer.borderColor = RANDOMCOLOR(204, 204, 204).CGColor;
//        [self.contentView addSubview:_reduceButton];
//        
//        _numTF = [[UITextField alloc] init];
//        _numTF.textAlignment = NSTextAlignmentCenter;
//        _numTF.layer.borderWidth = 2;
//        _numTF.layer.borderColor = RANDOMCOLOR(204, 204, 204).CGColor;
//        _numTF.textColor = HEISE;
//        _numTF.font = FONT(15);
//        [self.contentView addSubview:_numTF];
        
//        [self.addButton setTitleColor:HEISE forState:UIControlStateNormal];
//        [self.reduceButton setTitleColor:HEISE forState:UIControlStateNormal];
//        [self.addButton setTitle:@"+" forState:0];
//        [self.reduceButton setTitle:@"-" forState:0];
//        [self.addButton addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
//        [self.reduceButton addTarget:self action:@selector(reduceAction) forControlEvents:UIControlEventTouchUpInside];
        
//        _imgView.backgroundColor = WZWorangeColor;
//        _titleLabel.backgroundColor = WZWmagentaColor;
//        _priceLabel.backgroundColor = WZWgrayColor;
//        _numberLabel.backgroundColor = WZWlightGrayColor;
//        _specLabel.backgroundColor = [UIColor greenColor];
        
        
        [self setUp_UI];
    }
    return self;
}
//- (void)addAction
//{
//    if (_isCar) {
//        if ([_numTF.text integerValue] < [self.dic[@"goods_stock"] integerValue]) {
//            
//            _numTF.text = [NSString stringWithFormat:@"%ld", [self.numTF.text integerValue] + 1];
//            _numberLabel.text = [NSString stringWithFormat:@"购买数量:%@", self.numTF.text];
//            self.block([self.numTF.text integerValue]);
//
//        }
//    }else{
//        _numTF.text = [NSString stringWithFormat:@"%ld", [self.numTF.text integerValue] + 1];
//        _numberLabel.text = [NSString stringWithFormat:@"购买数量:%@", self.numTF.text];
//        self.block([self.numTF.text integerValue]);
//    }
//    
//   
//}
//- (void)reduceAction
//{
//    if ([_numTF.text integerValue] != 1) {
//        _numTF.text = [NSString stringWithFormat:@"%ld", [self.numTF.text integerValue] - 1];
//        _numberLabel.text = [NSString stringWithFormat:@"购买数量:%@", self.numTF.text];
//        self.block([self.numTF.text integerValue]);
//    }
//}
- (void)setUp_UI
{
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(90 * WSHIPEI, 90 * WSHIPEI));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_imgView.mas_right).offset(10);
        make.top.mas_equalTo(_imgView.mas_top);
        make.size.mas_equalTo(CGSizeMake((WIDTH - 120) * WSHIPEI, 40));
    }];
    [self.specLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLabel.mas_left);
        make.top.mas_equalTo(_titleLabel.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake((WIDTH - 120) * WSHIPEI, 10));
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLabel.mas_left);
        make.top.mas_equalTo(_specLabel.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake((WIDTH - 120) * WSHIPEI, 20));
    }];
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
        make.top.mas_equalTo(_specLabel.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(100 * WSHIPEI, 20));
    }];
//    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(WIDTH - 46);
//        make.top.mas_equalTo(_numberLabel.mas_top).offset(-7);
//        make.size.mas_equalTo(CGSizeMake(36, 28));
//    }];
//    [self.numTF mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(_addButton.mas_left);
//        make.top.mas_equalTo(_numberLabel.mas_top).offset(-7);
//        make.size.mas_equalTo(CGSizeMake(66, 28));
//    }];
//    [self.reduceButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(_numTF.mas_left);
//        make.top.mas_equalTo(_numberLabel.mas_top).offset(-7);
//        make.size.mas_equalTo(CGSizeMake(36, 28));
//    }];
    
    
}
- (void)setDic:(NSMutableDictionary *)dic
{
    _dic = dic;
    if (_isCar) {
        [_imgView sd_setImageWithURL:WZWURLWithString(dic[@"goods_image"]) placeholderImage:ZHANWEI];
        _titleLabel.text = dic[@"goods_name"];
        _priceLabel.text = [NSString stringWithFormat:@"¥%@", dic[@"goods_price"]];
//        self.numTF.text = dic[@"goods_quantity"];
        self.numberLabel.text = [NSString stringWithFormat:@"*%@", dic[@"goods_quantity"]];
        self.specLabel.text = [NSString stringWithFormat:@"{%@}", dic[@"goods_specification"]];
    }else{
//        self.numTF.text = @"1";
        self.numberLabel.text = [NSString stringWithFormat:@"*%@", self.buyNumber];
        if([self.specName isEqual:[NSNull null]] || [self.specName isEqualToString:@""]){
            self.specLabel.text = @"";
        }else{
            self.specLabel.text = [NSString stringWithFormat:@"{%@}", self.specName];
        }
        
        [_imgView sd_setImageWithURL:WZWURLWithString(dic[@"goods_image_url"][0]) placeholderImage:ZHANWEI];
        _titleLabel.text = dic[@"goods_name"];
        if ([dic[@"goods_spec"] count] == 0 || [dic[@"goods_spec"] isEqual:[NSNull null]]) {
            _priceLabel.text = [NSString stringWithFormat:@"¥%ld", [dic[@"goods_price"] integerValue] * [_buyNumber integerValue]];
        }else{
            _priceLabel.text = [NSString stringWithFormat:@"¥%ld", [dic[@"goods_spec"][_choosePage][@"goods_price"] integerValue] * [_buyNumber integerValue]];
        }
    }
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
