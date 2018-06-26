//
//  KeKaiPiaoOrderViewController.m
//  DXRacerSupplierAFE
//
//  Created by ilovedxracer on 2017/10/18.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "KeKaiPiaoOrderViewController.h"
#import "DDGL_list_Cell.h"
#import "Model.h"
#import "Model2.h"
#import "Order_6_3_TableViewController.h"
#import "KekaipiaoSearchViewController.h"
@interface KeKaiPiaoOrderViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
    NSString *str;
    
    UIView *window;
    UITextField *text1;
    
    UITextField *text2;
    UITextField *text3;
    
    UITextField *text4;
    UITextField *text5;
}
@property (nonatomic, strong)UIScrollView *BgView;




@property(nonatomic,strong)UITableView    *tableview;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation KeKaiPiaoOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =  RGBACOLOR(230, 236, 240, 1);
    str = @"PIA";
    
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-80)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"DDGL_list_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    self.tableview.backgroundColor = RGBACOLOR(235, 239, 241, 1);
    
    
    UIView *vi = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    vi.backgroundColor = [UIColor colorWithWhite:.87 alpha:.5];
    self.tableview.tableHeaderView = vi;
    
    [self setupButton];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PIA:) name:@"PIA" object:nil];
}
- (void)PIA:(NSNotification *)text {
    [self.view bringSubviewToFront:window];
    window.hidden = NO;
    text1.text = nil;
    text2.text = nil;
    text3.text = nil;
    text4.text = nil;
    text5.text = nil;
}

- (void)setupButton {
    window = [[UIView alloc] initWithFrame:CGRectMake(0, -10, SCREEN_WIDTH, SCREEN_HEIGHT)];
    window.backgroundColor = [UIColor colorWithWhite:.85 alpha:.5];
    window.alpha = 1.f;
    window.hidden = YES;
    
    
    self.BgView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 0)];
    self.BgView.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 80, 40)];
    lab1.text = @"订单编号";
    [self.BgView addSubview:lab1];
    
    text1 = [[UITextField alloc] initWithFrame:CGRectMake(10,50, SCREEN_WIDTH-20, 40)];
    text1.delegate = self;
    text1.placeholder = @"请输入订单编号";
    text1.borderStyle = UITextBorderStyleRoundedRect;
    [self.BgView addSubview: text1];
    
    
    
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, SCREEN_WIDTH-20, 40)];
    lab3.text = @"预约送货时间";
    [self.BgView addSubview:lab3];
    
    text2 = [[UITextField alloc] initWithFrame:CGRectMake(10, 145, SCREEN_WIDTH/2-25, 40)];
    text2.delegate = self;
    text2.borderStyle = UITextBorderStyleRoundedRect;
    text2.placeholder = @"开始时间";
    [self.BgView addSubview: text2];
    
    UILabel *l3 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-15, 145, 30, 40)];
    l3.text = @"-";
    l3.textAlignment = NSTextAlignmentCenter;
    [self.BgView addSubview:l3];
    
    
    text3 = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+15, 145, SCREEN_WIDTH/2-25, 40)];
    text3.delegate = self;
    text3.borderStyle = UITextBorderStyleRoundedRect;
    text3.placeholder = @"结束时间";
    [self.BgView addSubview: text3];
    
    
    
    
    UILabel *lab4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 195, SCREEN_WIDTH-20, 40)];
    lab4.text = @"入库时间";
    [self.BgView addSubview:lab4];
    
    text4 = [[UITextField alloc] initWithFrame:CGRectMake(10, 240, SCREEN_WIDTH/2-25, 40)];
    text4.delegate = self;
    text4.borderStyle = UITextBorderStyleRoundedRect;
    text4.placeholder = @"开始日期";
    [self.BgView addSubview: text4];
    
    
    UILabel *l4 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-15, 240, 30, 40)];
    l4.text = @"-";
    l4.textAlignment = NSTextAlignmentCenter;
    [self.BgView addSubview:l4];
    
    text5 = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+15, 240, SCREEN_WIDTH/2-25, 40)];
    text5.delegate = self;
    text5.borderStyle = UITextBorderStyleRoundedRect;
    text5.placeholder = @"结束日期";
    [self.BgView addSubview: text5];
    
    
    
    
    
    _BgView.frame = CGRectMake(0, 10, self.view.frame.size.width, SCREEN_HEIGHT-300);
    [window addSubview:_BgView];
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT-300, SCREEN_WIDTH/2, 50);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:btn];
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0,SCREEN_HEIGHT-299, SCREEN_WIDTH/2, 49);
    btn1.backgroundColor = [UIColor whiteColor];
    [btn1 setTitle:@"取消" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:btn1];
    
    
    UILabel *lin = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-300,SCREEN_WIDTH/2, 1)];
    lin.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
    [window addSubview:lin];
    
    [self.view addSubview:window];
    [self.view bringSubviewToFront:window];
    
    [self setUpReflash];
}

