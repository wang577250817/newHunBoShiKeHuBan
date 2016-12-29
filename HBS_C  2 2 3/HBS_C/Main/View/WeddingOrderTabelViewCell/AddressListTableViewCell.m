//
//  AddressListTableViewCell.m
//  HBS_C
//
//  Created by wangzuowen on 16/11/7.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "AddressListTableViewCell.h"

@interface AddressListTableViewCell()


@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UILabel *adressLabel;

@property (nonatomic, strong)UILabel *Linelabel;

@end
@implementation AddressListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _roundImage = [UIButton buttonWithType:UIButtonTypeCustom];
        [_roundImage setImage:[UIImage imageNamed:@"icon_hun@2x"] forState:UIControlStateNormal];
        [_roundImage setImage:[UIImage imageNamed:@"icon_1_2_xuanzhonghong"] forState:UIControlStateSelected];
        [self.contentView addSubview:_roundImage];
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = HEISE;
        _nameLabel.font = FONT(14);
//        _nameLabel.backgroundColor = WZWmagentaColor;
        [self.contentView addSubview:_nameLabel];
        
        _adressLabel = [[UILabel alloc] init];
        _adressLabel.numberOfLines = 0;
        _adressLabel.textColor = HEISE;
        _adressLabel.font = FONT(14);
//        _adressLabel.backgroundColor = WZWorangeColor;
        [self.contentView addSubview:_adressLabel];
        
        _rightImage = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightImage setImage:[UIImage imageNamed:@"icon_1_2_3_bianji@2x"] forState:UIControlStateNormal];
        [self.contentView addSubview:_rightImage];
        
//        _Linelabel = [[UILabel alloc] init];
//        _Linelabel.backgroundColor = BEIJINGSE;
//        [self.contentView addSubview:_Linelabel];
        
        [self setUp_UI];
    }
    return self;
}

- (void)setUp_UI
{
    _roundImage.frame = CGRectMake(10, 28, 18, 18);
    _nameLabel.frame = CGRectMake(_roundImage.width + 10 + 10, 15, WIDTH - 28 - 25 - 22 - 10, 20);
    _adressLabel.frame = CGRectMake(_roundImage.width + 10 + 10, _nameLabel.y + _nameLabel.height + 15, WIDTH - 28 - 25 - 22 - 10, 40);
    _rightImage.frame = CGRectMake(WIDTH - 40, 20, 50, 50);
//    _Linelabel.frame = CGRectMake(0, _adressLabel.y + _adressLabel.height + 10, WIDTH, 5);
}
- (void)setModel:(MainModel *)model
{
    _model = model;
    
    _nameLabel.text = [NSString stringWithFormat:@"收货人:%@    %@", model.consignee, model.phone_mob];
    _adressLabel.text = [NSString stringWithFormat:@"收货地址:%@%@", model.region_name, model.address];
    if ([model.def_recive isEqualToString:@"1"]) {
        self.roundImage.selected = YES;
    }else{
        self.roundImage.selected = NO;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

@end
