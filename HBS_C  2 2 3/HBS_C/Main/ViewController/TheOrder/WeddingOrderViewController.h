//
//  WeddingOrderViewController.h
//  HBS_C
//
//  Created by wangzuowen on 16/11/1.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "BaseViewController.h"


@interface WeddingOrderViewController : BaseViewController

@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, copy)NSString *buyNumber;
@property (nonatomic, copy)NSString *specStr;
@property (nonatomic, copy)NSString *specId;
@property (nonatomic, assign)NSInteger chossePage;
@property (nonatomic, assign)BOOL isCar;

@property (nonatomic, strong)NSMutableArray *headerArr;

@end
