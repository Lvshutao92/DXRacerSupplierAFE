//
//  MainTabbarViewController.m
//  DXRacerSupplierAFE
//
//  Created by ilovedxracer on 2017/10/16.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//
#import "MainTabbarViewController.h"
#import "OrderList_ViewController.h"
#import "ThreeViewController.h"
@interface MainTabbarViewController ()

@end

@implementation MainTabbarViewController
- (instancetype)init {
    if (self = [super init]) {
        ShouYeViewController *oneVc = [[ShouYeViewController alloc]init];
        MainNavigationViewController *mainoneVC = [[MainNavigationViewController alloc]initWithRootViewController:oneVc];
        mainoneVC.title = @"主页";
        oneVc.navigationItem.title = @"";
        mainoneVC.tabBarItem.image = [UIImage imageNamed:@"sy"];
        mainoneVC.tabBarItem.selectedImage = [UIImage imageNamed:@"sy"];
        
        
        
//        OrderList_ViewController *twoVc = [[OrderList_ViewController alloc]init];
//        MainNavigationViewController *maintwoVC = [[MainNavigationViewController alloc]initWithRootViewController:twoVc];
//        twoVc.title = @"订单";
//        maintwoVC.tabBarItem.image = [UIImage imageNamed:@"tabbar2"];
//        maintwoVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar02"];
        
        
        
        
        ThreeViewController *threeVc = [[ThreeViewController alloc]init];
        MainNavigationViewController *mainthreeVC = [[MainNavigationViewController alloc]initWithRootViewController:threeVc];
        threeVc.title = @"公告";
        mainthreeVC.tabBarItem.image = [UIImage imageNamed:@"notice"];
        mainthreeVC.tabBarItem.selectedImage = [UIImage imageNamed:@"notice"];
        
        self.tabBar.tintColor = RGBACOLOR(32.0, 157.0, 149.0, 1.0);
        self.viewControllers = @[mainoneVC,mainthreeVC];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}
@end

