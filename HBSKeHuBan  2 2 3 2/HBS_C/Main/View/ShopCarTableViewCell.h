//
//  ShopCarTableViewCell.h
//  HBS_C
//
//  Created by wangzuowen on 16/10/21.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^NUMBLOCK)(NSInteger tt);

@interface ShopCarTableViewCell : UITableViewCell

@property (nonatomic, strong)UIButton *roundButton;
@property (nonatomic, strong)UIButton *okButton;

@property (nonatomic, strong)NSMutableDictionary *dic;
@property (nonatomic, copy)NUMBLOCK block;
@property (nonatomic, copy)NUMBLOCK blockNum;

@end
