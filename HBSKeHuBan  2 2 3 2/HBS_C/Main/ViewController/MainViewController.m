//
//  MainViewController.m
//  HBS_C
//
//  Created by wangzuowen on 16/9/10.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "MainViewController.h"
#import "MainOneTableViewCell.h"
#import "MainTwoTableViewCell.h"
#import "MainModel.h"
#import "ChangePhotos.h"
#import "TaoMarryThingViewController.h"
#import "ButlerListViewController.h"
#import "ShopCarViewController.h"
#import "HBSLoginController.h"

#import "WebWithUrlViewController.h"
#import "WeddingDetailViewController.h"
#import "ShopDetailViewController.h"

#import "WeddingOrderViewController.h"
#import "WeddingDetailViewController.h"

#import "ChatViewController.h"
#import "ChatListViewController.h"

@interface MainViewController ()<UITableViewDelegate, UITableViewDataSource, EMChatManagerDelegate, UIScrollViewDelegate>

{
    
    //    BOOL isBanner;
    int tt;//未读
}
@property (nonatomic, assign)int yinji;//记录用
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)NSMutableArray *bannerArr;
@property (nonatomic, strong)NSMutableArray *tabArr;
@property (nonatomic, strong)NSMutableArray *titleArr;

@property (nonatomic, strong)NSMutableArray *listArr;

@property (nonatomic, strong)UILabel *bottomLabel;

@property (nonatomic, assign)BOOL isFresh;
@property (nonatomic, strong)ChangePhotos *changePhotos;

@property (nonatomic, strong)UILabel *numLabel;
@property (nonatomic, copy)NSString *photoStr;
@end

@implementation MainViewController

@synthesize buttonOne;

