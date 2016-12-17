//
//  NewAddressViewController.h
//  HBS_C
//
//  Created by wangzuowen on 16/11/7.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "BaseViewController.h"
#import "MainModel.h"

#define PROVINCE_COMPONENT  0
#define CITY_COMPONENT      1
#define DISTRICT_COMPONENT  2
@interface NewAddressViewController : BaseViewController<UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong)MainModel *model;
@property (nonatomic, assign)BOOL isOne;

@end
