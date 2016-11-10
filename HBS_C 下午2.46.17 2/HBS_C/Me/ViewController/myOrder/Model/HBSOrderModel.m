//
//  HBSOrderModel.m
//  HBS_C
//
//  Created by 王 世江 on 16/11/4.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSOrderModel.h"

@implementation HBSOrderModel

- (CGFloat)cellHeight{
   
    if (_cellHeight)return _cellHeight;
    //1.头部的高度
    _cellHeight = 43;
    //2.中间高度
    if ([self.order_type isEqualToString:@"service"]) {
        
        self.contentF = CGRectMake(10, _cellHeight, WIDTH - 2 * 10, 106);
        _cellHeight += 106;
        
    }else if ([self.order_type isEqualToString:@"product"]){
        
        self.contentG = CGRectMake(20, _cellHeight, WIDTH - 2 * 10 , 120 *self.goods_num);
        _cellHeight += 120 * self.goods_num;
        
    }else{
        HBSLog(@"其他");
    }
    //3.底部高度
    if ([self.order_status isEqualToString:@"等待买家付款"] || [self.order_status isEqualToString:@"等待服务"] || [self.order_status isEqualToString:@"交易成功"] || [self.order_status isEqualToString:@"待发货"] || [self.order_status isEqualToString:@"已发货"] || [self.order_status isEqualToString:@"待收货"]) {
        _cellHeight += 97;
    }else{
    
     _cellHeight += 97 - 55;
    }
    return _cellHeight;
}
@end
