//
//  WeddingDetailViewController.m
//  HBS_C
//
//  Created by wangzuowen on 16/10/26.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "WeddingDetailViewController.h"
#import "ChangePhotos.h"
#import "MainModel.h"
#import <WebKit/WebKit.h>
#import "WeddingDetailOneTableViewCell.h"
#import "WeddingDetailTwoTableViewCell.h"
#import "WeddingDetailThreeTableViewCell.h"
#import "WeddingDetailFourTableViewCell.h"
#import "ChoseView.h"
#import "TheOrderViewController.h"
#import "WeddingOrderViewController.h"
#import "ShopDetailViewController.h"

@interface WeddingDetailViewController ()<UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate, UITextFieldDelegate,TypeSeleteDelegete>
{
    ChoseView *choseView;
    UIView *bgview;
    CGPoint center;
    NSMutableArray *sizearr;//型号数组
    NSDictionary *stockarr;//商品库存量
    int goodsStock;
    int isCarOrBuy; //买还是购物车
    BOOL creatChose; //是否初始化规格视图
    BOOL isSpec;     //是否有规格
    BOOL weizhi;
    CGFloat webHeight;
}
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)NSMutableArray *guigeArr;
@property (nonatomic, strong)NSMutableDictionary *dataDic;
@property (nonatomic, strong)UIWebView *webView;

@property (nonatomic, strong)UIButton *backButton;

@property (nonatomic, strong)ChangePhotos *changePhotos;

@end

@implementation WeddingDetailViewController

- (void)dealloc
{
    self.tableView.delegate = nil;
//    self.webView.navigationDelegate = nil;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor blackColor];
    self.dataArr = [NSMutableArray array];
    self.dataDic = [NSMutableDictionary dictionary];
    
    
    [self creatHeader];
    [self crreatWebView];
    [self netWoring];
    creatChose = YES;
    weizhi = YES;
    
    sizearr = [NSMutableArray array];
    _guigeArr = [NSMutableArray array];
    
}

