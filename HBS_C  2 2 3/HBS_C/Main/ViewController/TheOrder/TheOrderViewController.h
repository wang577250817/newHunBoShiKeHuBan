//
//  TheOrderViewController.h
//  HBS_C
//
//  Created by wangzuowen on 16/10/28.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "BaseViewController.h"

@interface TheOrderViewController : BaseViewController

@property (nonatomic, strong)NSDictionary *dataDic;
@property (nonatomic, copy)NSString *specStr;
@property (nonatomic, copy)NSString *specId;
@property (nonatomic, copy)NSString *buyNum;
@property (nonatomic, assign)NSInteger choosePage;

@end
