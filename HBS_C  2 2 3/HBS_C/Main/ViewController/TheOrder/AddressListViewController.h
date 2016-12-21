//
//  AddressListViewController.h
//  HBS_C
//
//  Created by wangzuowen on 16/11/7.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "BaseViewController.h"
#import "MainModel.h"

typedef void(^ADDRESSBLOCK)(MainModel *model);
@interface AddressListViewController : BaseViewController

@property (nonatomic, copy)ADDRESSBLOCK block;
@property (nonatomic, assign)BOOL isOrder;

@end
