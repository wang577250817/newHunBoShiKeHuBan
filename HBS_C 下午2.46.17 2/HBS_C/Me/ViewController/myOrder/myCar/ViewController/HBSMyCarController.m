//
//  HBSMyCarController.m
//  HBS_C
//
//  Created by 王 世江 on 16/11/10.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSMyCarController.h"
#import "HBSMyCarCell.h"
#import "HBSMyCarModel.h"
#import "HBSMyCarHeaderModel.h"
#import "HBSShoppingCarHeadView.h"
#import "HBSMyCarBottomModel.h"
#import "HBSShoppingCarBottomView.h"
@interface HBSMyCarController ()<UITableViewDelegate, UITableViewDataSource, HBSShoppingCarBottomViewDelegate, HBSShoppingCarHeaderViewDelegate, ShoppingCellDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *leftImage;
@property (nonatomic, strong) UITableView *myCarTableView;
@property (nonatomic, strong) NSMutableArray *myCarArr;//接goods数组
@property (nonatomic, strong) NSMutableArray *carLists;//接result数组
//头部视图数组模型
@property (nonatomic, strong) NSMutableArray *groupArrs;
//全选所有商品按钮
@property (nonatomic, strong) UIButton *allselectBtn;
@property (nonatomic, strong) HBSMyCarBottomModel *bottomModel;
//全选按钮
@property(nonatomic,assign) BOOL isallSel;
@property (nonatomic, strong) NSString *goodRec_id;

@property (nonatomic, strong) NSMutableArray *datas;
@end
@implementation HBSMyCarController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BAISE;
    self.bottomModel = [[HBSMyCarBottomModel alloc]init];
    [self setUpChildControls];
}
#pragma mark----设置子控件
- (void)setUpChildControls{
    //返回箭头
    UITapGestureRecognizer *tapImage = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImage)];
    [self.leftImage addGestureRecognizer:tapImage];
    //商品订单详情tableView
    self.myCarTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 66, WIDTH, HEIGHT - 111) style:UITableViewStylePlain];
    self.myCarTableView.backgroundColor = HBSColor(244, 244, 243);
    self.myCarTableView.separatorStyle = UITableViewCellAccessoryNone;
    //右侧指示器
    self.myCarTableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.myCarTableView.delegate = self;
    self.myCarTableView.dataSource = self;
    self.myCarTableView.rowHeight = 168;
    [self.view addSubview:self.myCarTableView];
}
#pragma mark----获取数据
- (NSMutableArray *)carLists{
    
    if (_carLists == nil) {
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"id"] = user_id_find;
        params[@"token"] = @"123456";
        if ([self checkWIFI]) {
            [self showLoadingViewWithMessage];
            [HBSNetWork getUrl:[NSString stringWithFormat:@"%@cart/%@", HBSNetAdress, params[@"id"]] paramaters:params header:nil cookie:nil Result:^(id result) {
                if ([result[@"code"]integerValue] == 200) {
                    _carLists = result[@"result"];
                    HBSLog(@"我的购物车%@", result[@"result"][0][@"goods"]);
                    NSMutableArray *modelArrs = [NSMutableArray array];
                    for (NSDictionary *dict in _carLists) {
                        
                        NSMutableArray *modelArr = [HBSMyCarModel mj_objectArrayWithKeyValuesArray:dict[@"goods"]];
                        [modelArrs addObject:modelArr];
                    }
                    self.myCarArr = modelArrs;
                    NSMutableArray *groupArrs = [HBSMyCarHeaderModel mj_objectArrayWithKeyValuesArray:self.carLists];
                    self.groupArrs = groupArrs;
                    [self.myCarTableView reloadData];
                    [self removeLodingView];
                }else if ([result[@"code"]integerValue] == 204){
                    
                    UIImageView *backImage = [[UIImageView alloc]init];
                    [backImage setImage:[UIImage imageNamed:@"img_goueucheweikong"]];
                    backImage.frame = CGRectMake(0, 0, WIDTH, HEIGHT-110);
                    [self.view addSubview:backImage];
                }
                
            }];
            
        }
    }
    return _carLists;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSDictionary *dict = self.carLists[section];
    self.datas = [HBSMyCarModel mj_objectArrayWithKeyValuesArray:dict[@"goods"]];
    return self.datas.count;
        
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.carLists.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HBSMyCarCell *cell = [HBSMyCarCell cellWithTableView:tableView];
    cell.myCarModel = self.myCarArr[indexPath.section][indexPath.row];
    self.goodRec_id = cell.myCarModel.rec_id;
    cell.delegate = self;
    return cell;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    [self setupBottomView];
    CGRect frame = CGRectMake(0, 0, WIDTH, 45);
    HBSMyCarHeaderModel *headModel = self.groupArrs[section];
    HBSShoppingCarHeadView *headView = [[HBSShoppingCarHeadView alloc]initWithFrame:frame WithSection:section HeadModel:headModel];
    headView.backgroundColor = HBSRandomColor;
    headView.delegate = self;
    return headView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 45;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *footer = [[UIView alloc]init];
    footer.backgroundColor = HBSColor(229, 229, 229);
    return footer;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 5;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
}
#pragma mark----编辑
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
//    [self alertWithTitle:@"亲* 您确定要删除吗?" message:nil sure:^{
//
//            NSMutableDictionary *params = [NSMutableDictionary dictionary];
//            params[@"id"] = user_id_find;
//            params[@"token"] = @"123456";
//            params[@"rec_ids"] = self.goodRec_id;
//        
//            if ([self checkWIFI]) {
//                [self showLoadingViewWithMessage];
//                [HBSNetWork deleteUrl:[NSString stringWithFormat:@"%@cart/%@?token=%@&rec_ids=%@",HBSNetAdress, params[@"id"], params[@"token"], params[@"rec_ids"]] parame:params cookie:nil result:^(id result) {
//                    if ([result[@"code"]integerValue] == 200) {
//                        HBSLog(@"删的什么玩意%@", self.goodRec_id);
//                        [self removeLodingView];
//                    }
//                }];
//                
//            }
//        HBSMyCarModel *shop = [self.carLists objectAtIndex:indexPath.section];
//
        [self.datas removeObjectAtIndex:indexPath.row];
