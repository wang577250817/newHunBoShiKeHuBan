//
//  HBSMyCarCell.h
//  HBS_C
//
//  Created by 王 世江 on 16/11/10.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HBSMyCarModel;
@class HBSMyCarCell;

@protocol ShoppingCellDelegate <NSObject>

/**
 *  cell关于选中的代理方法
 *
 *  @param cell     cell
 *  @param selectBt cell左边选中按钮
 */
- (void)ShoppingCellDelegate:(HBSMyCarCell *)cell WithSelectButton:(UIButton *)selectBt;
/**
 *  cell关于数量编辑的代理方法
 *
 *  @param cell    cell
 *  @param countBt cell加减数量按钮
 */
- (void)ShoppingCellDelegateForGoodsCount:(HBSMyCarCell *)cell WithCountButton:(UIButton *)countBt;

@end



@interface HBSMyCarCell : UITableViewCell

@property (nonatomic, strong) HBSMyCarModel *myCarModel;
//商品已选数量
@property (nonatomic, assign) NSInteger chooseCount;
//cell的代理对象
@property (nonatomic, assign)id<ShoppingCellDelegate>delegate;

//添加按钮
@property (nonatomic, strong) UIButton *addBtn;
//减少按钮
@property (nonatomic, strong) UIButton *reduceBtn;
@property (nonatomic, strong) UITextField *numbersTf;//显示数量

+ (instancetype)cellWithTableView:(UITableView *)tableView;




@end