#define PIC_NUM 3
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.changePhotos openTimer];
    //    self.tabBarController.tabBar.hidden = NO;
    if ([ProjectCache isLogin]) {
        
        if ([EMClient sharedClient].isLoggedIn) {
            tt = [self loadDataFromDataBase];
            if (tt == 0) {
                _numLabel.hidden = YES;
            }else{
                _numLabel.backgroundColor = FENSE;
                _numLabel.hidden = NO;
                _numLabel.text = [NSString stringWithFormat:@"%d", tt];
            }
        }else{
//            [self creatAlertViewOne:@"聊天断开连接" message:nil sureStr:@"重新连接" sureAction:^(id result) {
                [[EMClient sharedClient] asyncLoginWithUsername:[ProjectCache getLoginMessage][@"user_im"] password:@"123456" success:^{
                    tt = [self loadDataFromDataBase];
                    if (tt == 0) {
                        _numLabel.hidden = NO;
                    }else{
                        _numLabel.backgroundColor = FENSE;
                        _numLabel.hidden = NO;
                        _numLabel.text = [NSString stringWithFormat:@"%d", tt];
                    }
                } failure:^(EMError *aError) {
                    NSLog(@"%@", aError.errorDescription);
                }];
//            }];
        }

    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [self.changePhotos closeTimer];
//    UIApplication *application = [UIApplication sharedApplication];
//    [application setApplicationIconBadgeNumber:0];
}
- (void)dealloc
{
    self.tableView.delegate = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BEIJINGSE;
    TITLE = @"婚博士";
    self.automaticallyAdjustsScrollViewInsets = NO;
    //调用引导页方法
    [self guidePage];
    _dataArr = @[].mutableCopy;
    _bannerArr = [NSMutableArray array];
    _tabArr = [NSMutableArray array];
    _titleArr = [NSMutableArray array];
    _listArr = [NSMutableArray array];
    
    //    [self netWorking:0];
    [self creatTableViewHeaderView];
    [self set_Up_naviButton];
    
    _yinji = 0;
    //    isBanner = YES;
    _isFresh = NO;
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
    
}
- (void)set_Up_naviButton
{
    UIButton *carButton = [UIButton buttonWithType:UIButtonTypeCustom];
    carButton.frame = CGRectMake(0, 0, 30, 30);
    
    [carButton setImage:ImageNameSet(@"icon_1_gouwucheshouye@2x.png") forState:UIControlStateNormal];
    [carButton addTarget:self action:@selector(carAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [phoneButton setImage:[UIImage imageNamed:@"icon_1_kefu@2x"] forState:UIControlStateNormal];
    phoneButton.frame = CGRectMake(0, 0, 30, 30);
    [phoneButton addTarget:self action:@selector(phoneAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:carButton], [[UIBarButtonItem alloc] initWithCustomView:phoneButton]];
    
    UIView *messageView = ViewAlloc(0, 0, 60, 30);
    //    messageView.backgroundColor = WZWgrayColor;
    
    UIButton *chatButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [chatButton setImage:[UIImage imageNamed:@"icon_1_xiaoxi@2x"] forState:UIControlStateNormal];
    chatButton.frame = CGRectMake(0, 10, 18, 18);
    [chatButton addTarget:self action:@selector(chatButton) forControlEvents:UIControlEventTouchUpInside];
    [messageView addSubview:chatButton];
    _numLabel = LabelAlloc(15, 5, 15, 15);
    _numLabel.font = FONT(11);
    _numLabel.layer.cornerRadius = 15 / 2;
    _numLabel.layer.masksToBounds = YES;
    [messageView addSubview:_numLabel];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:messageView];
}
- (int)loadDataFromDataBase
{
    NSArray *conversations = [[EMClient sharedClient].chatManager loadAllConversationsFromDB];
    NSMutableArray *array = [NSMutableArray array];
    for (EMConversation *conversation in conversations) {
        if ([conversation.conversationId isEqualToString:[[EMClient sharedClient] currentUsername]] || [conversation.conversationId isEqualToString:@""]) {
            continue;
        }
        if (!conversation.latestMessage) {
            continue;
        }
        [array addObject:conversation];
    }
    int ttt = 0;
    for (EMConversation *cc in array) {
        ttt += cc.unreadMessagesCount;
    }
    
    return ttt;
}
#pragma mark - 消息方法
- (void)chatButton
{
    if (![ProjectCache isLogin]) {
        [self presentViewController:[[HBSLoginController alloc] init] animated:YES completion:^{
            
        }];
    }else{
        ChatListViewController *listVC = [[ChatListViewController alloc] init];
        [self.navigationController pushViewController:listVC animated:YES];
    }
}
#pragma mark - 数据
- (void)netWorking:(NSInteger)num
{
    if ([self checkWIFI]) {
        [self showLoadingViewWithMessage];
        [HBSNetWork getUrl:[NSString stringWithFormat:@"%@store/index", HBSNetAdress] cookie:nil Result:^(id result) {
            if ([result[@"code"] integerValue] == 200) {
                self.tableView.userInteractionEnabled = YES;
                if (_isFresh) {
                    [_titleArr removeAllObjects];
                    [_dataArr removeAllObjects];
                    [_bannerArr removeAllObjects];
                }
                if (self.errorImage) {
                    [self.errorImage removeFromSuperview];
                }
//                            float version = [[[UIDevice currentDevice] systemVersion] floatValue];
//                            if (version >= 8.0) {
//                                UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
//                                [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
//                            }
                //            [UIApplication sharedApplication].applicationIconBadgeNumber = [result[@"result"][@"banner_list"] count];
                
                _bannerArr = [MainModel transformWithArray:result[@"result"][@"banner_list"]];
                [_tabArr addObjectsFromArray:result[@"result"][@"tab_list"]];
                _listArr = [@[[MainModel transformWithArray:result[@"result"][@"goods_list_0"]], [MainModel transformWithArray:result[@"result"][@"goods_list_1"]], [MainModel transformWithArray:result[@"result"][@"goods_list_2"]], [MainModel transformWithArray:result[@"result"][@"goods_list_3"]], [MainModel transformWithArray:result[@"result"][@"goods_list_4"]]] mutableCopy];
                
                for (NSDictionary *dic in result[@"result"][@"goods_list_name"]) {
                    [_titleArr addObject:dic[@"list_name"]];
                }
                NSMutableArray *imageArr = [NSMutableArray new];
                for (MainModel *model in _bannerArr) {
                    [imageArr addObject:model.adv_image];
                }
                //            if (isBanner) {
                self.changePhotos.dataArr = imageArr;
                //            }
                _photoStr = result[@"result"][@"tel"];
                
                [self.dataArr addObjectsFromArray:_listArr[num]];
                [_tableView reloadData];
                [_changePhotos reloadData];
                //            isBanner = NO;
            }else{
                //error
            }
            [self removeLodingView];
        }];

    }else{
        self.tableView.userInteractionEnabled = NO;
        
        if (!self.errorImage) {
            
            [self noNetWorkView:self.view];
        }
        
        self.errorImage.userInteractionEnabled = YES;
        __weak typeof(self)weakself = self;
        self.freshBlock = ^(void){
            [weakself netWorking:weakself.yinji];
        };
    }
}

#pragma mark - creatTableViewHeaderView
- (void)creatTableViewHeaderView
{
    self.changePhotos = [[ChangePhotos alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 167 * HSHIPEI)];
    _changePhotos.backgroundColor = [UIColor orangeColor];
    self.tableView.tableHeaderView = self.changePhotos;
    
    __weak typeof(self)weakself = self;
    self.changePhotos.block = ^(NSInteger flag) {
        if ([[weakself.bannerArr[flag] adv_type] isEqualToString:@"butler_store"] || [[weakself.bannerArr[flag] adv_type] isEqualToString:@"store"]) {
            ShopDetailViewController *shopVC = [[ShopDetailViewController alloc] init];
            shopVC.story_id = [weakself.bannerArr[flag] adv_item_id];
            [weakself.navigationController pushViewController:shopVC animated:YES];
        }else if ([[weakself.bannerArr[flag] adv_type] isEqualToString:@"article"] || [[weakself.bannerArr[flag] adv_type] isEqualToString:@"web"] || [[weakself.bannerArr[flag] adv_type] isEqualToString:@"link"]){
            WebWithUrlViewController *webVC = [[WebWithUrlViewController alloc] init];
            webVC.urlWithString = [weakself.bannerArr[flag] adv_url];
            webVC.title = @"详情";
            [weakself.navigationController pushViewController:webVC animated:YES];
        }else if ([[weakself.bannerArr[flag] adv_type] isEqualToString:@"package"]){
            WeddingDetailViewController *weedVC = [[WeddingDetailViewController alloc] init];
            weedVC.goods_id = [weakself.bannerArr[flag] adv_item_id];
            weedVC.type = DetailTypeGoods;
            [weakself.navigationController pushViewController:weedVC animated:YES];
        }else if ([[weakself.bannerArr[flag] adv_type] isEqualToString:@"goods"]){
            WeddingDetailViewController *weedVC = [[WeddingDetailViewController alloc] init];
            weedVC.goods_id = [weakself.bannerArr[flag] adv_item_id];
            weedVC.type = DetailTypeWedding;
            [weakself.navigationController pushViewController:weedVC animated:YES];
        }else if ([[weakself.bannerArr[flag] adv_type] isEqualToString:@"case"]){
            WeddingDetailViewController *weedVC = [[WeddingDetailViewController alloc] init];
            weedVC.goods_id = [weakself.bannerArr[flag] adv_item_id];
            weedVC.type = DetailTypeCase;
            [weakself.navigationController pushViewController:weedVC animated:YES];
        }
    };
    
}
- (UITableView *)tableView
{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64 - 49) style:UITableViewStylePlain];
        tableView.separatorStyle = NO;
        tableView.delegate = self;
        tableView.dataSource = self;
