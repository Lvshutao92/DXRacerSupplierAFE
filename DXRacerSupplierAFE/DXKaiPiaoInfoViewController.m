//
//  DXKaiPiaoInfoViewController.m
//  DXRacerSupplierAFE
//
//  Created by ilovedxracer on 2017/10/18.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "DXKaiPiaoInfoViewController.h"
#import "KP_Cell.h"
#import "Model.h"
#import "Model1.h"
@interface DXKaiPiaoInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
}
@property(nonatomic,strong)UITableView    *tableview;
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation DXKaiPiaoInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBACOLOR(230, 236, 240, 1);
   
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"KP_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableview.backgroundColor = RGBACOLOR(230, 236, 240, 1);
    [self.view addSubview:self.tableview];
    
    
    UIView *vi = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    vi.backgroundColor = RGBACOLOR(235, 239, 241, 1);
    self.tableview.tableHeaderView = vi;
    
    [self setUpReflash];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 450;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    Order_6_3_TableViewController *details = [[Order_6_3_TableViewController alloc]init];
    //    details.navigationItem.title = @"详情";
    //    Model *model = [self.dataArray objectAtIndex:indexPath.row];
    //    details.purchaseOrderId = model.id;
    //    [self.navigationController pushViewController:details animated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    KP_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[KP_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor = RGBACOLOR(230, 236, 240, 1);
    Model *model = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.lab1.text = model.companyName;
    
    cell.lab2.text = model.payerCode;
    cell.lab3.text = model.address;
    
//    cell.lab3.numberOfLines = 0;
//    cell.lab3.lineBreakMode = NSLineBreakByWordWrapping;
//    CGSize size = [cell.lab3 sizeThatFits:CGSizeMake(SCREEN_WIDTH-20, MAXFLOAT)];
//    cell.lab3height.constant = size.height;
//    height = size.height;
    
    cell.lab4.text = model.telephone;
    cell.lab5.text = model.bankName;
    cell.lab6.text = model.bankAccount;
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
            @"sorttype":@"asc",
            @"sort":@"undefined",
            };
    [session POST:KURLNSString(@"servlet/config/configinvoice/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//                NSLog(@"--------------%@",dic);
        totalnum = [[dic objectForKey:@"total"] integerValue];
        [weakSelf.dataArray removeAllObjects];
        if (![[dic objectForKey:@"rows"] isEqual:[NSNull null]]) {
            NSMutableArray *arr = [dic objectForKey:@"rows"] ;
            for (NSDictionary *dict in arr) {
                Model *model = [Model mj_objectWithKeyValues:dict];
               
                [weakSelf.dataArray addObject:model];
            }
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
            @"sorttype":@"asc",
            @"sort":@"undefined",
            };
    [session POST:KURLNSString(@"servlet/config/configinvoice/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
        if (![[dic objectForKey:@"rows"] isEqual:[NSNull null]]) {
            NSMutableArray *arr = [dic objectForKey:@"rows"] ;
            for (NSDictionary *dict in arr) {
                Model *model = [Model mj_objectWithKeyValues:dict];
                
                [weakSelf.dataArray addObject:model];
            }
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