//        删除
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//
//        //如果删除的时候数据紊乱,可延迟0.5s刷新一下
//    } cancel:^{
//    }];
        
       
    }
    
}
#pragma mark----删除
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return @" 删除 ";
}
#pragma mark----实现头部视图的代理方法
- (void)HBSShoppingCarHeaderViewDelegate:(UIButton *)btn WithHeadView:(HBSShoppingCarHeadView *)view{
    btn.selected =!btn.selected;
    NSUInteger indexpath = btn.tag - 1000;
    HBSMyCarHeaderModel *headModel = self.groupArrs[indexpath];
    NSArray *allSelectArr = self.myCarArr[indexpath];
    if (btn.selected) {
        for (HBSMyCarModel *model in allSelectArr) {
            
            model.isSelect = YES;
            headModel.isSelect = YES;
            
        }
    }else{
        
        for (HBSMyCarModel *model in allSelectArr) {
            
            model.isSelect = NO;
            headModel.isSelect = NO;
        }
        
    }
    [self isallSelectAllPrice];
    [self.myCarTableView reloadData];
}
#pragma mark----中间cell的处理
/**
 *  cell的代理方法
 *  @param cell     cell可以拿到indexpath
 *  @param selectBt 选中按钮
 */
- (void)ShoppingCellDelegate:(HBSMyCarCell *)cell WithSelectButton:(UIButton *)selectBt{
    NSIndexPath *indexPath = [self.myCarTableView indexPathForCell:cell];
    HBSMyCarModel *model = self.myCarArr[indexPath.section][indexPath.row];
    NSArray *arr = self.myCarArr[indexPath.section];
    model.isSelect =!selectBt.selected;
    int counts = 1;
    for (HBSMyCarModel *modelArr in arr) {
        
        if (modelArr.isSelect) {
            counts ++;
        }
    }
    HBSMyCarHeaderModel *headerModel = self.groupArrs[indexPath.section];
    if (counts == arr.count) {
        
        headerModel.isSelect = YES;
        
    }else{
        
        headerModel.isSelect = NO;
        self.allselectBtn.selected = NO;
    }
    [self isallSelectAllPrice];
    [self.myCarTableView reloadData];
    
}
/**
 *  cell的代理方法
 *  @param cell    cell可以拿到indexpath
 *  @param countBt 加减按钮
 */
