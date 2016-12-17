//
//  ShopDetailViewController.m
//  HBS_C
//
//  Created by wangzuowen on 16/10/31.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "ShopDetailViewController.h"
#import "ShopDetailTableViewCell.h"
#import "ShopDetailCaseTableViewCell.h"
#import "ShopDetailEvaluationTableViewCell.h"
#import "ShopDetailGoodsTableViewCell.h"
#import "ShopCityModel.h"
#import "ShopDetailHeaderTableViewCell.h"
#import "WeddingDetailViewController.h"
#import "CaseListViewController.h"
#import "GoodsListViewController.h"
#import "WebWithUrlViewController.h"

#import <SPIExpandHeader/CExpandHeader.h>

@interface ShopDetailViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    CExpandHeader *_header;
}
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)ShopCityModel *model;
@property (nonatomic, strong)UIImageView *headerImage;
@property (nonatomic, strong)UIImageView *userImageView;
@property (nonatomic, strong)UIView *footerView;
@property (nonatomic, assign)BOOL isMore;

@property (nonatomic, strong)UIButton *likeButton;

@end

@implementation ShopDetailViewController

- (void)dealloc
{
    self.tableView.delegate = nil;
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
    
    [self creatTabelView];
    [self creatHeaderView];
    [self netWorking];
    _isMore = NO;
}

