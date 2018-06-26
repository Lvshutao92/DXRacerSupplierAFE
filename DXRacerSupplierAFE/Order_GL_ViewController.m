//
//  Order_GL_ViewController.m
//  DXRacerSupplierAFE
//
//  Created by ilovedxracer on 2017/10/18.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "Order_GL_ViewController.h"
#import "SGTopScrollMenu.h"
//#import "OrderListViewController.h"
#import "ConfirmeViewController.h"
#import "ConfirmedViewController.h"
#import "YiRuKuViewController.h"
#import "YiTuiHuoViewController.h"
#import "CanceledViewController.h"
#import "SearchViewController.h"
#import "WanJiaoHuoViewController.h"
#import "OrderList_ViewController.h"
@interface Order_GL_ViewController ()<SGTopScrollMenuDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) SGTopScrollMenu *topScrollMenu;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) NSArray *titles;

@end

@implementation Order_GL_ViewController
- (void)viewWillDisappear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"订单管理";
    
    self.view.backgroundColor = RGBACOLOR(235, 239, 241, 1);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    // 1.添加所有子控制器
    [self setupChildViewController];
    CGFloat height;
    if ([[[Manager sharedManager] iphoneType] isEqualToString:@"iPhone X"]) {
        height = 88;
    }else{
        height = 64;
    }
    
    self.titles = @[@"订单列表",@"待确认", @"已确认", @"已入库", @"已退货", @"已取消",@"晚交货"];
    
    self.topScrollMenu = [SGTopScrollMenu topScrollMenuWithFrame:CGRectMake(0, height, self.view.frame.size.width, 44)];
    self.topScrollMenu.backgroundColor = RGBACOLOR(230, 236, 240, 1);
    _topScrollMenu.titlesArr = [NSArray arrayWithArray:_titles];
    _topScrollMenu.topScrollMenuDelegate = self;
    [self.view addSubview:_topScrollMenu];
    
    
    
 
    
    
    // 创建底部滚动视图
    self.mainScrollView = [[UIScrollView alloc] init];
    _mainScrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width * _titles.count, 0);
    _mainScrollView.backgroundColor = [UIColor clearColor];
    // 开启分页
    _mainScrollView.pagingEnabled = YES;
    // 没有弹簧效果
    _mainScrollView.bounces = NO;
    // 隐藏水平滚动条
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    // 设置代理
    _mainScrollView.delegate = self;
    
    _mainScrollView.scrollEnabled = YES;
    [self.view addSubview:_mainScrollView];

    
    OrderList_ViewController *oneVC = [[OrderList_ViewController alloc] init];
    [self.mainScrollView addSubview:oneVC.view];
    
    
    [self.view insertSubview:_mainScrollView belowSubview:_topScrollMenu];
    
    
    NSDictionary *dict = [[NSDictionary alloc]init];
    NSNotification *notification =[NSNotification notificationWithName:@"viewappear" object:nil userInfo:dict];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
    UIBarButtonItem *bars = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(clicksearch)];
    self.navigationItem.rightBarButtonItem = bars;
}


- (void)clicksearch{
    if ([Manager sharedManager].searchIndex == 0) {
        NSDictionary *dict = [[NSDictionary alloc]init];
        NSNotification *notification =[NSNotification notificationWithName:@"searchIndex=0" object:nil userInfo:dict];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
    }else if ([Manager sharedManager].searchIndex == 6) {
        NSDictionary *dict = [[NSDictionary alloc]init];
        NSNotification *notification =[NSNotification notificationWithName:@"searchIndex=last" object:nil userInfo:dict];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
    }else{
        SearchViewController *search = [[SearchViewController alloc]init];
        search.navigationItem.backBarButtonItem.title = @"返回";
        
        if ([Manager sharedManager].searchIndex == 1) {
            search.status = @"created";
            search.sorttype = @"asc";
            search.sort = @"planProductionDate";
            search.delay = @"";
        }
        if ([Manager sharedManager].searchIndex == 2) {
            search.status = @"confirmed";
            search.sorttype = @"asc";
            search.sort = @"planProductionDate";
            search.delay = @"";
        }
        if ([Manager sharedManager].searchIndex == 3) {
            search.status = @"finished";
            search.sorttype = @"asc";
            search.sort = @"planProductionDate";
            search.delay = @"";
        }
        if ([Manager sharedManager].searchIndex == 4) {
            search.status = @"returned";
            search.sorttype = @"asc";
            search.sort = @"planProductionDate";
            search.delay = @"";
        }
        if ([Manager sharedManager].searchIndex == 5) {
            search.status = @"canceled";
            search.sorttype = @"asc";
            search.sort = @"planProductionDate";
            search.delay = @"";
        }
        [self.navigationController pushViewController:search animated:YES];
    }
    
    
    
    
}

- (void)SGTopScrollMenu:(SGTopScrollMenu *)topScrollMenu didSelectTitleAtIndex:(NSInteger)index{
    
    
    // 1 计算滚动的位置
    CGFloat offsetX = index * self.view.frame.size.width;
    self.mainScrollView.contentOffset = CGPointMake(offsetX, 0);
    //2.给对应位置添加对应子控制器
    [self showVc:index];
}

// 添加所有子控制器
- (void)setupChildViewController {
    OrderList_ViewController *oneVC = [[OrderList_ViewController alloc] init];
    [self addChildViewController:oneVC];
    
    ConfirmeViewController *twoVC = [[ConfirmeViewController alloc] init];
    [self addChildViewController:twoVC];
    
    ConfirmedViewController *threeVC = [[ConfirmedViewController alloc] init];
    [self addChildViewController:threeVC];
    
    YiRuKuViewController *fourVC = [[YiRuKuViewController alloc] init];
    [self addChildViewController:fourVC];
    
    YiTuiHuoViewController *fiveVc = [[YiTuiHuoViewController alloc] init];
    [self addChildViewController:fiveVc];
    
    CanceledViewController *sixVC = [[CanceledViewController alloc] init];
    [self addChildViewController:sixVC];
    
    WanJiaoHuoViewController *sevenVC = [[WanJiaoHuoViewController alloc] init];
    [self addChildViewController:sevenVC];
}

// 显示控制器的view
- (void)showVc:(NSInteger)index {
    [Manager sharedManager].searchIndex = index;
    
    CGFloat offsetX = index * self.view.frame.size.width;
    
    UIViewController *vc = self.childViewControllers[index];
    
    // 判断控制器的view有没有加载过,如果已经加载过,就不需要加载
    if (vc.isViewLoaded) return;
    
    [self.mainScrollView addSubview:vc.view];
    vc.view.frame = CGRectMake(offsetX, 0, self.view.frame.size.width, self.view.frame.size.height);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    // 计算滚动到哪一页
    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
//    NSLog(@"-----%ld",index);
    [Manager sharedManager].searchIndex = index;
    
    
    
    // 1.添加子控制器view
    [self showVc:index];
    
    // 2.把对应的标题选中
    [[NSNotificationCenter defaultCenter] postNotificationName:@"change" object:@(index) userInfo:nil];
    
    // 2.把对应的标题选中
    UILabel *selLabel = self.topScrollMenu.allTitleLabel[index];
    
    [self.topScrollMenu selectLabel:selLabel];
    
    // 3.让选中的标题居中
    [self.topScrollMenu setupTitleCenter:selLabel];
}


@end