//        tableView.rowHeight = 200 * HSHIPEI;
        [self.view addSubview:tableView];
        
        tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self.isFresh = YES;
            [self netWorking:_yinji];
            [tableView.mj_header endRefreshing];
        }];
        [tableView.mj_header beginRefreshing];
        tableView.mj_header.automaticallyChangeAlpha = YES;
        _tableView = tableView;
    }
    return _tableView;
}
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 200 * HSHIPEI;
}
#pragma mark - tableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 50)];
        headerView.backgroundColor = BEIJINGSE;
        NSInteger num = self.titleArr.count;
        CGFloat ff = (WIDTH - 60) / num;
        for (int i = 1; i <= num; i++) {
            buttonOne = [UIButton buttonWithType:UIButtonTypeCustom];
            buttonOne.frame = CGRectMake(i*10 + (i - 1)*ff, 10, ff, 30);
            buttonOne.tag = 2000+i;
            if(WIDTH == 320){
                buttonOne.titleLabel.font = FONT(12);
            }else{
                buttonOne.titleLabel.font = FONT(15);
            }
            [buttonOne setTitle:self.titleArr[i - 1] forState:UIControlStateNormal];
            [buttonOne addTarget:self action:@selector(titleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [buttonOne setTitleColor:HEISE forState:UIControlStateNormal];
            [buttonOne setTitleColor:FENSE forState:UIControlStateSelected];
            if (i == _yinji + 1) {
                buttonOne.selected = YES;
            }
            [headerView addSubview:buttonOne];
        }
        int t = ff;
        _bottomLabel = LabelAlloc(10 * (_yinji + 1) + (t * _yinji), 48, ff, 2);
        _bottomLabel.backgroundColor = FENSE;
        [headerView addSubview:_bottomLabel];
        
        return headerView;
    }else{
        return [UIView new];
    }
}
#pragma mark - 标题栏事件
- (void)titleButtonAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    CGFloat ff = (WIDTH - 60) / self.titleArr.count;
    _bottomLabel.frame = CGRectMake((sender.tag - 2000)*10 + (sender.tag - 2000 - 1)*ff, 48, ff, 2);
    for (int i = 1; i <= self.titleArr.count; i++) {
        UIButton *bb = (UIButton *)[self.view viewWithTag:2000 + i];
        if (sender.tag != 2000 + i && sender.selected == YES) {
            bb.selected = NO;
        }
    }
    _yinji = (int)sender.tag - 2000 - 1;
    self.dataArr = self.listArr[sender.tag - 2001];
    NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:1];
    [_tableView setContentOffset:CGPointMake(0, 367*HSHIPEI) animated:YES];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    //    [self.tableView reloadData];
    //    [self netWorking:sender.tag - 2001];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else{
        return 50;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return self.dataArr.count;
            break;
        default:
            return 0;
            break;
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellStr = @"cellStr";
    if (indexPath.section == 0) {
        MainOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (!cell) {
            cell = [[MainOneTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        }
        
        [cell.hdzqButton addTarget:self action:@selector(hdzqAction) forControlEvents:UIControlEventTouchUpInside];
        [cell.bslButton addTarget:self action:@selector(bslAction) forControlEvents:UIControlEventTouchUpInside];
        [cell.hlgjButton addTarget:self action:@selector(hlgjAction) forControlEvents:UIControlEventTouchUpInside];
        [cell.thpButton addTarget:self action:@selector(thpAction) forControlEvents:UIControlEventTouchUpInside];
        cell.dataArr = self.tabArr;
        return cell;
    }else if(indexPath.section == 1){
        MainTwoTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:cellStr];
        if (!cell1) {
            cell1 = [[MainTwoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        }
        if (_dataArr.count != 0) {
            cell1.model = self.dataArr[indexPath.row];
        }
        return cell1;
    }else{
        return nil;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.changePhotos closeTimer];
    WeddingDetailViewController *detailVC = [[WeddingDetailViewController alloc] init];
    if ([[self.dataArr[indexPath.row] goods_type] isEqualToString:@"case"]) {
        detailVC.type = DetailTypeCase;
    }else{
        detailVC.type = DetailTypeGoods;
    }
    
    detailVC.goods_id = [self.dataArr[indexPath.row] goods_id];
    [self.navigationController pushViewController:detailVC animated:YES];
}
#pragma mark - carAndPhoneAction
- (void)carAction
{
    if ([ProjectCache isLogin]) {
        ShopCarViewController *scVC = [[ShopCarViewController alloc] init];
        [self.navigationController pushViewController:scVC animated:YES];
    }else{
        [self presentViewController:[[HBSLoginController alloc] init] animated:YES completion:^{
            
        }];
    }
}
- (void)phoneAction
{
    if (![self.photoStr isEqualToString:@""] && ![self.photoStr isEqual:[NSNull null]]) {
    
        [phoneViewController call:self.photoStr inViewController:self failBlock:^{
        }];
    }

}
- (void)buttonOneAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
}
#pragma mark - 活动专区
- (void)hdzqAction
{
    WebWithUrlViewController *webVC = [[WebWithUrlViewController alloc] init];
    webVC.urlWithString = self.tabArr[0][@"tab_url"];
    webVC.title = @"活动专区";
    [self.navigationController pushViewController:webVC animated:YES];
}
- (void)bslAction
{
    WebWithUrlViewController *webVC = [[WebWithUrlViewController alloc] init];
    webVC.urlWithString = self.tabArr[1][@"tab_url"];
    webVC.title = @"伴手礼";
    [self.navigationController pushViewController:webVC animated:YES];
}
- (void)hlgjAction
{
    [self.navigationController pushViewController:[[ButlerListViewController alloc] init] animated:YES];
}
- (void)thpAction
{
    [self.navigationController pushViewController:[[TaoMarryThingViewController alloc] init] animated:YES];
}

#pragma mark----引导页的方法
- (void)guidePage{
    
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"qidongye"] == nil) {
        
        //第一次启动
        scrol=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, [APPDELEGATE window].frame.size.height)];
        scrol.delegate=self;
        [scrol setPagingEnabled:YES];
        [scrol setContentSize:CGSizeMake(WIDTH * PIC_NUM, [APPDELEGATE window].frame.size.height)];
        pageC=[[UIPageControl alloc] initWithFrame:CGRectMake(0, [APPDELEGATE window].frame.size.height-50, WIDTH, 37)];
