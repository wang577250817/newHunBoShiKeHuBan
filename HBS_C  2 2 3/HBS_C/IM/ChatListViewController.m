//
//  ChatListViewController.m
//  HuangXinDemo
//
//  Created by wangzuowen on 16/7/19.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "ChatListViewController.h"
#import "NSDate+Category.h"

#import "ConversationCell.h"
#import "EaseMessageViewController.h"

#import "ChatViewController.h"
#import "IMListModel.h"
#import "NSString+check.h"

@interface ChatListViewController ()<EMChatManagerDelegate, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataSource;
@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong) UIView *networkStateView;
@property (nonatomic, strong)UIImageView *imgView;

@end

@implementation ChatListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"会话列表";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
    self.dataArr = [[NSMutableArray alloc] init];
//        [self setNaviLeftBarButtonItem];
    
    [self createSubViewAndSetupNavi];
    
    [self.view bringSubviewToFront:self.tableView];
    
    _dataSource = [NSMutableArray array];
    
    //获取数据库中所有的会话
    self.dataSource = [self loadDataFromDataBase];
    if (_dataSource.count == 0) {
        
    }else{
        [self getData];
    }
    //error
    //没有这个图片
    if (_dataSource.count == 0 || [_dataSource isEqual:[NSNull null]]) {
        _imgView = [[UIImageView alloc] initWithFrame:self.view.frame];
        _imgView.image = [UIImage imageNamed:@"img_zanwuxiaoxi@2x"];
        //有图片 删除;
        _imgView.backgroundColor = WZWgrayColor;
        [self.view addSubview:_imgView];
    }

    [self networkStateView];
    
}
- (UIView *)networkStateView
{
    if (_networkStateView == nil) {
        _networkStateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 44)];
        _networkStateView.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:199 / 255.0 blue:199 / 255.0 alpha:0.5];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (_networkStateView.frame.size.height - 20) / 2, 20, 20)];
        imageView.image = [UIImage imageNamed:@"messageSendFail"];
        [_networkStateView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 5, 0, _networkStateView.frame.size.width - (CGRectGetMaxX(imageView.frame) + 15), _networkStateView.frame.size.height)];
        label.font = [UIFont systemFontOfSize:15.0];
        label.textColor = [UIColor grayColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = NSLocalizedString(@"network.disconnection", @"Network disconnection");
        [_networkStateView addSubview:label];
    }
    
    return _networkStateView;
}

- (void)didConnectionStateChanged:(EMConnectionState)aConnectionState
{
    if (aConnectionState == EMConnectionDisconnected) {
        self.tableView.tableHeaderView = _networkStateView;
    }
    else{
        self.tableView.tableHeaderView = nil;
    }

}
- (void)isConnect:(BOOL)isConnect{
    if (!isConnect) {
        _tableView.tableHeaderView = _networkStateView;
        [_tableView reloadData];
    }
    else{
        _tableView.tableHeaderView = nil;
    }
}

- (void)getData
{
    NSString *chatString = @"";
    for (NSInteger i = 0; i < self.dataSource.count; i++) {
        NSString *str = [self.dataSource[i] conversationId];
        if ([str checkPhoneNumInput]) {
            if (i == 0) {
                chatString = [NSString stringWithFormat:@"%@", str];
            }
            else{
                chatString = [NSString stringWithFormat:@"%@-%@", chatString, str];
            }
        }
    }
    
    //error
    //sid stoken
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:[ProjectCache getLoginMessage][@"user_id"] forKey:@"id"];
    [dic setObject:chatString forKey:@"tochat"];
    
    if ([self checkWIFI]) {
        [self showLoadingViewWithMessage];
        [HBSNetWork getUrl:[NSString stringWithFormat:@"%@service/im/message", HBSNetAdress] paramaters:dic header:@"c02b68e88c44385f56064ce4cd49b319" cookie:nil Result:^(id result) {
            if ([result[@"code"] integerValue] == 200) {
                _tableView.userInteractionEnabled = YES;
                self.dataArr = [IMListModel transformWithArray:result[@"result"]];
                for (NSInteger i = 0; i< _dataArr.count; i++) {
                    [SCUserProfileEntity saveUserProfileWithUsername:[self.dataArr[i] im_id] forNickName:nil avatarURLPath:[self.dataArr[i] head_pic]];
                }
                [self.tableView reloadData];
            }else{
                [self creatAlertViewOne:@"提示" message:result[@"message"] sureStr:@"好的" sureAction:^(id result) {
                }];
            }
            [self removeLodingView];
        }];
    }else{
//            [self didConnectionStateChanged:EMConnectionDisconnected];
        self.tableView.userInteractionEnabled = NO;
        [self noNetWorkView:self.view];
        self.errorImage.userInteractionEnabled = YES;
        __weak typeof(self)weakself = self;
        self.freshBlock = ^(void){
            [weakself getData];
        };
    }
}
#pragma mark - 获取列表数据
- (NSMutableArray *)loadDataFromDataBase
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
    return array;
}
- (void)dealloc {
    
    [[EMClient sharedClient].chatManager removeDelegate:self];
    self.tableView.delegate = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
//    [self.navigationController.navigationBar setTitleTextAttributes:
//     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
//       NSForegroundColorAttributeName:FENSE}];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    if (_dataSource.count != 0) {
        
        [self setDataSource:[self loadDataFromDataBase]];
    }
}




#pragma mark - searchBar Delegate
//当搜索框文本开始发生改变
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"%@", searchText);
    NSMutableArray *arr = [NSMutableArray array];
    //查询已经注册的用户中是否包含该号
