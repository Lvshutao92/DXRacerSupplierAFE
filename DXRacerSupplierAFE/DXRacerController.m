//
//  DXRacerController.m
//  DXRacerSupplierAFE
//
//  Created by ilovedxracer on 2017/12/22.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "DXRacerController.h"

#import "DXCompanyViewController.h"
#import "DXAddressViewController.h"
#import "DXContectViewController.h"
#import "DXBankInfoViewController.h"
#import "DXKaiPiaoInfoViewController.h"

#import "WaiTableViewCell.h"
@interface DXRacerController ()
@property(nonatomic,strong)NSMutableArray *arr;
@property(nonatomic,strong)NSMutableArray *imgarr;

@property(nonatomic,strong)NSMutableArray *arr1;
@property(nonatomic,strong)NSMutableArray *imgarr1;
@end

@implementation DXRacerController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"迪锐克斯";
    
    
    self.arr = [@[@"公司信息",@"地址",@"联系人",@"银行信息"]mutableCopy];
    self.imgarr = [@[@"gsxx",@"dz",@"lianxiren",@"yhxx"]mutableCopy];
    
    self.arr1    = [@[@"开票信息"]mutableCopy];
    self.imgarr1 = [@[@"kpxx"]mutableCopy];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"WaiTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    UIView *vie = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    self.tableView.tableFooterView = vie;
    self.tableView.backgroundColor = RGBACOLOR(235, 239, 241, 1);
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    if (section == 1) {
        view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 15);
        view.backgroundColor = RGBACOLOR(235, 239, 241, 1);
    }
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 15;
    }
    return 0;
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.arr.count;
    }
    return self.arr1.count;
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
    cell.lab.text = self.arr1[indexPath.row];
    cell.img.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.imgarr1[indexPath.row]]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WaiTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell.lab.text isEqualToString:@"公司信息"]) {
        DXCompanyViewController *kekaipiao = [[DXCompanyViewController alloc]init];
        kekaipiao.navigationItem.title = @"公司信息";
        [self.navigationController pushViewController:kekaipiao animated:YES];
    }
    if ([cell.lab.text isEqualToString:@"地址"]) {
        DXAddressViewController *kekaipiao = [[DXAddressViewController alloc]init];
        kekaipiao.navigationItem.title = @"地址";
        [self.navigationController pushViewController:kekaipiao animated:YES];
    }
    if ([cell.lab.text isEqualToString:@"联系人"]) {
        DXContectViewController *kekaipiao = [[DXContectViewController alloc]init];
        kekaipiao.navigationItem.title = @"联系人";
        [self.navigationController pushViewController:kekaipiao animated:YES];
    }
    if ([cell.lab.text isEqualToString:@"银行信息"]) {
        DXBankInfoViewController *kekaipiao = [[DXBankInfoViewController alloc]init];
        kekaipiao.navigationItem.title = @"银行信息";
        [self.navigationController pushViewController:kekaipiao animated:YES];
    }
    if ([cell.lab.text isEqualToString:@"开票信息"]) {
        DXKaiPiaoInfoViewController *kekaipiao = [[DXKaiPiaoInfoViewController alloc]init];
        kekaipiao.navigationItem.title = @"开票信息";
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
