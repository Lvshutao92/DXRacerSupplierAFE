//
//  SearchViewController.m
//  DXRacerSupplierAFE
//
//  Created by ilovedxracer on 2017/10/19.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "SearchViewController.h"

#import "DDGL_list_Cell.h"

#import "Model2.h"
#import "Model1.h"
#import "Order_6_3_TableViewController.h"
#import "OrderListDetailsTableViewController.h"
#import "YuYueFahuoViewController.h"

#import "Order_09_Cell.h"
#import "InvioceModel.h"
#import "InvioceModel1.h"
#import "WanJiaoHuoTableViewController.h"
#import <sys/utsname.h>
@interface SearchViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
     UIImageView *img;
    
}
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UISearchBar *searchbar;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBACOLOR(235, 239, 241, 1);img = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, 200, 200, 200)];
    img.image = [UIImage imageNamed:@"noinformation"];
    [self.view addSubview:img];
    _searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    _searchbar.delegate = self;
    _searchbar.searchBarStyle = UISearchBarStyleMinimal;
    _searchbar.placeholder = @"请输入订单编号";
    
    [_searchbar setImage:[UIImage imageNamed:@"sousuo"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
//    _searchbar.contentMode  = UIViewContentModeScaleAspectFit;
    _searchbar.tintColor = [UIColor whiteColor];
    
    
    
    UITextField *searchField = [_searchbar valueForKey:@"_searchField"];
    //改变searcher的textcolor
    searchField.textColor=[UIColor whiteColor];
    //改变placeholder的颜色
    [searchField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    // searchBar光标颜色
    [[[self.searchbar.subviews objectAtIndex:0].subviews objectAtIndex:1] setTintColor:[UIColor whiteColor]];
    self.navigationItem.titleView = _searchbar;
    
    NSString* phoneModel = [self iphoneType];//方法在下面
    if ([phoneModel isEqualToString:@"iPhone 8Plus"]) {
        self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }else{
        self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
   
//   NSLog(@"%@",phoneModel);

    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"DDGL_list_Cell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    [self.tableview registerNib:[UINib nibWithNibName:@"DDGL_list_Cell" bundle:nil] forCellReuseIdentifier:@"cell2"];
    [self.tableview registerNib:[UINib nibWithNibName:@"DDGL_list_Cell" bundle:nil] forCellReuseIdentifier:@"cell3"];
    [self.view addSubview:self.tableview];
    self.tableview.backgroundColor = RGBACOLOR(235, 239, 241, 1);
    
    
    
    UIView *vi = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    vi.backgroundColor = RGBACOLOR(235, 239, 241, 1);
    self.tableview.tableHeaderView = vi;
    
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Model1 *model = [self.dataArray objectAtIndex:indexPath.row];
    if ([model.status isEqualToString:@"created"]) {
        Order_6_3_TableViewController *order = [[Order_6_3_TableViewController alloc]init];
        order.purchaseOrderId = model.id;
        [self.navigationController pushViewController:order animated:YES];
    }
    else if ([model.status isEqualToString:@"confirmed"]){
        Order_6_3_TableViewController *order = [[Order_6_3_TableViewController alloc]init];
        order.purchaseOrderId = model.id;
        [self.navigationController pushViewController:order animated:YES];
    }
    else if ([model.status isEqualToString:@"finished"]){
        OrderListDetailsTableViewController *order = [[OrderListDetailsTableViewController alloc]init];
        order.purchaseOrderId = model.id;
        [self.navigationController pushViewController:order animated:YES];
    }
    else if ([model.status isEqualToString:@"returned"]){
        Order_6_3_TableViewController *order = [[Order_6_3_TableViewController alloc]init];
        order.purchaseOrderId = model.id;
        [self.navigationController pushViewController:order animated:YES];
    }
    else if ([model.status isEqualToString:@"canceled"]){
        Order_6_3_TableViewController *order = [[Order_6_3_TableViewController alloc]init];
        order.purchaseOrderId = model.id;
        [self.navigationController pushViewController:order animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    Model1 *model = [self.dataArray objectAtIndex:indexPath.row];
    if ([model.status isEqualToString:@"created"]) {
        return 175;
    }
    else if ([model.status isEqualToString:@"confirmed"]){
        return 175;
    }
    else if ([model.status isEqualToString:@"finished"]){
        return 100;
    }
    else if ([model.status isEqualToString:@"returned"]){
        return 140;
    }
    else if ([model.status isEqualToString:@"canceled"]){
        return 140;
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Model1 *model = [self.dataArray objectAtIndex:indexPath.row];
    if ([model.status isEqualToString:@"created"]) {
        static NSString *identifierCell = @"cell1";
        DDGL_list_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
        if (cell == nil) {
            cell = [[DDGL_list_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = RGBACOLOR(230, 236, 240, 1);
        
        
        
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
        cell.lab3.text  = model.planProductionDate;
        
        
        cell.lab4.hidden = YES;
        cell.lab0.hidden = YES;
        
        
        if ([model.status isEqualToString:@"finished"] || [model.status isEqualToString:@"returned"] || [model.status isEqualToString:@"caceled"] || [model.status isEqualToString:@"created"]) {
            cell.btn.hidden = YES;
            cell.btnwidth.constant = 0;
            cell.btn_btn1_juli.constant = 0;
        }else{
            cell.btn.hidden = NO;
        }
        
        if ([model.status isEqualToString:@"finished"] || [model.status isEqualToString:@"returned"] || [model.status isEqualToString:@"caceled"] || [model.status isEqualToString:@"confirmed"]){
            cell.btn1.hidden = YES;
        }else{
            cell.btn1.hidden = NO;
        }
        
        [cell.btn1 addTarget:self action:@selector(clickBtnSure:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    if ([model.status isEqualToString:@"confirmed"]){
        static NSString *identifierCell = @"cell3";
        DDGL_list_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
        if (cell == nil) {
            cell = [[DDGL_list_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = RGBACOLOR(230, 236, 240, 1);
        
        
        
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
        cell.lab3.text  = model.planProductionDate;
        
        
        cell.lab4.hidden = YES;
        cell.lab0.hidden = YES;
        
        
        if ([model.status isEqualToString:@"finished"] || [model.status isEqualToString:@"returned"] || [model.status isEqualToString:@"caceled"] || [model.status isEqualToString:@"created"]) {
            cell.btn.hidden = YES;
            cell.btnwidth.constant = 0;
            cell.btn_btn1_juli.constant = 0;
        }else{
            cell.btn.hidden = NO;
        }
        
        if ([model.status isEqualToString:@"finished"] || [model.status isEqualToString:@"returned"] || [model.status isEqualToString:@"caceled"] || [model.status isEqualToString:@"confirmed"]){
            cell.btn1.hidden = YES;
        }else{
            cell.btn1.hidden = NO;
        }
        
        [cell.btn addTarget:self action:@selector(clickBtnSend:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    if ([model.status isEqualToString:@"finished"]){
        static NSString *identifierCell = @"cell1";
        DDGL_list_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
        if (cell == nil) {
            cell = [[DDGL_list_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = RGBACOLOR(230, 236, 240, 1);
        
        
        
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
        //    cell.lab3.text  = model.planProductionDate;
        
        
        cell.lab4.hidden = YES;
        cell.lab0.hidden = YES;
        
        cell.lab3.hidden = YES;
        cell.lab00.hidden = YES;
        
        cell.btn.hidden = YES;
        
        cell.btn1.hidden = YES;
        return cell;
    }
    if ([model.status isEqualToString:@"returned"]){
        static NSString *identifierCell = @"cell2";
        DDGL_list_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
        if (cell == nil) {
            cell = [[DDGL_list_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = RGBACOLOR(230, 236, 240, 1);
        
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
        cell.lab3.text  = model.returnTime;
        
        cell.lab4.hidden = YES;
        cell.lab0.hidden = YES;
        
        cell.lab00.text = @"退货时间：";
        
        cell.btn.hidden = YES;
        
        cell.btn1.hidden = YES;
        return cell;
    }
    static NSString *identifierCell = @"cell2";
    DDGL_list_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[DDGL_list_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor = RGBACOLOR(230, 236, 240, 1);
    
    cell.view.layer.borderWidth = 1.0f;
    cell.view.layer.borderColor = [UIColor colorWithWhite:.8 alpha:.3].CGColor;
    cell.view.layer.shadowColor = [UIColor colorWithWhite:.5 alpha:.3].CGColor;
    cell.view.layer.shadowOpacity = 0.8f;
    cell.view.layer.shadowRadius = 5.0;
    cell.view.layer.shadowOffset = CGSizeMake(0, 1);
    
    
    LRViewBorderRadius(cell.btn, 10, 1, RGBACOLOR(72, 168, 161, 1));
    LRViewBorderRadius(cell.btn1, 10, 1, RGBACOLOR(72, 168, 161, 1));
    
    Model1 *models = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.lab1.text  = models.purchaseOrderNo;
    
    cell.lab2.text  = [Manager jinegeshi:models.totalAmount];
    cell.lab3.text  = models.cancelTime;
    
    cell.lab4.hidden = YES;
    cell.lab0.hidden = YES;
    
    cell.lab00.text = @"取消时间：";
    
    
    cell.btn.hidden = YES;
    
    cell.btn1.hidden = YES;
    return cell;
}

- (void)clickBtnSend:(UIButton *)sender{
    DDGL_list_Cell *cell = (DDGL_list_Cell *)[[sender.superview superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    Model1 *model = [self.dataArray objectAtIndex:indexpath.row];
    if (![model.status isEqualToString:@"confirmed"]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"只有已确认订单才可预约发货" message:@"温馨提示" preferredStyle:1];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        YuYueFahuoViewController *yuyue = [[YuYueFahuoViewController alloc]init];
        yuyue.str = model.purchaseOrderNo;
        yuyue.idstr = model.id;
        
        MainTabbarViewController *tabBarVc = (MainTabbarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        MainNavigationViewController *Nav = [tabBarVc selectedViewController];
        [Nav pushViewController:yuyue animated:YES];
    }
}
- (void)clickBtnSure:(UIButton *)sender{
    DDGL_list_Cell *cell = (DDGL_list_Cell *)[[sender.superview superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    Model1 *model = [self.dataArray objectAtIndex:indexpath.row];
    if (![model.status isEqualToString:@"created"]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"只有待确认订单才可确认" message:@"温馨提示" preferredStyle:1];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认采购单？" message:@"温馨提示" preferredStyle:1];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self lodsure:model.id];
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
}



- (void)lodsure:(NSString *)idstr{
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    NSString *path = [documents stringByAppendingPathComponent:@"userName.text"];
    NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"id":idstr,
            @"username":str,
            };
    [session POST:KURLNSString(@"servlet/purchase/purchaseorder/suppliercheck") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        if ([[dic objectForKey:@"result_code"] isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"采购单已确认，请尽快发货" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf setUpReflash:str];
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认失败" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}



//刷新数据
-(void)setUpReflash:(NSString *)str
{
    __weak typeof (self) weakSelf = self;
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loddeList:str];
    }];
    [self.tableview.mj_header beginRefreshing];
    self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (self.dataArray.count == totalnum) {
            [self.tableview.mj_footer setState:MJRefreshStateNoMoreData];
        }else {
            [weakSelf loddeSLList:str];
        }
    }];
}
- (void)loddeList:(NSString *)str{
    [self.tableview.mj_footer endRefreshing];
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    page = 1;
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"page":[NSString stringWithFormat:@"%ld",page],
            @"purchaseOrderNo":str,
            @"supplierId":[Manager redingwenjianming:@"supplierId.text"],
            @"status":self.status,
            @"sorttype":self.sorttype,
            @"sort":self.sort,
            @"delay":self.delay,
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
- (void)loddeSLList:(NSString *)str{
    [self.tableview.mj_header endRefreshing];
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"page":[NSString stringWithFormat:@"%ld",page],
            @"purchaseOrderNo":str,
            @"supplierId":[Manager redingwenjianming:@"supplierId.text"],
            @"status":self.status,
            @"sorttype":self.sorttype,
            @"sort":self.sort,
            @"delay":self.delay,
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



- (void)viewWillAppear:(BOOL)animated{
    [self.searchbar becomeFirstResponder];
}
#pragma mark --searchBar delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [self setUpReflash:searchBar.text];
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;
    return YES;
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = NO;
    [searchBar resignFirstResponder];
}


- (NSString*)iphoneType {
    
    //需要导入头文件：#import <sys/utsname.h>
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString*platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if([platform isEqualToString:@"iPhone1,1"])  return@"iPhone 2G";
    
    if([platform isEqualToString:@"iPhone1,2"])  return@"iPhone 3G";
    
    if([platform isEqualToString:@"iPhone2,1"])  return@"iPhone 3GS";
    
    if([platform isEqualToString:@"iPhone3,1"])  return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,2"])  return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,3"])  return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone4,1"])  return@"iPhone 4S";
    
    if([platform isEqualToString:@"iPhone5,1"])  return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,2"])  return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,3"])  return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone5,4"])  return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone6,1"])  return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone6,2"])  return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone7,1"])  return@"iPhone 6 Plus";
    
    if([platform isEqualToString:@"iPhone7,2"])  return@"iPhone 6";
    
    if([platform isEqualToString:@"iPhone8,1"])  return@"iPhone 6s";
    
    if([platform isEqualToString:@"iPhone8,2"])  return@"iPhone 6s Plus";
    
    if([platform isEqualToString:@"iPhone8,4"])  return@"iPhone SE";
    
    if([platform isEqualToString:@"iPhone9,1"])  return@"iPhone 7";
    
    if([platform isEqualToString:@"iPhone9,2"])  return@"iPhone 7 Plus";
    
    if([platform isEqualToString:@"iPhone10,1"]) return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,4"]) return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,2"]) return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,5"]) return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,3"]) return@"iPhone X";
    
    if([platform isEqualToString:@"iPhone10,6"]) return@"iPhone X";
    
    if([platform isEqualToString:@"iPod1,1"])  return@"iPod Touch 1G";
    
    if([platform isEqualToString:@"iPod2,1"])  return@"iPod Touch 2G";
    
    if([platform isEqualToString:@"iPod3,1"])  return@"iPod Touch 3G";
    
    if([platform isEqualToString:@"iPod4,1"])  return@"iPod Touch 4G";
    
    if([platform isEqualToString:@"iPod5,1"])  return@"iPod Touch 5G";
    
    if([platform isEqualToString:@"iPad1,1"])  return@"iPad 1G";
    
    if([platform isEqualToString:@"iPad2,1"])  return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,2"])  return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,3"])  return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,4"])  return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,5"])  return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad2,6"])  return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad2,7"])  return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad3,1"])  return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,2"])  return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,3"])  return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,4"])  return@"iPad 4";
    
    if([platform isEqualToString:@"iPad3,5"])  return@"iPad 4";
    
    if([platform isEqualToString:@"iPad3,6"])  return@"iPad 4";
    
    if([platform isEqualToString:@"iPad4,1"])  return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,2"])  return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,3"])  return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,4"])  return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,5"])  return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,6"])  return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,7"])  return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad4,8"])  return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad4,9"])  return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad5,1"])  return@"iPad Mini 4";
    
    if([platform isEqualToString:@"iPad5,2"])  return@"iPad Mini 4";
    
    if([platform isEqualToString:@"iPad5,3"])  return@"iPad Air 2";
    
    if([platform isEqualToString:@"iPad5,4"])  return@"iPad Air 2";
    
    if([platform isEqualToString:@"iPad6,3"])  return@"iPad Pro 9.7";
    
    if([platform isEqualToString:@"iPad6,4"])  return@"iPad Pro 9.7";
    
    if([platform isEqualToString:@"iPad6,7"])  return@"iPad Pro 12.9";
    
    if([platform isEqualToString:@"iPad6,8"])  return@"iPad Pro 12.9";
    
    if([platform isEqualToString:@"i386"])  return@"iPhone Simulator";
    
    if([platform isEqualToString:@"x86_64"])  return@"iPhone Simulator";
    
    return platform;
    
}


@end