//    NSLog(@"all: %@", [self loadAllMiaoName]);
    for (NSString *name in [self loadAllMiaoName]) {
        if ([name isEqualToString:[[EMClient sharedClient] currentUsername]]) {
            continue;
        }
        if ([name containsString:searchText]) {
            EMConversation *conversation = [[EMClient sharedClient].chatManager getConversation:name type:EMConversationTypeChat createIfNotExist:YES];
            [arr addObject:conversation];
            NSLog(@"name  :%@ searchText: %@", name, searchText);
        }
    }
    [self setDataSource:arr];
    if ([searchText isEqualToString:@""]) {
        [self setDataSource:[self loadDataFromDataBase]];
    }
}

#pragma mark - 重写数据源
- (void)setDataSource:(NSMutableArray *)dataSource {
    
    if (_dataSource != dataSource) {
        
        _dataSource = dataSource;
        
        [_tableView reloadData];
    }
}

#pragma mark - tableView Delegate && DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ConversationCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName(self)]];
    cell.conversation = _dataSource[indexPath.row];
    
    cell.model = self.dataArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"当前登录账号 %@", [[EMClient sharedClient] currentUsername]);
    
    EMConversation *conversation = _dataSource[indexPath.row];
    IMListModel *model = self.dataArr[indexPath.row];
    ChatViewController *chatVC = [[ChatViewController alloc] initWithConversationChatter:conversation.conversationId conversationType:EMConversationTypeChat];
    chatVC.headStr = model.head_pic;
    chatVC.name = model.real_name;
    chatVC.store_id = model.store_id;
    chatVC.type = model.type;
    chatVC.phone = model.im_id;
    
    [self.navigationController pushViewController:chatVC animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self.searchBar resignFirstResponder];
}

#pragma mark - 当数据为空时显示的字符
-(NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"没有喵信╮(╯_╰)╭";
    
    NSDictionary *str = @{NSFontAttributeName:[UIFont systemFontOfSize:16.0f]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:str];
}

#pragma mark - 账号是否存在
- (BOOL)isExitMiao:(NSString *)str {
    
    for (NSString *miao in [self loadAllMiaoName]) {
        
        if ([str isEqualToString:miao]) {
            return YES;
        }
    }
    
    return NO;
}

#pragma mark - 取得注册过的所有账号
- (NSArray *)loadAllMiaoName {
    
    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
    NSMutableArray *dataArr = [[NSMutableArray alloc] init];
    for (EMConversation *cc in conversations) {
        [dataArr addObject:cc.conversationId];
    }
    return dataArr;
}

#pragma mark -  视图将要消失 取消搜索框第一响应者
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [self.searchBar resignFirstResponder];
}

#pragma mark - 创建子控件
/**
 *  Description 创建搜索框以及设置导航栏
 */
- (void)createSubViewAndSetupNavi {
    
//    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(100, 0, 200, 40)];
//    _searchBar.searchBarStyle = UISearchBarStyleMinimal;
//    //    _searchBar.layer.cornerRadius = 15;
//    //    _searchBar.layer.masksToBounds = YES;
//    _searchBar.delegate = self;
//    
//    _searchBar.placeholder = @"搜索";
//    //    _searchBar.backgroundColor = [UIColor grayColor];
//    self.tableView.tableHeaderView = _searchBar;
}

/**
 *  Description tableView懒加载
 *
 */
- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.rowHeight = 70.0f;
        self.tableView.dataSource = self;
        self.tableView.clipsToBounds = YES;
        //        self.tableView.emptyDataSetDelegate = self;
        self.tableView.tableFooterView = [UIView new];
        //            [self.tableView setEditing:YES];
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        
        //        self.tableView.emptyDataSetSource = self;
        
        [self.tableView registerClass:[ConversationCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName(self)]];
        
        [self.view addSubview:self.tableView];
    }
    return _tableView;
}

- (void)didReceiveMessages:(NSArray *)aMessages
{
    [self.imgView removeFromSuperview];
    self.dataSource = [self loadDataFromDataBase];
    
    [_tableView reloadData];
    
}
#pragma mark- 滑动删除
//1.是否允许编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    //利用系统编辑按钮 控制tableView编辑状态
    [self.tableView setEditing:editing animated:animated];
    
}
//设置cell 的编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //通过indexPath设置编辑类型 默认为delete
    return UITableViewCellEditingStyleDelete;
}
// 判断状态  执行 删除或添加操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //删除操作
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //删除数组的对应位置的数据
        //        self.newestModel =[self.searchArr objectAtIndex:indexPath.row];
        //        [[DataBase shareDataBase]deleteStudent:self.newestModel.title];
        //        [self.searchArr removeObject:self.newestModel];
        
        [[EMClient sharedClient].chatManager deleteConversation:[self.dataSource[indexPath.row] conversationId] deleteMessages:NO];
        [self.dataArr removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
        //让视图同步  @[indexPath]同步删除操作的对应信息
        //        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}
//cell的移动
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    //移动:把原位置的cell数据删除  添加到目标位置
    //设置临时变量 保存数据  移动是不能保证数据的引用计数是否为1 为了防止数据呗提前释放 获取对象后retain 让对象的引用计数加1 当进行完删除和添加操作之后 在release
    //    WZWNewestModel *model = [self.searchArr[sourceIndexPath.row] retain];
    //    [self.searchArr removeObjectAtIndex:sourceIndexPath.row];
    //    [self.searchArr insertObject:model atIndex:destinationIndexPath.row];
    //    [model release];
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
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
