//
//  HBSEditViewController.h
//  HBS_C
//
//  Created by 王 世江 on 16/10/26.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "BaseViewController.h"
#define PROVINCE_COMPONENT  0
#define CITY_COMPONENT      1
#define DISTRICT_COMPONENT  2
@interface HBSEditViewController : BaseViewController<UIPickerViewDelegate, UIPickerViewDataSource>{
    
    UIPickerView *picker11;
    NSDictionary *areaDic;
    NSArray *province;
    NSArray *city;
    NSArray *district;
    NSString *selectedProvince;
}

@property (nonatomic, strong) NSMutableDictionary *getEditDic;

@end