//        [pageC setPageIndicatorTintColor:[ProjectCache returnColorWithRGB:@"255,81,101"]];
        pageC.numberOfPages = PIC_NUM;
        
        for (int i =0 ; i<PIC_NUM; i++) {
            UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(i * WIDTH, 0, WIDTH, [APPDELEGATE window].frame.size.height)];
            img.image=[UIImage imageNamed:[NSString stringWithFormat:@"qidongye%d.png",i]];
            [scrol addSubview:img];
            if (i==PIC_NUM-1) {
                UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
                [btn setBackgroundImage:[UIImage imageNamed:@"icon_anniu"] forState:UIControlStateNormal];
                [btn setTitle:@"马上体验" forState:UIControlStateNormal];
                btn.layer.cornerRadius=15;
                [btn setAlpha:0.7];
                [btn setFrame:CGRectMake((PIC_NUM-1)*WIDTH + (WIDTH/2) - 50, [APPDELEGATE window].frame.size.height-120, 100, 34)];
                [btn addTarget:self action:@selector(hideScroll:) forControlEvents:UIControlEventTouchUpInside];
                [scrol addSubview:btn];
            }
        }

        [[APPDELEGATE window] addSubview:scrol];
        [[APPDELEGATE window] addSubview:pageC];
        
        
        
    }
    
}
- (void)hideScroll:(id)sender{
    
    [UIView animateWithDuration:0.3f animations:^{
        [scrol setFrame:CGRectMake(0, 0, 0, [APPDELEGATE window].frame.size.height)];
    } completion:^(BOOL finished){
        [scrol removeFromSuperview];
        [pageC removeFromSuperview];
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"qidongye"];
    }];
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int index=fabs(scrollView.contentOffset.x)/scrollView.frame.size.width;
    pageC.currentPage=index;
}
#pragma mark - IM代理方法
- (void)didReceiveMessages:(NSArray *)aMessages
{
    [self setupUnreadMessageCount];
    //    NSTimeInterval timeInterval = [[NSDate date]
    //                                   timeIntervalSinceDate:self.lastPlaySoundDate];
    //    if (timeInterval < kDefaultPlaySoundInterval) {
    //        //如果距离上次响铃和震动时间太短, 则跳过响铃
    //        NSLog(@"skip ringing & vibration %@, %@", [NSDate date], self.lastPlaySoundDate);
    //        return;
    //    }
    //
    //    //保存最后一次响铃时间
    //    self.lastPlaySoundDate = [NSDate date];
    
    // 收到消息时，播放音频
    [[EMCDDeviceManager sharedInstance] playNewMessageSound];
    // 收到消息时，震动
    //    [[EMCDDeviceManager sharedInstance] playVibration];
    
}

- (void)setupUnreadMessageCount
{
    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
    NSInteger unreadCount = 0;
    for (EMConversation *conversation in conversations) {
        unreadCount += conversation.unreadMessagesCount;
    }
    //    [UIApplication sharedApplication].applicationIconBadgeNumber = unreadCount;
    
    if (unreadCount > 0) {
        self.numLabel.backgroundColor = [UIColor redColor];
        self.numLabel.text = [NSString stringWithFormat:@"%i",(int)unreadCount];
        self.numLabel.hidden = NO;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"count" object:self];
    }else if(unreadCount == 0){
        self.numLabel.hidden = YES;
        //        self.unRead.text = @"0";
        //        [[NSNotificationCenter defaultCenter] postNotificationName:@"count" object:self];
    }else{
        
    }
//    UIApplication *application = [UIApplication sharedApplication];
//    [application setApplicationIconBadgeNumber:unreadCount];
}
@end