- (void)cancle{
    window.hidden = YES;
    text1.text = nil;
    text2.text = nil;
    text3.text = nil;
    text4.text = nil;
    text5.text = nil;
}

- (void)sure{
    [text1 resignFirstResponder];
        
    if (text1.text.length == 0) {
        text1.text = @"";
    }
    if (text2.text.length == 0) {
        text2.text = @"";
    }
    if (text3.text.length == 0) {
        text3.text = @"";
    }
    if (text4.text.length == 0) {
        text4.text = @"";
    }
    if (text5.text.length == 0) {
        text5.text = @"";
    }
    
    [self setUpReflash];
    window.hidden = YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:text2]) {
        [text1 resignFirstResponder];
        
        KSDatePicker *picker = [[KSDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 300)];
        picker.appearance.radius = 5;
        picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
            if (buttonType == KSDatePickerButtonCommit) {
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *str = [formatter stringFromDate:currentDate];
                text2.text = str;
            }
        };
        [window bringSubviewToFront:picker];
        [picker show];
        return NO;
    }
    if ([textField isEqual:text3]) {
        [text1 resignFirstResponder];
        
        KSDatePicker *picker = [[KSDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 300)];
        picker.appearance.radius = 5;
        picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
            if (buttonType == KSDatePickerButtonCommit) {
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *str = [formatter stringFromDate:currentDate];
                text3.text = str;
            }
        };
        [window bringSubviewToFront:picker];
        [picker show];
        return NO;
    }
    if ([textField isEqual:text4]) {
        [text1 resignFirstResponder];
        
        KSDatePicker *picker = [[KSDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 300)];
        picker.appearance.radius = 5;
        picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
            if (buttonType == KSDatePickerButtonCommit) {
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *str = [formatter stringFromDate:currentDate];
                text4.text = str;
            }
        };
        [window bringSubviewToFront:picker];
        [picker show];
        return NO;
    }
    if ([textField isEqual:text5]) {
        [text1 resignFirstResponder];
        
        KSDatePicker *picker = [[KSDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 300)];
        picker.appearance.radius = 5;
        picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
            if (buttonType == KSDatePickerButtonCommit) {
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *str = [formatter stringFromDate:currentDate];
                text4.text = str;
            }
        };
        [window bringSubviewToFront:picker];
        [picker show];
        return NO;
    }
    return YES;
}














- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 250;
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
    DDGL_list_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[DDGL_list_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor = RGBACOLOR(235, 239, 241, 1);
    cell.btn1.hidden = YES;
    cell.lab.hidden = NO;
    cell.lab5.hidden = NO;
    [cell.btn setTitle:@"申请开票" forState:UIControlStateNormal];
    cell.lab00width.constant = 110;
    cell.lab0width.constant = 110;
    cell.labwidth.constant = 110;
    cell.width1.constant = 110;
    cell.width2.constant = 110;
    
    
    Model *model = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.lab00.text = @"预约送货时间: ";
    cell.lab0.text = @"入库时间: ";
    cell.lab.text = @"状态： ";
    
    cell.lab1.text = model.purchaseOrderNo;
    cell.lab2.text = [Manager jinegeshi:model.totalAmount];
    cell.lab3.text = model.sendTime;
    cell.lab4.text = model.stockInTime;
    
    if ([model.status isEqualToString:@"created"]) {
        cell.lab5.textColor = RGBACOLOR(227, 154, 70, 1);
        cell.lab5.text = @"待确认";
    }else if ([model.status isEqualToString:@"confirmed"]) {
        cell.lab5.textColor = RGBACOLOR(55, 154, 254, 1);
        cell.lab5.text = @"已确认";
    }else if ([model.status isEqualToString:@"finished"]) {
        cell.lab5.textColor = RGBACOLOR(0, 157, 147, 1.0);
        cell.lab5.text = @"已入库";
    }else if ([model.status isEqualToString:@"returned"]) {
        cell.lab5.textColor = RGBACOLOR(249, 76, 82, 1);
        cell.lab5.text = @"已退货";
    }else if ([model.status isEqualToString:@"canceled"]) {
        cell.lab5.textColor = RGBACOLOR(113, 113, 113, 1);
         cell.lab5.text = @"已取消";
    }
    
    
    LRViewBorderRadius(cell.btn, 10, 1, RGBACOLOR(72, 168, 161, 1));
    [cell.btn addTarget:self action:@selector(clickBtnSend:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}


- (void)clickBtnSend:(UIButton *)sender{
    DDGL_list_Cell *cell = (DDGL_list_Cell *)[[sender.superview superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    Model *model = [self.dataArray objectAtIndex:indexpath.row];
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认申请开票？" message:@"温馨提示" preferredStyle:1];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:cancel];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        AFHTTPSessionManager *session = [Manager returnsession];
        __weak typeof(self) weakSelf = self;
        NSDictionary *dic = [[NSDictionary alloc]init];
        dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
                @"ids":model.id,
                @"purchaseOrderType":str,
                @"supplierId":[Manager redingwenjianming:@"supplierId.text"],
                };
        [session POST:KURLNSString(@"servlet/purchase/purchaseorder/payment/apply") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [Manager returndictiondata:responseObject];
            if ([[dic objectForKey:@"result_code"] isEqualToString:@"success"]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"申请开票成功！" message:@"温馨提示" preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [weakSelf setUpReflash];
                }];
                [alert addAction:cancel];
                [weakSelf presentViewController:alert animated:YES completion:nil];
            }else{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"申请开票失败" message:@"温馨提示" preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alert addAction:cancel];
                [weakSelf presentViewController:alert animated:YES completion:nil];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
        
        
    }];
    [alert addAction:sure];
    [self presentViewController:alert animated:YES completion:nil];
    
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
            @"purchaseOrderType":str,
            
            @"sorttype":@"desc",
            @"sort":@"createTime",
            
            @"stockInDays":[Manager sharedManager].stockInDays,
            
            @"purchaseOrderNo":text1.text,
            @"sendBeginTime":text2.text,
            @"sendEndTime":text3.text,
            @"stockInBeginTime":text4.text,
            @"stockInEndTime":text5.text,
            };
//    NSLog(@"%@",dic);
    [session POST:KURLNSString(@"servlet/purchase/purchaseorder/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"%@",dic);
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
            @"purchaseOrderType":str,
            @"sorttype":@"desc",
            @"sort":@"createTime",
            
            @"stockInDays":[Manager sharedManager].stockInDays,
            @"purchaseOrderNo":text1.text,
            @"sendBeginTime":text2.text,
            @"sendEndTime":text3.text,
            @"stockInBeginTime":text4.text,
            @"stockInEndTime":text5.text,
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
