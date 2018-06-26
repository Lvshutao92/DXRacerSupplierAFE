//
//  SearchKekaipiaoViewController.m
//  DXRacerSupplierAFE
//
//  Created by ilovedxracer on 2017/10/26.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "SearchKekaipiaoViewController.h"
#import "Invioce_5_Cell.h"
#import "Model.h"
#import "Model2.h"
#import "Order_6_3_TableViewController.h"
@interface SearchKekaipiaoViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
}
@property(nonatomic,strong)UITableView    *tableview;
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation SearchKekaipiaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"可开票订单";
   
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"Invioce_5_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    if (self.purchaseOrderNo == nil) {
        self.purchaseOrderNo = @"";
    }
    if (self.sendBeginTime == nil) {
        self.sendBeginTime = @"";
    }
    if (self.sendEndTime == nil) {
        self.sendEndTime = @"";
    }
    
    
    [self setUpReflash];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 205;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Order_6_3_TableViewController *details = [[Order_6_3_TableViewController alloc]init];
    details.navigationItem.title = @"详情";
    Model *model = [self.dataArray objectAtIndex:indexPath.row];
    details.purchaseOrderId = model.id;
    [self.navigationController pushViewController:details animated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    Invioce_5_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[Invioce_5_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Model *model = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.lab1.text = [NSString stringWithFormat:@"订单编号：%@",model.purchaseOrderNo];
    cell.lab2.text = [NSString stringWithFormat:@"入库单号：%@",model.stockInOrderNo];
    cell.lab3.text = [NSString stringWithFormat:@"预约送货时间：%@",model.sendTime];
    
    
    if ([model.status isEqualToString:@"created"]) {
        cell.lab5.textColor = RGBACOLOR(227, 154, 70, 1);
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:@"状态：待确认"];
        NSRange range = NSMakeRange(0, 3);
        [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
        [cell.lab5 setAttributedText:noteStr];
    }else if ([model.status isEqualToString:@"confirmed"]) {
        cell.lab5.textColor = RGBACOLOR(55, 154, 254, 1);
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:@"状态：已确认"];
        NSRange range = NSMakeRange(0, 3);
        [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
        [cell.lab5 setAttributedText:noteStr];
    }else if ([model.status isEqualToString:@"finished"]) {
        cell.lab5.textColor = RGBACOLOR(0, 157, 147, 1.0);
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:@"状态：已入库"];
        NSRange range = NSMakeRange(0, 3);
        [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
        [cell.lab5 setAttributedText:noteStr];
    }else if ([model.status isEqualToString:@"returned"]) {
        cell.lab5.textColor = RGBACOLOR(249, 76, 82, 1);
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:@"状态：已退货"];
        NSRange range = NSMakeRange(0, 3);
        [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
        [cell.lab5 setAttributedText:noteStr];
    }else if ([model.status isEqualToString:@"canceled"]) {
        cell.lab5.textColor = RGBACOLOR(113, 113, 113, 1);
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:@"状态：已取消"];
        NSRange range = NSMakeRange(0, 3);
        [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
        [cell.lab5 setAttributedText:noteStr];
    }
    
    cell.lab4.textColor = [UIColor redColor];
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"总金额（元）：%@",[Manager jinegeshi:model.totalAmount]]];
    NSRange range = NSMakeRange(0, 7);
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
    [cell.lab4 setAttributedText:noteStr];
    cell.lines.hidden= YES;
    cell.btn.hidden= YES;
    return cell;
}

//刷新数据
-(void)setUpReflash
{
    __weak typeof (self) weakSelf = self;
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loddeList];
    }];
    [self.tableview.mj_header beginRefreshing];
    self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (self.dataArray.count == totalnum) {
            [self.tableview.mj_footer setState:MJRefreshStateNoMoreData];
        }else {
            [weakSelf loddeSLList];
        }
    }];
}
- (void)loddeList{
    [self.tableview.mj_footer endRefreshing];
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    page = 1;
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"page":[NSString stringWithFormat:@"%ld",page],
            @"status":@"finished",
            @"supplierId":[Manager redingwenjianming:@"supplierId.text"],
            @"isApplyPayment":@"N",
            @"purchaseOrderType":self.type,
            @"purchaseOrderNo":self.purchaseOrderNo,
            @"sendBeginTime":self.sendBeginTime,
            @"sendEndTime":self.sendEndTime,
            
             @"stockInDays":[Manager sharedManager].stockInDays,
            };
    [session POST:KURLNSString(@"servlet/purchase/purchaseorder/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //NSLog(@"%@",dic);
        totalnum = [[dic objectForKey:@"total"] integerValue];
        [weakSelf.dataArray removeAllObjects];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        for (NSDictionary *dict in arr) {
            Model *model = [Model mj_objectWithKeyValues:dict];
            
            Model2 *model2 = [Model2 mj_objectWithKeyValues:model.supplierInfo];
            model.supplierInfoModel = model2;
            
            [weakSelf.dataArray addObject:model];
        }
        page = 2;
        [weakSelf.tableview reloadData];
        [weakSelf.tableview.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.tableview.mj_header endRefreshing];
    }];
}
- (void)loddeSLList{
    [self.tableview.mj_header endRefreshing];
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"page":[NSString stringWithFormat:@"%ld",page],
            @"status":@"finished",
            @"supplierId":[Manager redingwenjianming:@"supplierId.text"],
            @"isApplyPayment":@"N",
            @"purchaseOrderType":self.type,
            @"purchaseOrderNo":self.purchaseOrderNo,
            @"sendBeginTime":self.sendBeginTime,
            @"sendEndTime":self.sendEndTime,
            
             @"stockInDays":[Manager sharedManager].stockInDays,
            };
    [session POST:KURLNSString(@"servlet/purchase/purchaseorder/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        NSMutableArray *arr = [[diction objectForKey:@"rows"] objectForKey:@"resultList"];
        for (NSDictionary *dict in arr) {
            Model *model = [Model mj_objectWithKeyValues:dict];
            
            Model2 *model2 = [Model2 mj_objectWithKeyValues:model.supplierInfo];
            model.supplierInfoModel = model2;
            
            [weakSelf.dataArray addObject:model];
        }
        page++;
        [weakSelf.tableview reloadData];
        [weakSelf.tableview.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.tableview.mj_footer endRefreshing];
    }];
}



- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}
@end