- (void)netWoring
{
    
    if ([self checkWIFI]) {
        [self showLoadingViewWithMessage];
        [HBSNetWork getUrl:[NSString stringWithFormat:@"%@goods/%@", HBSNetAdress, self.goods_id] paramaters:nil header:@"daichengxiang" cookie:nil Result:^(id result) {
            if ([result[@"code"] integerValue] == 200) {
                _tableView.hidden = NO;
                _tableView.userInteractionEnabled = YES;
                _dataArr = [MainModel transformWithArray:result[@"result"][@"goods_rec"]];
                _dataDic = result[@"result"];
                _changePhotos.dataArr = self.dataDic[@"goods_image_url"];
                for (NSDictionary *dic in result[@"result"][@"goods_spec"]) {
                    [sizearr addObject:dic[@"goods_spec_1"]];
                }
                if ([self.dataDic[@"goods_spec"] count] == 0) {
                    isSpec = NO;
                }else{
                    _guigeArr = result[@"result"][@"goods_spec"];
                    isSpec = YES;
                }
                
                [_tableView reloadData];
                
            }else{
                _tableView.hidden = YES;
                [self creatAlertViewOne:@"提示" message:result[@"message"] sureStr:@"确定" sureAction:^(id result) {
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            }
            [self removeLodingView];
        }];
    }else{
        _tableView.hidden = YES;
        self.tableView.userInteractionEnabled = NO;
        [self noNetWorkView:self.view];
        self.errorImage.userInteractionEnabled = YES;
        __weak typeof(self)weakself = self;
        self.freshBlock = ^(void){
            [weakself netWoring];
        };
    }
}
- (void)creatHeader
{
    _changePhotos = [[ChangePhotos alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 300 * HSHIPEI)];
    [self.changePhotos didnotSelect];
    self.tableView.tableHeaderView = _changePhotos;
}
#pragma mark -  webVIew
- (UITableView *)tableView
{
    if (!_tableView) {
        bgview = [[UIView alloc] initWithFrame:self.view.bounds];
        bgview.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:bgview];
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT- 49 * HSHIPEI) style:UITableViewStyleGrouped];
        tableView.backgroundColor = BEIJINGSE;
        tableView.sectionFooterHeight = 0.01f;
        tableView.delegate = self;
        tableView.dataSource = self;
        [bgview addSubview:tableView];
        
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.frame = CGRectMake(10, 32, 28, 28);
        [_backButton setImage:[UIImage imageNamed:@"icon_1_2_fanhui(youdi)@2x"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        [bgview addSubview:_backButton];
        
        UIView *footerView = ViewAlloc(0, HEIGHT - 49 * HSHIPEI, WIDTH, 49 * HSHIPEI);
        [bgview addSubview:footerView];
        
        UILabel *toplabel = LabelAlloc(0, 0, WIDTH, 1);
        toplabel.backgroundColor = ererjiuColor;
        [footerView addSubview:toplabel];
        
        if (self.type == DetailTypeCase) {
            UIButton *talkButton = [UIButton buttonWithType:UIButtonTypeCustom];
            talkButton.frame = CGRectMake(0, 0, WIDTH / 2, 49 * HSHIPEI);
            [talkButton addTarget:self action:@selector(talkAction) forControlEvents:UIControlEventTouchUpInside];
            [talkButton setImage:[UIImage imageNamed:@"button_1_2_hetaliao@2x"] forState:UIControlStateNormal];
            [footerView addSubview:talkButton];
            
            UIButton *phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
            phoneButton.frame = CGRectMake(WIDTH / 2, 0, WIDTH / 2, 49 * HSHIPEI);
            [phoneButton addTarget:self action:@selector(phoneAction) forControlEvents:UIControlEventTouchUpInside];
            [phoneButton setImage:[UIImage imageNamed:@"button_1_2_dianhuazhixun@2x"] forState:UIControlStateNormal];
            [footerView addSubview:phoneButton];
        }else if(self.type == DetailTypeWedding){
            UIButton *talkButton = [UIButton buttonWithType:UIButtonTypeCustom];
            talkButton.frame = CGRectMake(0, 0, 65 * WSHIPEI, 49 * HSHIPEI);
            [talkButton addTarget:self action:@selector(talkAction) forControlEvents:UIControlEventTouchUpInside];
            [talkButton setImage:[UIImage imageNamed:@"icon_btn_talk@2x"] forState:UIControlStateNormal];
            [footerView addSubview:talkButton];
            
            UIButton *phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
            phoneButton.frame = CGRectMake(65 * WSHIPEI, 0, 66 * WSHIPEI, 49 * HSHIPEI);
            [phoneButton addTarget:self action:@selector(phoneAction) forControlEvents:UIControlEventTouchUpInside];
            [phoneButton setImage:[UIImage imageNamed:@"icon_btn_call@2x"] forState:UIControlStateNormal];
            [footerView addSubview:phoneButton];
            
            UIButton *shopButton = [UIButton buttonWithType:UIButtonTypeCustom];
            shopButton.frame = CGRectMake((65 + 66) * WSHIPEI, 0, 84 * WSHIPEI, 49 * HSHIPEI);
            [shopButton addTarget:self action:@selector(addShopCar) forControlEvents:UIControlEventTouchUpInside];
            [shopButton setImage:[UIImage imageNamed:@"icon_btn_shop@2x"] forState:UIControlStateNormal];
            [footerView addSubview:shopButton];
            
            UIButton *buyNowButton = [UIButton buttonWithType:UIButtonTypeCustom];
            buyNowButton.frame = CGRectMake((65 + 66 + 84) * WSHIPEI, 0, 160 * WSHIPEI, 49 * HSHIPEI);
            [buyNowButton addTarget:self action:@selector(buyNowAction) forControlEvents:UIControlEventTouchUpInside];
            [buyNowButton setImage:[UIImage imageNamed:@"icon_btn_lijigoumai@2x"] forState:UIControlStateNormal];
            [footerView addSubview:buyNowButton];
        }else{//fuwu
            UIButton *talkButton = [UIButton buttonWithType:UIButtonTypeCustom];
            talkButton.frame = CGRectMake(0, 0, 90 * WSHIPEI, 49 * HSHIPEI);
            [talkButton addTarget:self action:@selector(talkAction) forControlEvents:UIControlEventTouchUpInside];
            [talkButton setImage:[UIImage imageNamed:@"icon_1_2_hetaliao(fuwu)@2x"] forState:UIControlStateNormal];
            [footerView addSubview:talkButton];
            
            UIButton *phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
            phoneButton.frame = CGRectMake(90 * WSHIPEI, 0, 125 * WSHIPEI, 49 * HSHIPEI);
            [phoneButton addTarget:self action:@selector(phoneAction) forControlEvents:UIControlEventTouchUpInside];
            [phoneButton setImage:[UIImage imageNamed:@"icon_1_2_dianhuzixun(fuwu)@2x"] forState:UIControlStateNormal];
            [footerView addSubview:phoneButton];
            
            UIButton *buyNowButton = [UIButton buttonWithType:UIButtonTypeCustom];
            buyNowButton.frame = CGRectMake((65 + 66 + 84) * WSHIPEI, 0, 160 * WSHIPEI, 49 * HSHIPEI);
            [buyNowButton addTarget:self action:@selector(buyNowAction) forControlEvents:UIControlEventTouchUpInside];
            [buyNowButton setImage:[UIImage imageNamed:@"icon_btn_lijigoumai@2x"] forState:UIControlStateNormal];
            [footerView addSubview:buyNowButton];
        }
        _tableView = tableView;
    }
    return _tableView;
}
- (void)crreatWebView
{
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    _webView.delegate = self;
    _webView.scrollView.scrollEnabled = NO;
    //预先加载url
    //    NSString *str = self.dataDic[@"goods_ios_descurl"];
    NSString *str = [NSString stringWithFormat:@"%@h5/index.php?app=address&act=d_goods&tp=imagetext&goods_id=%@",HTMLNetAdress, self.goods_id];
    [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:str]]];
    
}
#pragma mark - tableView和脚步视图

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 3) {
        UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        vv.backgroundColor = BEIJINGSE;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, WIDTH - 20, 20)];
        label.text = @"你可能还喜欢";
        label.textColor = yisanliuColor;
        label.font = FONT(16);
        [vv addSubview:label];
        return vv;
    }else{
        UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 5)];
        vv.backgroundColor = BEIJINGSE;
        return vv;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 0.0;
            break;
        case 1:
            return 5.0;
            break;
        case 2:
            return 5.0;
            break;
        case 3:
            return 40.0;
            break;
        default:
            break;
    }
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            if (self.type == DetailTypeWedding || self.type == DetailTypeGoods) {
                return 100.0;
            }else{
                return 60.0;
            }
            break;
        case 1:
            return 70.0;
            break;
        case 2:
            return webHeight + 40;
            
            break;
        case 3:
            return 100;
            break;
        default:
            break;
    }
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 3) {
        return 3;
    }else{
        return 1;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellStr = @"WeddingDetailOneTableViewCell";
    static NSString *cellStr2 = @"WeddingDetailTwoTableViewCell";
    static NSString *cellStr3 = @"WeddingDetailThreeTableViewCell";
    static NSString *cellStr4 = @"WeddingDetailFourTableViewCell";
    if (indexPath.section == 0) {
        WeddingDetailOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
        if (!cell) {
            cell = [[WeddingDetailOneTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellStr];
        }
        cell.dataDic = self.dataDic;
        cell.type = self.type;
        return cell;
    }
    else if(indexPath.section == 1){
        WeddingDetailTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr2];
        if (!cell) {
            cell = [[WeddingDetailTwoTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellStr2];
        }
        tableView.separatorStyle = NO;
        cell.dataDic = self.dataDic;
        return cell;
        
    }
    else if (indexPath.section == 2){
        tableView.separatorStyle = NO;
        WeddingDetailThreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr3];
        if (!cell) {
            cell = [[WeddingDetailThreeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellStr3];
        }
        [cell.bgView addSubview:self.webView];

        cell.weizhi = weizhi;
        [cell.photoButton addTarget:self action:@selector(photoButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [cell.textButton addTarget:self action:@selector(textButtonAction) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    else if(indexPath.section == 3){
        WeddingDetailFourTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr4];
        if (!cell) {
            cell = [[WeddingDetailFourTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellStr4];
        }
        if (self.dataArr.count != 0) {
            
            cell.model = self.dataArr[indexPath.row];
        }
        
        return cell;
    }
    else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"celll"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"celll"];
        }
        return cell;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        ShopDetailViewController *shopVC = [[ShopDetailViewController alloc] init];
        shopVC.story_id = self.dataDic[@"goods_store_id"];
        [self.navigationController pushViewController:shopVC animated:YES];
    }else if (indexPath.section == 3){
        WeddingDetailViewController *weddVC = [[WeddingDetailViewController alloc] init];
        weddVC.type = self.type;
        weddVC.goods_id = [self.dataArr[indexPath.row] rec_goods_id];
        [self.navigationController pushViewController:weddVC animated:YES];
    }
}
#pragma mark - 购物车
/**
 *  初始化弹出视图
 */
-(void)initChoseView
{
    creatChose = NO;
    //选择尺码颜色的视图
    //选择尺码颜色的视图
    choseView = [[ChoseView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:choseView];
    
    if(isSpec == NO){
        choseView.countView.frame = CGRectMake(0, 0, choseView.frame.size.width, 50);
    }else{
        choseView.sizeView = [[TypeView alloc] initWithFrame:CGRectMake(0, 0, choseView.frame.size.width, 50) andDatasource:sizearr :@"规格"];
        choseView.sizeView.delegate = self;
        [choseView.mainscrollview addSubview:choseView.sizeView];
        choseView.sizeView.frame = CGRectMake(0, 0, choseView.frame.size.width, choseView.sizeView.height);
        
        choseView.countView.frame = CGRectMake(0, choseView.sizeView.frame.size.height+choseView.sizeView.frame.origin.y, choseView.frame.size.width, 50);
        
    }
    if (_type == DetailTypeWedding) {
        choseView.stock = [self.dataDic[@"goods_stock"] intValue];
    }else{
        choseView.stock = 1;
    }
    choseView.mainscrollview.contentSize = CGSizeMake(self.view.frame.size.width, choseView.countView.frame.size.height+choseView.countView.frame.origin.y);
    
    [choseView.img sd_setImageWithURL:WZWURLWithString(self.dataDic[@"goods_image_url"][0]) placeholderImage:ZHANWEI];
    
    choseView.lb_price.text = [NSString stringWithFormat:@"¥%@", self.dataDic[@"goods_price"]];
    choseView.lb_stock.text = [NSString stringWithFormat:@"库存%@件", self.dataDic[@"goods_stock"]];
    choseView.lb_detail.text = @"请选择 尺码 颜色分类";
    
    [choseView.bt_cancle addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
    //点击黑色透明视图choseView会消失
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [choseView.alphaiView addGestureRecognizer:tap];
    //点击图片放大图片
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBigImage:)];
    choseView.img.userInteractionEnabled = YES;
    [choseView.img addGestureRecognizer:tap1];
    
    
    [choseView.bt_sure addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - 规格确定Action
- (void)sureAction
{
    
    if (isCarOrBuy == 0) {
        if (isSpec) {
            if (choseView.sizeView.seletIndex == -1) {
                [self creatAlertViewOne:@"请选择规格" message:nil sureStr:@"确定" sureAction:^(id result) {
                }];
            }else{
                 NSDictionary *dic = @{@"id":[ProjectCache getLoginMessage][@"user_id"],@"token":@"c02b68e88c44385f56064ce4cd49b319",@"goods_id":self.dataDic[@"goods_id"],@"spec_id":self.guigeArr[choseView.sizeView.seletIndex][@"goods_spec_id"],@"quantity":choseView.countView.tf_count.text};
                [self addCar:dic];
            }
        }else{
            NSDictionary *dic = @{@"id":[ProjectCache getLoginMessage][@"user_id"],@"token":@"c02b68e88c44385f56064ce4cd49b319",@"goods_id":self.dataDic[@"goods_id"],@"quantity":choseView.countView.tf_count.text};
            [self addCar:dic];
        }
       
        
    }else{
        TheOrderViewController *orderVC = [[TheOrderViewController alloc] init];
        WeddingOrderViewController *webOrder = [[WeddingOrderViewController alloc] init];
        switch (self.type) {
            case DetailTypeWedding:
                webOrder.isCar = NO;
                webOrder.buyNumber = choseView.countView.tf_count.text;
                
                if (isSpec) {
                    if (choseView.sizeView.seletIndex == -1) {
                        [self creatAlertViewOne:@"请选择规格" message:nil sureStr:@"确定" sureAction:^(id result) {
                        }];
                        return;
                    }else{
                        webOrder.specStr = self.guigeArr[choseView.sizeView.seletIndex][@"goods_spec_1"];
                        webOrder.specId = self.guigeArr[choseView.sizeView.seletIndex][@"goods_spec_id"];
                        webOrder.chossePage = choseView.sizeView.seletIndex;
                        
                    }
                }else{
                    webOrder.specStr = @"";
                    webOrder.specId = @"";
                }
                    
                [webOrder.dataArr addObject:self.dataDic];
                [self.navigationController pushViewController:webOrder animated:YES];
                break;
            case DetailTypeGoods:
                orderVC.buyNum = choseView.countView.tf_count.text;
                
                if (isSpec) {
                    if (choseView.sizeView.seletIndex == -1) {
                        [self creatAlertViewOne:@"请选择规格" message:nil sureStr:@"确定" sureAction:^(id result) {
                        }];
                        return;
                    }else{
                        orderVC.specStr = self.guigeArr[choseView.sizeView.seletIndex][@"goods_spec_1"];
                        orderVC.specId = self.guigeArr[choseView.sizeView.seletIndex][@"goods_spec_id"];
                        orderVC.choosePage = choseView.sizeView.seletIndex;
                        
                    }
                }else{
                    webOrder.specStr = @"";
                    webOrder.specId = @"";
                }
                orderVC.dataDic = self.dataDic;
                [self.navigationController pushViewController:orderVC animated:YES];
                break;
            default:
                break;
        }
        [self dismiss];
    }
    
}
- (void)carNetWorking:(NSDictionary *)dic
{
    [HBSNetWork postUrl:[NSString stringWithFormat:@"%@cart", HBSNetAdress] parame:dic header:nil cookie:nil result:^(id result) {
        if ([result[@"code"] integerValue] == 200) {
            _tableView.userInteractionEnabled = YES;
            [self creatAlertWithTimer:@"已加入购物车" fatherView:self.view];
            [self dismiss];
        }
        [self removeLodingView];
    }];
}
- (void)addCar:(NSDictionary *)dic
{
    if ([self checkWIFI]) {
        [self showLoadingViewWithMessage];
        [self carNetWorking:dic];
    }else{
        self.tableView.userInteractionEnabled = NO;
        [self noNetWorkView:self.view];
        self.errorImage.userInteractionEnabled = YES;
        __weak typeof(self)weakself = self;
        self.freshBlock = ^(void){
            [weakself carNetWorking:dic];
        };
    }

}
//  此处嵌入浏览图片代码
-(void)showBigImage:(UITapGestureRecognizer *)tap
{
    NSLog(@"放大图片");
}
//  点击半透明部分或者取消按钮，弹出视图消失
-(void)dismiss
{
    center.y = center.y+self.view.frame.size.height;
    [UIView animateWithDuration: 0.35 animations: ^{
        choseView.frame =CGRectMake(0, HEIGHT, WIDTH, HEIGHT);
        bgview.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
        bgview.center = self.view.center;
        [choseView.countView.tf_count resignFirstResponder];
    } completion: nil];
    
}
#pragma mark-typedelegete 123
-(void)btnindex:(int)tag
{
    //通过seletIndex是否>=0来判断尺码和颜色是否被选择，－1则是未选择状态
    if (choseView.sizeView.seletIndex >=0) {
        //尺码和颜色都选择的时候
        NSString *size = sizearr[choseView.sizeView.seletIndex];
        choseView.lb_price.text = [NSString stringWithFormat:@"¥%@", self.guigeArr[choseView.sizeView.seletIndex][@"goods_price"]];
        choseView.lb_stock.text = [NSString stringWithFormat:@"库存%@件", self.guigeArr[choseView.sizeView.seletIndex][@"goods_spec_stock"]];
        choseView.lb_detail.text = [NSString stringWithFormat:@"已选 \"%@\"",size];
        choseView.stock = [self.guigeArr[choseView.sizeView.seletIndex][@"goods_spec_stock"] intValue];
        
        [self reloadTypeBtn:nil :self.guigeArr :choseView.sizeView];
#pragma mark - 选中的结果
//        choseView.img.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",choseView.colorView.seletIndex+1]];
    }
}
//根据所选的尺码或者颜色对应库存量 确定哪些按钮不可选
-(void)reloadTypeBtn:(NSDictionary *)dic :(NSArray *)arr :(TypeView *)view
{
    for (int i = 0; i<arr.count; i++) {
        int count = [arr[i][@"goods_stock"] intValue];
        UIButton *btn =(UIButton *)[view viewWithTag:100+i];
        btn.selected = NO;
        [btn setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
        if (count == 2) {
            btn.enabled = NO;
            [btn setTitleColor:[UIColor lightGrayColor] forState:0];
        }else
        {
            btn.enabled = YES;
            [btn setTitleColor:[UIColor blackColor] forState:0];
        }
        //根据seletIndex 确定用户当前点了那个按钮
        if (view.seletIndex == i && count != 2) {
            btn.selected = YES;
            [btn setBackgroundColor:[UIColor redColor]];
        }
    }
}
#pragma mark - 图文详情 参数
- (void)photoButtonAction
{
    weizhi = YES;
    [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.dataDic[@"goods_ios_descurl"]]]];
}
- (void)textButtonAction
{
    weizhi = NO;
    [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.dataDic[@"goods_ios_attrcurl"]]]];
}
#pragma mark - WKWebView Delegate Methods
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //获取到webview的高度
    CGFloat height = [[self.webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    self.webView.frame = CGRectMake(self.webView.frame.origin.x,self.webView.frame.origin.y, WIDTH, height);
    webHeight = height;
    [self.tableView reloadData];
}
//- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
//{
//    [self.webView evaluateJavaScript:@"document.body.offsetHeight" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
//        CGFloat webViewHeight = [result doubleValue];
//        if (webViewHeight != webHeight) {
//            self.webView.frame = CGRectMake(self.webView.frame.origin.x,self.webView.frame.origin.y, WIDTH, webViewHeight);
//            webHeight = webViewHeight;
//        }
////        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:2];
////        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
//        [self.tableView reloadData];
//    }];
//    
//}
#pragma mark - footerViewAction
- (void)addShopCar
{
    if ([ProjectCache isLogin]) {
        isCarOrBuy = 0;
        if (creatChose == YES) {
            [self initChoseView];
            [UIView animateWithDuration: 0.35 animations: ^{
                bgview.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.8,0.8);
                bgview.center = CGPointMake(self.view.center.x, self.view.center.y-50);
                choseView.center = self.view.center;
                choseView.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            } completion: nil];
        }else{
            [UIView animateWithDuration: 0.35 animations: ^{
                bgview.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.8,0.8);
                bgview.center = CGPointMake(self.view.center.x, self.view.center.y-50);
                choseView.center = self.view.center;
                choseView.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            } completion: nil];
        }
    }else{
        [self presentViewController:[[HBSLoginController alloc] init] animated:YES completion:^{
            
        }];
    }
}
#pragma mark - 立即购买
- (void)buyNowAction
{
    if ([ProjectCache isLogin]) {
        isCarOrBuy = 1;
        if (creatChose == YES) {
            [self initChoseView];
            [UIView animateWithDuration: 0.35 animations: ^{
                bgview.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.8,0.8);
                bgview.center = CGPointMake(self.view.center.x, self.view.center.y-50);
                choseView.center = self.view.center;
                choseView.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            } completion: nil];
        }else{
            [UIView animateWithDuration: 0.35 animations: ^{
                bgview.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.8,0.8);
                bgview.center = CGPointMake(self.view.center.x, self.view.center.y-50);
                choseView.center = self.view.center;
                choseView.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            } completion: nil];
        }

    }else{
        [self presentViewController:[[HBSLoginController alloc] init] animated:YES completion:^{
            
        }];
    }
}
- (void)phoneAction
{
    if ([ProjectCache isLogin]) {
        [phoneViewController call:self.dataDic[@"goods_store_phone"] inViewController:self failBlock:^{
            
        }];
    }else{
        [self presentViewController:[[HBSLoginController alloc] init] animated:YES completion:^{
            
        }];
    }
}
- (void)talkAction
{
    if ([ProjectCache isLogin]) {
        
        if (![EMClient sharedClient].isLoggedIn){
            [self creatAlertView:@"聊天已断开" message:nil sureStr:@"重新连接" cancelStr:@"关闭" sureAction:^(id result) {
                
                [[EMClient sharedClient] asyncLoginWithUsername:[ProjectCache getLoginMessage][@"user_im"] password:@"123456" success:^{
                } failure:^(EMError *aError) {
                    NSLog(@"%@", aError.errorDescription);
                }];
                
            } cancelAction:^(id result) {
                NSLog(@"end");
            }];
        }else{
            ChatViewController *chatVC = [[ChatViewController alloc] initWithConversationChatter:self.dataDic[@"goods_store_im"] conversationType:EMConversationTypeChat];
            chatVC.name = self.dataDic[@"goods_store_name"];
            chatVC.phone = self.dataDic[@"goods_store_phone"];
            [self.navigationController pushViewController:chatVC animated:YES];
        }
    }else{
        [self presentViewController:[[HBSLoginController alloc] init] animated:YES completion:^{
            
        }];
    }
}
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
