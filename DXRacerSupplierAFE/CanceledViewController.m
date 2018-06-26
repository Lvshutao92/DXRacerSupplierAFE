//
//  CanceledViewController.m
//  DXRacerSupplierAFE
//
//  Created by ilovedxracer on 2017/10/18.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "CanceledViewController.h"
#import "DDGL_list_Cell.h"
#import "Model1.h"
#import "Model2.h"
#import "Order_6_3_TableViewController.h"
@interface CanceledViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
    
    UIImageView *img;
}
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation CanceledViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBACOLOR(230, 236, 240, 1);img = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, 200, 200, 200)];
    img.image = [UIImage imageNamed:@"noinformation"];
    [self.view addSubview:img];
    CGFloat height;
    if ([[[Manager sharedManager] iphoneType] isEqualToString:@"iPhone X"]) {
        height = 88;
    }else{
        height = 64;
    }
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, height+50, SCREEN_WIDTH, SCREEN_HEIGHT-110)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"DDGL_list_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    UIView *vi = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    vi.backgroundColor = [UIColor colorWithWhite:.87 alpha:.5];
    self.tableview.tableHeaderView = vi;
    [self setUpReflash];
    self.tableview.backgroundColor = RGBACOLOR(235, 239, 241, 1);
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 140;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    DDGL_list_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[DDGL_list_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    cell.contentView.backgroundColor = RGBACOLOR(235, 239, 241, 1);
    
    cell.view.layer.borderWidth = 1.0f;
    cell.view.layer.borderColor = [UIColor colorWithWhite:.8 alpha:.3].CGColor;
    cell.view.layer.shadowColor = [UIColor colorWithWhite:.5 alpha:.3].CGColor;
    cell.view.layer.shadowOpacity = 0.8f;
    cell.view.layer.shadowRadius = 5.0;
    cell.view.layer.shadowOffset = CGSizeMake(0, 1);
    
    
    LRViewBorderRadius(cell.btn, 10, 1, RGBACOLOR(72, 168, 161, 1));
    LRViewBorderRadius(cell.btn1, 10, 1, RGBACOLOR(72, 168, 161, 1));
    
    Model1 *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.lab1.text  = model.purchaseOrderNo;
    
    cell.lab2.text  = [Manager jinegeshi:model.totalAmount];
    cell.lab3.text  = model.cancelTime;
    
    cell.lab4.hidden = YES;
    cell.lab0.hidden = YES;
    
    cell.lab00.text = @"取消时间：";
    
   
    cell.btn.hidden = YES;
    
    cell.btn1.hidden = YES;
   
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Model1 *model = [self.dataArray objectAtIndex:indexPath.row];
    Order_6_3_TableViewController *order = [[Order_6_3_TableViewController alloc]init];
    order.purchaseOrderId = model.id;
    MainTabbarViewController *tabBarVc = (MainTabbarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    MainNavigationViewController *Nav = [tabBarVc selectedViewController];
    [Nav pushViewController:order animated:YES];
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
            @"status":@"canceled",
            @"supplierId":[Manager redingwenjianming:@"supplierId.text"],
            @"sorttype":@"asc",
            @"sort":@"planProductionDate",
            };
    [session POST:KURLNSString(@"servlet/purchase/purchaseorder/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //NSLog(@"%@",dic);
        totalnum = [[dic objectForKey:@"total"] integerValue];
        if (totalnum == 0) {
            [weakSelf.view bringSubviewToFront:img];
        }else{
            [weakSelf.view sendSubviewToBack:img];
        }
        [weakSelf.dataArray removeAllObjects];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        for (NSDictionary *dict in arr) {
            Model1 *model = [Model1 mj_objectWithKeyValues:dict];
            
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
            @"status":@"canceled",
            @"supplierId":[Manager redingwenjianming:@"supplierId.text"],
            @"sorttype":@"asc",
            @"sort":@"planProductionDate",
            };
    [session POST:KURLNSString(@"servlet/purchase/purchaseorder/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        NSMutableArray *arr = [[diction objectForKey:@"rows"] objectForKey:@"resultList"];
        for (NSDictionary *dict in arr) {
            Model1 *model = [Model1 mj_objectWithKeyValues:dict];
            
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