- (void)netWorking
{
    if ([self checkWIFI]) {
        [self showLoadingViewWithMessage];
        NSDictionary *dic = @{@"user_id":@"1036"};
        [HBSNetWork getUrl:[NSString stringWithFormat:@"%@store/info/%@", HBSNetAdress, self.story_id] paramaters:dic header:nil cookie:nil Result:^(id result) {
            if ([result[@"code"] integerValue] == 200) {
                _model = [ShopCityModel baseModelWithDic:result[@"result"]];
                
                [_headerImage sd_setImageWithURL:WZWURLWithString(self.model.store_banner) placeholderImage:ZHANWEI];
                
                if ([_model.store_state integerValue] == 1) {
                    _likeButton.selected = YES;
                }else{
                    _likeButton.selected = NO;
                }
                
                [self.tableView reloadData];
            }
        }];
        [self removeLodingView];
    }
}
- (void)creatTabelView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 49 * HSHIPEI) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.sectionFooterHeight = 0.01f;
    [self.view addSubview:_tableView];
    
    self.tableView.separatorStyle = NO;
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(10, 32, 28, 28);
    [backButton setImage:[UIImage imageNamed:@"icon_1_2_fanhui(youdi)@2x"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(WIDTH - 45, 32, 30, 30);
    [shareButton setImage:[UIImage imageNamed:@"icon_1_2_fenxiaqng@2x"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareButton];

    
    _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _likeButton.frame = CGRectMake(WIDTH - 90, 32, 30, 30);
    [_likeButton setImage:[UIImage imageNamed:@"icon_nor_xihua@2x"] forState:UIControlStateNormal];
    [_likeButton setImage:[UIImage imageNamed:@"icon_sel_xihuan@2x"] forState:UIControlStateSelected];
//    _likeButton.selected = _isLike;
    [_likeButton addTarget:self action:@selector(likeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_likeButton];
    
    _footerView = ViewAlloc(0, HEIGHT - 49 * HSHIPEI, WIDTH, 49 * HSHIPEI);
//    _footerView.backgroundColor = WZWmagentaColor;
    [self.view addSubview:_footerView];
    UIButton *phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    phoneButton.frame = CGRectMake(0, 0, WIDTH / 2, 49 * HSHIPEI);
    [phoneButton setImage:[UIImage imageNamed:@"button_1_2_dianhuazhixun@2x"] forState:UIControlStateNormal];
    [phoneButton addTarget:self action:@selector(phoneAction) forControlEvents:UIControlEventTouchUpInside];
    [self.footerView addSubview:phoneButton];
    UIButton *talkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    talkButton.frame = CGRectMake(WIDTH / 2, 0, WIDTH / 2, 49 * HSHIPEI);
    [talkButton setImage:[UIImage imageNamed:@"button_1_2_hetaliao@2x"] forState:UIControlStateNormal];
    [talkButton addTarget:self action:@selector(talkAction)forControlEvents:UIControlEventTouchUpInside];
    [self.footerView addSubview:talkButton];
    
}
#pragma mark - 上下按钮方法
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)shareAction
{
    
}
- (void)likeAction:(UIButton *)sender
{
    NSDictionary *dic = @{@"user_id":@"1036", @"store_flag":[NSString stringWithFormat:@"%d", !sender.selected]};
    [HBSNetWork putUrl:[NSString stringWithFormat:@"%@store/%@/collect", HBSNetAdress, self.model.store_id] parame:dic header:@"header" cookie:nil result:^(id result) {
        if ([result[@"code"] integerValue] == 200) {
            sender.selected = !sender.selected;
            NSString *str = @"";
            if (sender.selected) {
                str = @"收藏成功";
            }else{
                str = @"取消收藏";
            }
            // tishi  jinggao
            [self creatAlertWithTimer:str fatherView:self.view];
        }else{
        
        }
    }];
}
- (void)phoneAction
{
    [phoneViewController call:self.model.store_tel inViewController:self failBlock:^{
        
    }];
}
- (void)talkAction
{
    if (![EMClient sharedClient].isLoggedIn){
        [self creatAlertView:@"聊天已断开" message:nil sureStr:@"重新连接" cancelStr:@"关闭" sureAction:^(id result) {
            NSLog(@"sure");
        } cancelAction:^(id result) {
            NSLog(@"end");
        }];
    }else{
        ChatViewController *chatVC = [[ChatViewController alloc] initWithConversationChatter:self.model.store_im conversationType:EMConversationTypeChat];
        chatVC.name = self.model.store_name;
        chatVC.phone = self.model.store_tel;
        [self.navigationController pushViewController:chatVC animated:YES];
    }
}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    //该方法是当scrollView滑动时触发，因为UITableView继承自UIScrollView因此在这里也可以调用
//    CGFloat header = 240;//这个header其实是section1 的header到顶部的距离
//    if (scrollView.contentOffset.y<=header&&scrollView.contentOffset.y>=0) {
//        //当视图滑动的距离小于header时
//        scrollView.contentInset = UIEdgeInsetsMake(header, 0, 0, 0);
//    }else if(scrollView.contentOffset.y>header)
//    {
//        //当视图滑动的距离大于header时，这里就可以设置section1的header的位置啦，设置的时候要考虑到导航栏的透明对滚动视图的影响
//        scrollView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
//    }
//}
- (void)creatHeaderView
{
    _headerImage = ImageAlloc(0, 0, WIDTH, 240 * HSHIPEI);
//    _headerImage.backgroundColor = WZWmagentaColor;

    _header = [CExpandHeader expandWithScrollView:self.tableView expandView:self.headerImage];
//    self.tableView.tableHeaderView = _headerImage;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            if ([self.model.goods_count integerValue] >= 2) {
                return 2;
            }else if ([self.model.goods_count integerValue] == 0){
                return 0;
            }
            else{
                return [self.model.goods_count integerValue];
            }
            return 0;
            break;
        case 3:
            if ([self.model.cases_count integerValue] >= 2) {
                return 2;
            }else if ([self.model.cases_count integerValue] == 0){
                return 0;
            }
            else{
                return [self.model.cases_count integerValue];
            }
            return 0;
            break;
        case 4:
            if ([self.model.articles_count integerValue] == 0){
                return 0;
            }else{
                return self.model.articles_info.count;
            }
            break;
        default:
            return 0;
            break;
    }
}
#pragma mark - 分区View
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 50)];
    sectionView.backgroundColor = BEIJINGSE;
    
    UILabel *label = LabelAlloc(10, 10, 80 * WSHIPEI, 20);
    label.font = FONT(15);
    label.textColor = yisanliuColor;
    [sectionView addSubview:label];

