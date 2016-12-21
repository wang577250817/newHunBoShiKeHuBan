//
//  ButlerListTableViewCell.m
//  HBS_C
//
//  Created by wangzuowen on 16/10/21.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "ButlerListTableViewCell.h"

@interface ButlerListTableViewCell()

@property (nonatomic, strong) UIImageView *roundImage;//头像image
@property (nonatomic, strong) UILabel *titleLabel;//标题label
@property (nonatomic, strong) UILabel *commentCountLabel;//评论数量label
@property (nonatomic, strong) UILabel *fansCountLabel;//粉丝数量label
@property (nonatomic, strong) UIImageView *image1;//图1
@property (nonatomic, strong) UIImageView *image2;//图2
@property (nonatomic, strong) UIImageView *image3;//图3
@property (nonatomic, strong) UILabel *contentLabel;//内容label
@property (nonatomic, strong) UILabel *grayLabel;//灰色label

@property (nonatomic, strong) NSMutableArray *mArr;

@end
@implementation ButlerListTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.roundImage = [[UIImageView alloc]init];
        [self.roundImage setImage:[UIImage imageNamed:@"logo_512"]];
        self.roundImage.layer.cornerRadius = 25;
        self.roundImage.layer.masksToBounds = YES;
        [self.contentView addSubview:self.roundImage];
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.text = @"绍兴婚博士";
        self.titleLabel.textColor = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        //        self.titleLabel.backgroundColor = FENSE;
        [self.contentView addSubview:self.titleLabel];
        
        self.commentCountLabel = [[UILabel alloc]init];
        self.commentCountLabel.text = @"1230";
        self.commentCountLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        //        self.commentCountLabel.backgroundColor = FENSE;
        self.commentCountLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.commentCountLabel];
        
        self.fansCountLabel = [[UILabel alloc]init];
        self.fansCountLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    
        self.fansCountLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.fansCountLabel];
        
        self.image1 = [[UIImageView alloc]init];
        [self.contentView addSubview:self.image1];
        
        self.image2 = [[UIImageView alloc]init];
        [self.contentView addSubview:self.image2];
        
        self.image3 = [[UIImageView alloc]init];
        [self.contentView addSubview:self.image3];
        
        self.contentLabel = [[UILabel alloc]init];
        self.contentLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        self.contentLabel.text = @"";
        self.contentLabel.font = [UIFont systemFontOfSize:13];
        //        self.contentLabel.backgroundColor = FENSE;
        self.contentLabel.numberOfLines = 0;
        [self.contentView addSubview:self.contentLabel];
        
        self.grayLabel = [[UILabel alloc]init];
        self.grayLabel.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:243/255.0 alpha:1.0];
        [self.contentView addSubview:self.grayLabel];
    }
    
    return self;
}
#pragma mark----布局
- (void)layoutSubviews{
    
    [super layoutSubviews];
    [self.roundImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.roundImage.mas_right).offset(12);
        make.top.mas_equalTo(self.roundImage.mas_top);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
    CGFloat ff = [TextAdapter WidthtWithText:[NSString stringWithFormat:@"粉丝de%@", self.model.store_collects] height:20 font:12];
    
    [self.fansCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(ff, 20));
        
    }];
    CGFloat cf = [TextAdapter WidthtWithText:[NSString stringWithFormat:@"粉丝de%@", self.model.store_comment] height:20 font:12];
    [self.commentCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.fansCountLabel.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(cf, 20));
        
    }];
    [self.image1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.contentView).offset(10);
        make.top.mas_equalTo(self.roundImage).offset(63);
        make.size.mas_equalTo(CGSizeMake(self.contentView.frame.size.width / 3 - 10, 64));
        
    }];
    
    [self.image2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.contentView).offset(self.contentView.frame.size.width / 3 + 8);
        make.top.mas_equalTo(self.roundImage).offset(63);
        make.size.mas_equalTo(CGSizeMake(self.contentView.frame.size.width / 3 - 10, 64));
    }];
    
    [self.image3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.contentView).offset(self.contentView.frame.size.width / 3 *2 +6);
        make.top.mas_equalTo(self.roundImage).offset(63);
        make.size.mas_equalTo(CGSizeMake(self.contentView.frame.size.width / 3 - 16, 64));
    }];
    
    if (_model.store_images.count == 0) {
        self.image1.hidden = YES;
        self.image2.hidden = YES;
        self.image3.hidden = YES;
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(self.contentView.mas_bottom).offset(-75);
            make.size.mas_equalTo(CGSizeMake(self.contentView.frame.size.width - 20, 60));
        }];
        
    }else{
        self.image1.hidden = NO;
        self.image2.hidden = NO;
        self.image3.hidden = NO;
        
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(self.contentView).offset(10);
            make.top.mas_equalTo(self.contentView.mas_bottom).offset(-75);
            make.size.mas_equalTo(CGSizeMake(self.contentView.frame.size.width - 20, 60));
        }];
    }
    
    [self.grayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(self.contentView.mas_bottom).offset(-5);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 5));
        
    }];
    
}

- (void)setModel:(MainModel *)model
{
    if (_model != model) {
        _model = model;
    }
    [self.roundImage sd_setImageWithURL:WZWURLWithString(model.store_logo) placeholderImage:ZHANWEI];
    self.titleLabel.text = model.store_name;
    self.commentCountLabel.text = [NSString stringWithFormat:@"评论 %@", model.store_comment];
    self.fansCountLabel.text = [NSString stringWithFormat:@"粉丝 %@", model.store_collects];
    self.contentLabel.text = model.store_description;
    
    switch (model.store_images.count) {
        case 0:
            break;
        case 1:
            [_image1 sd_setImageWithURL:WZWURLWithString(model.store_images[0][@"img"]) placeholderImage:ZHANWEI];
            break;
        case 2:
            [_image1 sd_setImageWithURL:WZWURLWithString(model.store_images[0][@"img"]) placeholderImage:ZHANWEI];
            [_image2 sd_setImageWithURL:WZWURLWithString(model.store_images[1][@"img"]) placeholderImage:ZHANWEI];
            break;
        case 3:
            [_image1 sd_setImageWithURL:WZWURLWithString(model.store_images[0][@"img"]) placeholderImage:ZHANWEI];
            [_image2 sd_setImageWithURL:WZWURLWithString(model.store_images[1][@"img"]) placeholderImage:ZHANWEI];
            [_image3 sd_setImageWithURL:WZWURLWithString(model.store_images[2][@"img"]) placeholderImage:ZHANWEI];
            break;
        default:
            [_image1 sd_setImageWithURL:WZWURLWithString(model.store_images[0][@"img"]) placeholderImage:ZHANWEI];
            [_image2 sd_setImageWithURL:WZWURLWithString(model.store_images[1][@"img"]) placeholderImage:ZHANWEI];
            [_image3 sd_setImageWithURL:WZWURLWithString(model.store_images[2][@"img"]) placeholderImage:ZHANWEI];
            break;
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
