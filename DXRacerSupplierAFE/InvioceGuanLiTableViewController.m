//
//  InvioceGuanLiTableViewController.m
//  DXRacerSupplierAFE
//
//  Created by ilovedxracer on 2017/10/25.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "InvioceGuanLiTableViewController.h"
#import "KeKaiPiaoOrderViewController.h"
#import "MineInvioceViewController.h"
#import "KaiPiaoShuoMingViewController.h"
#import "WaiTableViewCell.h"
#import "KKP_ViewController.h"
#import "KeKaiPiaoOrderViewController.h"
#import "KeKaiPiao_1_OrderViewController.h"
#import "KeKaiPiao_2_OrderViewController.h"
#import "KeKaiPiao_3_OrderViewController.h"
@interface InvioceGuanLiTableViewController ()
@property(nonatomic,strong)NSMutableArray *arr;
@property(nonatomic,strong)NSMutableArray *imgarr;

@property(nonatomic,strong)NSMutableArray *arr1;
@property(nonatomic,strong)NSMutableArray *imgarr1;

@property(nonatomic,strong)NSMutableArray *arr2;
@property(nonatomic,strong)NSMutableArray *imgarr2;
@end

@implementation InvioceGuanLiTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发票管理";
    
    
    self.arr = [@[@"可开票订单"]mutableCopy];
    self.imgarr = [@[@"我的发票"]mutableCopy];
    
    self.arr1 = [@[@"我的发票"]mutableCopy];
    self.imgarr1 = [@[@"可开发票"]mutableCopy];
    
    self.arr2 = [@[@"开票说明"]mutableCopy];
    self.imgarr2 = [@[@"说明"]mutableCopy];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"WaiTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    UIView *vie = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    self.tableView.tableFooterView = vie;
    self.tableView.backgroundColor = RGBACOLOR(235, 239, 241, 1);
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 15);
    view.backgroundColor = RGBACOLOR(235, 239, 241, 1);
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.arr.count;
    }
    if (section == 1) {
        return self.arr1.count;
    }
    return self.arr2.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WaiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.img.contentMode = UIViewContentModeScaleAspectFit;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.section == 0) {
        cell.lab.text = self.arr[indexPath.row];
        cell.img.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.imgarr[indexPath.row]]];
        return cell;
    }
    if (indexPath.section == 1) {
        cell.lab.text = self.arr1[indexPath.row];
        cell.img.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.imgarr1[indexPath.row]]];
        return cell;
    }
    cell.lab.text = self.arr2[indexPath.row];
    cell.img.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.imgarr2[indexPath.row]]];
    return cell;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WaiTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell.lab.text isEqualToString:@"可开票订单"]) {
        KKP_ViewController *vc = [[KKP_ViewController alloc] initWithAddVCARY:@[[KeKaiPiaoOrderViewController new],[KeKaiPiao_1_OrderViewController new],[KeKaiPiao_2_OrderViewController new],[KeKaiPiao_3_OrderViewController new]] TitleS:@[@"批量订单",@"售后订单",@"现货订单",@"定制订单"]];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([cell.lab.text isEqualToString:@"我的发票"]) {
        MineInvioceViewController *kekaipiao = [[MineInvioceViewController alloc]init];
        [self.navigationController pushViewController:kekaipiao animated:YES];
    }
    if ([cell.lab.text isEqualToString:@"开票说明"]) {
        KaiPiaoShuoMingViewController *kekaipiao = [[KaiPiaoShuoMingViewController alloc]init];
        [self.navigationController pushViewController:kekaipiao animated:YES];
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
}
- (NSMutableArray *)arr{
    if (_arr == nil) {
        self.arr = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr;
}
- (NSMutableArray *)imgarr{
    if (_imgarr == nil) {
        self.imgarr = [NSMutableArray arrayWithCapacity:1];
    }
    return _imgarr;
}

- (NSMutableArray *)arr2{
    if (_arr2 == nil) {
        self.arr2 = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr2;
}
- (NSMutableArray *)imgarr2{
    if (_imgarr2 == nil) {
        self.imgarr2 = [NSMutableArray arrayWithCapacity:1];
    }
    return _imgarr2;
}

- (NSMutableArray *)arr1{
    if (_arr1 == nil) {
        self.arr1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr1;
}
- (NSMutableArray *)imgarr1{
    if (_imgarr1 == nil) {
        self.imgarr1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _imgarr1;
}
@end
