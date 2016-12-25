//
//  WeddingOrderTableViewCell.h
//  HBS_C
//
//  Created by wangzuowen on 16/11/3.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^NUMBLOCK)(NSInteger tt);

@interface WeddingOrderTableViewCell : UITableViewCell

@property (nonatomic, strong)NSMutableDictionary *dic;
@property (nonatomic, copy)NSString *buyNumber;
@property (nonatomic, copy)NSString *specName;
@property (nonatomic, assign)NSInteger choosePage;
@property (nonatomic, copy)NUMBLOCK block;
@property (nonatomic, assign)BOOL isCar;

@end