- (void)ShoppingCellDelegateForGoodsCount:(HBSMyCarCell *)cell WithCountButton:(UIButton *)countBt{
    
    NSIndexPath *indexPath = [self.myCarTableView indexPathForCell:cell];
    HBSMyCarModel *model = self.myCarArr[indexPath.section][indexPath.row];
    //判断是加号还是减号按钮  addBtn的tag是1
    if (countBt.tag == 1) {
        
        if (model.goods_quantity.intValue >=99999) {
            
            countBt.enabled = NO;
            
        }else{
            
            countBt.enabled = YES;
            cell.reduceBtn.enabled = YES;
            model.goods_quantity = [NSString stringWithFormat:@"%d",model.goods_quantity.intValue + 1];
        }
    }else{
        
        if (model.goods_quantity.intValue == 1) {
            
            countBt.enabled = NO;
        }else{
            
            cell.addBtn.enabled = YES;
            countBt.enabled = YES;
            model.goods_quantity = [NSString stringWithFormat:@"%d",model.goods_quantity.intValue - 1];
        }
    }
    
    [self.myCarTableView reloadData];
}
#pragma mark----遍历所有是否全选
- (void)isallSelectAllPrice{
    for (NSArray *arr in self.myCarArr) {
        for (HBSMyCarModel *model in arr) {
            if (!model.isSelect) {
                self.bottomModel.isSelect = NO;
                return;
            }else{
                self.bottomModel.isSelect = YES;
            }
        }
    }
}
#pragma mark----创建底部视图
- (void)setupBottomView{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.allselectBtn = btn;
    HBSShoppingCarBottomView *bottomView = [[HBSShoppingCarBottomView alloc]initWithFrame:CGRectMake(0, HEIGHT - 50, WIDTH, 50) With:self.bottomModel];
    bottomView.delegate = self;
    bottomView.backgroundColor = BAISE;
    [self.view addSubview:bottomView];
    //调用总价格
    [self imputedAllPrice];
}
#pragma mark----底部的全选和取消
- (void)HBSShoppingCarBottomViewDelegate:(UIButton *)allselBtn{
    
    allselBtn.selected =!allselBtn.selected;
    self.bottomModel.isSelect = allselBtn.selected;
    if (allselBtn.selected) {
        
        self.isallSel = YES;
    }else{
        
        self.isallSel = NO;
    }
    //逻辑
    if (self.isallSel) {
        for (NSArray *arr in self.myCarArr) {
            
            for (HBSMyCarModel *model in arr) {
                
                model.isSelect = YES;
            }
        }
        for (HBSMyCarHeaderModel *headModel in self.groupArrs) {
            
            headModel.isSelect = YES;
        }
    }else{
        for (NSArray *arr in self.myCarArr) {
            
            for (HBSMyCarModel *model in arr) {
                
                model.isSelect = NO;
                
            }
        }
        for (HBSMyCarHeaderModel *headModel in self.groupArrs) {
            
            headModel.isSelect = NO;
        }
    }
    
    [self.myCarTableView reloadData];
    
}
#pragma mark---计算总价格
- (void)imputedAllPrice{
    int allPrice = 0;
    int allCount = 0;
    for (NSArray *goodsArr in self.myCarArr) {
        for (HBSMyCarModel *goodsModel in goodsArr) {
            
            if (goodsModel.isSelect == YES) {
                
                int price = goodsModel.goods_quantity.intValue *goodsModel.goods_price.intValue;
                int count = goodsModel.goods_quantity.intValue;
                
                allCount = count + allCount;
                allPrice = price + allPrice;
                
            }
            
        }
        NSString *priceText = [NSString stringWithFormat:@"总价 :%d元", allPrice];
        self.bottomModel.priceText = priceText;
        self.bottomModel.counts = allCount;
//        HBSLog(@"总价计算完成=%@", self.bottomModel.priceText);
//        HBSLog(@"总件数%d", self.bottomModel.counts);
    }
    
}
#pragma mark----防止头部视图停止在低端以及下拉图片放大的方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 45;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        
    }
}
#pragma mark----箭头image返回方法
- (void)clickImage{
    [self.navigationController popViewControllerAnimated:YES];
    [self.tabBarController.tabBar setHidden:NO];
}
@end
