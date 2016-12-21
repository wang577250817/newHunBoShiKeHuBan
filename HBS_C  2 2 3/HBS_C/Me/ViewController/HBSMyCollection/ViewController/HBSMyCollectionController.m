//
//  HBSMyCollectionController.m
//  HBS_C
//
//  Created by 王 世江 on 16/10/30.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "HBSMyCollectionController.h"
#import "HBSTitleButton.h"
#import "HBSShopsController.h"
#import "HBSMarriageController.h"
#import "HBSServiceController.h"
#import "HBSAnLiController.h"

@interface HBSMyCollectionController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIView *titlesView;//标题栏View
@property (nonatomic, strong) UIView *indicatorView;//字下面的红条
@property (nonatomic, strong) HBSTitleButton *selectedTitleButton;
@property (nonatomic, strong) UIScrollView *scrollview;
@property (nonatomic, strong) UILabel *backLabel;//label的背景颜色

@end
@implementation HBSMyCollectionController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
    [self.navigationController.navigationBar setHidden:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = BAISE;
    [self setUpChildsViewController];
    [self setupScrollView];
    [self setUpChildControls];
    //默认添加全部
    [self addChildView];
}
#pragma mark----调用子控制器
- (void)setUpChildsViewController{
    
    //添加4个子控制器
    HBSShopsController *shop = [[HBSShopsController alloc]init];
    [self addChildViewController:shop];
    
    HBSMarriageController *marriage = [[HBSMarriageController alloc]init];
    [self addChildViewController:marriage];
    
    HBSServiceController *service = [[HBSServiceController alloc]init];
    [self addChildViewController:service];
    
    HBSAnLiController *anLi = [[HBSAnLiController alloc]init];
    [self addChildViewController:anLi];
    
    
}
#pragma mark----创建UIScrollView
- (void)setupScrollView{
    
    //不允许自动调整scrollView的高度 目的:让tableView占据整个屏幕
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.scrollview = [[UIScrollView alloc]init];
    self.scrollview.frame = CGRectMake(0, 110, WIDTH, HEIGHT);
    self.scrollview.pagingEnabled = YES;
    self.scrollview.showsVerticalScrollIndicator = NO;
    self.scrollview.showsHorizontalScrollIndicator = NO;
    self.scrollview.delegate = self;
    self.scrollview.contentSize = CGSizeMake(self.childViewControllers.count *self.scrollview.WSJ_width, 0);
    [self.view addSubview:self.scrollview];
    
}
#pragma mark----设置子控件
- (void)setUpChildControls{
    //返回箭头
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.leftBtn.frame = CGRectMake(0, 20, 30, 35);
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_fanhuijiantou"] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(clickImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.leftBtn];
    //标题栏View
    self.titlesView = [[UIView alloc]init];
//    self.titlesView.backgroundColor = HEISE;
    self.titlesView.frame = CGRectMake(0, 64, WIDTH, 44);
    [self.view addSubview:self.titlesView];
    self.backLabel = [[UILabel alloc]init];
    self.backLabel.backgroundColor = HBSColor(244, 244, 243);
    self.backLabel.frame = CGRectMake(0, 108, WIDTH, 5);
    [self.view addSubview:self.backLabel];
    //添加标题
    NSArray *titles = @[@"商铺", @"婚品", @"服务", @"案例"];
    NSUInteger count = titles.count;
    CGFloat titleButtonW = self.titlesView.WSJ_width/count;
    CGFloat titleButtnH = self.titlesView.WSJ_height;
    for (NSUInteger i = 0 ; i < count; i++) {
        
        HBSTitleButton *titleButton = [HBSTitleButton buttonWithType:UIButtonTypeCustom];
        titleButton.titleLabel.font = FONT(15);
        titleButton.tag = i;
        [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titlesView addSubview:titleButton];
        //设置数据
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
        //设置frame
        titleButton.frame = CGRectMake(i *titleButtonW, 0, titleButtonW, titleButtnH);
        //设置按钮的颜色(对应方法里的方法)
        [titleButton setTitleColor:HEISE forState:UIControlStateNormal];
        [titleButton setTitleColor:FENSE forState:UIControlStateSelected];
        
    }
    //按钮选中的颜色
    HBSTitleButton *firstTitleButton = self.titlesView.subviews.firstObject;
    //底部指示器(字下面的红条)
    self.indicatorView = [[UIView alloc]init];
    self.indicatorView.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
    self.indicatorView.WSJ_height = 2;
    self.indicatorView.WSJ_y = self.titlesView.WSJ_height - self.indicatorView.WSJ_height;
    [self.titlesView addSubview:self.indicatorView];
    
    //立刻根据文字的内容计算label的宽度
    [firstTitleButton.titleLabel sizeToFit];
    self.indicatorView.WSJ_width = firstTitleButton.titleLabel.WSJ_width;
    self.indicatorView.WSJ_centerX = firstTitleButton.WSJ_centerX;
    //默认情况下:选中最前面的标题栏
    [self titleClick:firstTitleButton];
    
}
#pragma mark----监听标题button的点击事件
- (void)titleClick:(HBSTitleButton *)titleButton{
    
    //控制按钮的实现状态方法
    self.selectedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.selectedTitleButton = titleButton;
    //指示器--->动画
    [UIView animateWithDuration:0.25 animations:^{
       
        //文字宽度和指示器的宽度一样大
        self.indicatorView.WSJ_width = titleButton.titleLabel.WSJ_width + 20;
        self.indicatorView.WSJ_centerX = titleButton.WSJ_centerX;
        
    }];
    
    //让scroView滚动到相应的位置
    CGPoint offSet = self.scrollview.contentOffset;
    offSet.x = titleButton.tag *self.scrollview.WSJ_width;
    [self.scrollview setContentOffset:offSet animated:YES];
    
}
#pragma mark---添加子控制器的view
- (void)addChildView{
    
    NSUInteger index = self.scrollview.contentOffset.x /self.scrollview.WSJ_width;
    UIViewController *childVC = self.childViewControllers[index];
    if ([childVC isViewLoaded]) return;
    childVC.view.frame = CGRectMake(self.scrollview.bounds.origin.x, self.scrollview.bounds.origin.y, self.scrollview.bounds.size.width, self.scrollview.bounds.size.height);
    [self.scrollview addSubview:childVC.view];
}
#pragma mark----<UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    [self addChildView];
}
//在scrollView滚动动画结束时,就会调用这个方法
//前提是:人为拖拽scrollView产生的滚动动画
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    //选中对应的点击按钮
    NSUInteger index = scrollView.contentOffset.x/scrollView.WSJ_width;
   HBSTitleButton *titleButton = self.titlesView.subviews[index];
    [self titleClick:titleButton];
    
    //添加子控制器的view
    [self addChildView];
    
}
#pragma mark----箭头image返回方法
- (void)clickImage{
    
    [self.navigationController popViewControllerAnimated:YES];
    [self.tabBarController.tabBar setHidden:NO];
    
}
@end
