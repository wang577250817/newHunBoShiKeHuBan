//
//  ShopDetailCaseTableViewCell.m
//  
//
//  Created by wangzuowen on 16/10/31.
//
//

#import "ShopDetailCaseTableViewCell.h"

@interface ShopDetailCaseTableViewCell()

@property (nonatomic, strong)UIImageView *caseImageView;
@property (nonatomic, strong)UILabel *titleLabel;

@end

@implementation ShopDetailCaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.caseImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_caseImageView];
        
        self.titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = WZWwhiteColor;
        _titleLabel.font = FONT(14);
        [self.contentView addSubview:self.titleLabel];
        
//        self.caseImageView.backgroundColor = WZWgrayColor;
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.caseImageView.frame = CGRectMake(10, 10, WIDTH - 20, 200 * HSHIPEI);
    self.titleLabel.frame = CGRectMake(10, 180 * HSHIPEI, WIDTH - 20, 20);
}
- (void)setDataDic:(NSDictionary *)dataDic
{
    if (_dataDic != dataDic) {
        _dataDic = dataDic;
    }
    [self.caseImageView sd_setImageWithURL:WZWURLWithString(dataDic[@"cases_image"]) placeholderImage:ZHANWEI];
    self.titleLabel.text = dataDic[@"cases_name"];
}
- (void)setModel:(ShopCityModel *)model
{
    _model = model;
    [self.caseImageView sd_setImageWithURL:WZWURLWithString(model.goods_image) placeholderImage:ZHANWEI];
    self.titleLabel.text = model.goods_name;
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