//    label.backgroundColor = WZWgrayColor;
    
    UIImageView *starImage = ImageAlloc(85, 13, 155 *WSHIPEI, 13);
    [sectionView addSubview:starImage];
    
    
    UIButton *allButton = [UIButton buttonWithType:UIButtonTypeCustom];
    allButton.frame = CGRectMake(WIDTH - 10 - 60, 10, 60, 20);
    allButton.tag = 1111 + section;
    [allButton addTarget:self action:@selector(allButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    allButton.titleLabel.font = FONT(14);
    
    [allButton setTitleColor:yisanliuColor forState:UIControlStateNormal];
    [sectionView addSubview:allButton];
    
    switch (section) {
        case 1:
            [starImage sd_setImageWithURL:WZWURLWithString(self.model.comment_star) placeholderImage:ZHANWEI];
            if ([self.model.goods_count integerValue] != 0) {
                [allButton setTitle:@"全部>>" forState:UIControlStateNormal];
                label.text = [NSString stringWithFormat:@"评价(%@)", self.model.goods_count];
            }else{
                [allButton setTitle:@"" forState:UIControlStateNormal];
            }
            break;
        case 2:
            if ([self.model.goods_count integerValue] > 2) {
                [allButton setTitle:@"全部>>" forState:UIControlStateNormal];
            }else{
                [allButton setTitle:@"" forState:UIControlStateNormal];
            }
            if ([self.model.goods_count integerValue] != 0) {
                label.text = [NSString stringWithFormat:@"服务(%@)", self.model.goods_count];
            }
            break;
        case 3:
            if ([self.model.cases_count integerValue] > 2) {
                [allButton setTitle:@"全部>>" forState:UIControlStateNormal];
            }else{
                [allButton setTitle:@"" forState:UIControlStateNormal];
            }
            if ([self.model.cases_count integerValue] != 0) {
                label.text = [NSString stringWithFormat:@"案例(%@)", self.model.cases_count];
            }
            break;
        case 4:
            if ([self.model.articles_count integerValue] != 0) {
                label.text = [NSString stringWithFormat:@"动态(%@)", self.model.articles_count];
            }
            break;
        default:
            break;
    }
    
    return sectionView;
}
#pragma mark - 查看全部按钮
- (void)allButtonAction:(UIButton *)sender
{
    NSLog(@"%ld", sender.tag - 1111);
    if (sender.tag - 1111 == 3) {
        CaseListViewController *caseVC = [[CaseListViewController alloc] init];
        caseVC.store_id = self.model.store_id;
        caseVC.store_cateId = self.model.store_cateId;
        [self.navigationController pushViewController:caseVC animated:YES];
    }else if(sender.tag - 1111 == 2){
        GoodsListViewController *goodsVC = [[GoodsListViewController alloc] init];
        goodsVC.store_id = self.model.store_id;
        [self.navigationController pushViewController:goodsVC animated:YES];
    }else if(sender.tag - 1111 == 1){
        WebWithUrlViewController *webVC = [[WebWithUrlViewController alloc] init];
        webVC.urlWithString = self.model.comment_url;
        webVC.title = @"全部评价";
        [self.navigationController pushViewController:webVC animated:YES];
    }
}
#pragma mark - 分区高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        if ([self.model.goods_count integerValue] == 0) {
            return 0.01f;
        }else{
            return 40.0f;
        }
    }else if (section == 3){
        if ([self.model.cases_count integerValue] == 0) {
            return 0.01f;
        }else{
            return 40.0f;
        }
    }else if (section == 4){
        if ([self.model.articles_count integerValue] == 0) {
            return 0.01f;
        }else{
            return 40.0f;
        }
    }else if (section == 1){
//        if ([self.model.articles_count integerValue] == 0) {
//            return 0.01f;
//        }else{
            return 40.0f;
//        }
    }else{
        return 0.01f;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 4) {
        CGFloat ff = [TextAdapter HeightWithText:self.model.articles_info[indexPath.row][@"article_content"] width:(WIDTH - 56) * WSHIPEI font:13];
        if ([self.model.articles_info[indexPath.row][@"article_images"] count] <= 3) {
            return ff + 117 * WSHIPEI + 92;
        }else if ([self.model.articles_info[indexPath.row][@"article_images"] count] <= 6 && [self.model.articles_info[indexPath.row][@"article_images"] count] >3){
            return ff + 117 * 2 * WSHIPEI + 82 + 10;
        }else if ([self.model.articles_info[indexPath.row][@"article_images"] count] <= 9 && [self.model.articles_info[indexPath.row][@"article_images"] count] >6){
            return ff + 117 * 3 * WSHIPEI + 82 + 20;
        }
        return 0.01f;
    }else if (indexPath.section == 3){
        return 215.0f;
    }else if (indexPath.section == 1){
        return 117.0f;
    }else if (indexPath.section == 2){
        return 100.0f;
    }
    else if (indexPath.section == 0){
        if (_isMore) {
            CGFloat ff = [TextAdapter HeightWithText:self.model.store_description width:WIDTH - 60 * WSHIPEI font:13];
            return 161 + ff;
        }else{
            return 161 + 30;
        }
    }
    return 0.01f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strCell = @"ShopDetailTableViewCell";
    static NSString *strCell2 = @"ShopDetailTableViewCell2";
    static NSString *strCell3 = @"ShopDetailTableViewCell3";
    static NSString *strCell4 = @"ShopDetailTableViewCell4";
    static NSString *strCell5 = @"ShopDetailTableViewCell5";
    
    if (indexPath.section == 4) {
        ShopDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell5];
        if (!cell) {
            cell = [[ShopDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell5];
        }
        CGFloat ff = [TextAdapter HeightWithText:self.model.articles_info[indexPath.row][@"article_content"] width:(WIDTH - 56) * WSHIPEI font:13];
        if ([self.model.articles_info[indexPath.row][@"article_images"] count] <= 3) {
            
            cell.height = ff + 117 * WSHIPEI + 82;
            
        }else if ([self.model.articles_info[indexPath.row][@"article_images"] count] <= 6 && [self.model.articles_info[indexPath.row][@"article_images"] count] >3){
            cell.height = ff + 117 * 2 * WSHIPEI + 82 + 10;
        }else if ([self.model.articles_info[indexPath.row][@"article_images"] count] <= 9 && [self.model.articles_info[indexPath.row][@"article_images"] count] >6){
            cell.height = ff + 117 * 3 * WSHIPEI + 82 + 20;
        }        cell.tt = [self.model.articles_info[indexPath.row][@"article_images"] count];
        cell.dataDic = self.model.articles_info[indexPath.row];
        return cell;
    }else if (indexPath.section == 3){
        ShopDetailCaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell4];
        if (!cell) {
            cell = [[ShopDetailCaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell4];
        }
        cell.dataDic = self.model.cases_info[indexPath.row];
        return cell;
    }else if (indexPath.section == 2){
        ShopDetailGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell3];
        if (!cell) {
            cell = [[ShopDetailGoodsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell3];
        }
        cell.dataDic = self.model.goods_info[indexPath.row];
        return cell;
    }
    else if (indexPath.section == 1){
        ShopDetailEvaluationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell2];
        if (!cell) {
            cell = [[ShopDetailEvaluationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell2];
        }
        cell.model = self.model;
        return cell;
    }
    else{
        ShopDetailHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
        if (!cell) {
            cell = [[ShopDetailHeaderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
        }
        [cell.moreButton addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.isMore = self.isMore;
        
        cell.model = self.model;
        return cell;
    }
    return nil;
}

- (void)moreAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    self.isMore = !self.isMore;
    
//    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
//    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    
    [self.tableView reloadData];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [[NSString alloc] initWithFormat]
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 2) {
        WeddingDetailViewController *wedVC = [[WeddingDetailViewController alloc] init];
        wedVC.type = DetailTypeGoods;
        wedVC.goods_id = self.model.goods_info[indexPath.row][@"goods_id"];
        [self.navigationController pushViewController:wedVC animated:YES];
    }else if(indexPath.section == 3){
        WeddingDetailViewController *wedVC = [[WeddingDetailViewController alloc] init];
        wedVC.type = DetailTypeCase;
        wedVC.goods_id = self.model.cases_info[indexPath.row][@"cases_id"];
        [self.navigationController pushViewController:wedVC animated:YES];
    }else if (indexPath.section == 4){
        WebWithUrlViewController *wedVC = [[WebWithUrlViewController alloc] init];
        wedVC.urlWithString = self.model.articles_info[indexPath.row][@"article_url"];
        wedVC.title = @"帖子详情";
        [self.navigationController pushViewController:wedVC animated:YES];
    }
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
