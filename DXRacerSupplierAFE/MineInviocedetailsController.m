//
//  MineInviocedetailsController.m
//  DXRacerSupplierAFE
//
//  Created by ilovedxracer on 2017/10/25.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "MineInviocedetailsController.h"
#import "Invioce_7_Cell.h"
#import "Invioce_5_Cell.h"
#import "Invioce_10_Cell.h"
#import "OrderListDetails_3_Cell.h"
#import "InvioceModel.h"
#import "InvioceModel1.h"

#import "TimeZhou_Cell.h"


@interface MineInviocedetailsController ()
{
    CGFloat height;
}
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *dataArray1;
@property(nonatomic,strong)NSMutableArray *dataArray3;
@end

@implementation MineInviocedetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"订单详情";
    [self.tableView registerNib:[UINib nibWithNibName:@"Invioce_7_Cell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"Invioce_5_Cell" bundle:nil] forCellReuseIdentifier:@"cell2"];
    [self.tableView registerNib:[UINib nibWithNibName:@"Invioce_10_Cell" bundle:nil] forCellReuseIdentifier:@"cell3"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TimeZhou_Cell" bundle:nil] forCellReuseIdentifier:@"cell4"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self lodone];
    [self lodtwo];
    [self lodfour];
    
    UIView *vie = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    self.tableView.tableFooterView = vie;
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.dataArray.count;
    }else if (section == 1) {
        return self.dataArray1.count;
    }else if (section == 2) {
        return 1;
    }
    return self.dataArray3.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 245;
    }else if (indexPath.section == 1) {
        return 205;
    }else if (indexPath.section == 2) {
        return 415;
    }
    return 80+height;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString *identifierCell = @"cell1";
        Invioce_7_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
        if (cell == nil) {
            cell = [[Invioce_7_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        InvioceModel *model = [self.dataArray objectAtIndex:indexPath.row];
        cell.lab1.text = [NSString stringWithFormat:@"采购单编号：%@",model.purchaseOrderNo];
        if (model.orderNo == nil) {
            cell.lab2.text = [NSString stringWithFormat:@"订单编号：%@",@"-"];
        }else{
            cell.lab2.text = [NSString stringWithFormat:@"订单编号：%@",model.orderNo];
        }
        
        cell.lab3.text = [NSString stringWithFormat:@"入库单号：%@",model.stockInOrderNo];
        if (model.createTime == nil){
            cell.lab4.text = [NSString stringWithFormat:@"下单时间：%@",@"-"];
        }else{
            cell.lab4.text = [NSString stringWithFormat:@"下单时间：%@",model.createTime];
        }
        
        cell.lab5.text = [NSString stringWithFormat:@"入库时间：%@",model.sendTime];
        
        cell.lab6.textColor = [UIColor redColor];
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"订单总额：¥%.04f",[model.totalAmount floatValue]]];
        NSRange range = NSMakeRange(0, 5);
        [noteStr addAttribute:NSForegroundColorAttributeName value:RGBACOLOR(102, 102, 102, 1) range:range];
        [cell.lab6 setAttributedText:noteStr];
        
        cell.lab1.textColor = RGBACOLOR(102, 102, 102, 1);
        cell.lab2.textColor = RGBACOLOR(102, 102, 102, 1);
        cell.lab4.textColor = RGBACOLOR(102, 102, 102, 1);
        cell.lab5.textColor = RGBACOLOR(102, 102, 102, 1);
        cell.lab3.textColor = RGBACOLOR(102, 102, 102, 1);
        
       
        return cell;
    }
    if (indexPath.section == 1) {
        static NSString *identifierCell = @"cell2";
        Invioce_5_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
        if (cell == nil) {
            cell = [[Invioce_5_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        InvioceModel *model = [self.dataArray1 objectAtIndex:indexPath.row];
        cell.lab1.text = [NSString stringWithFormat:@"部件编号：%@",model.partNo];
        cell.lab2.text = [NSString stringWithFormat:@"部件名称：%@",model.partName];
        cell.lab3.text = [NSString stringWithFormat:@"数量：%@",model.quantity];
        
        
        cell.lab4.textColor = [UIColor redColor];
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"单价：¥%.04f",[model.price floatValue]]];
        NSRange range = NSMakeRange(0, 3);
        [noteStr addAttribute:NSForegroundColorAttributeName value:RGBACOLOR(102, 102, 102, 1) range:range];
        [cell.lab4 setAttributedText:noteStr];
        
        cell.lab5.textColor = [UIColor redColor];
        NSMutableAttributedString *noteStr111 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"总价：¥%.04f",[model.price floatValue] * [model.quantity floatValue]]];
        NSRange ranges = NSMakeRange(0, 3);
        [noteStr111 addAttribute:NSForegroundColorAttributeName value:RGBACOLOR(102, 102, 102, 1) range:ranges];
        [cell.lab5 setAttributedText:noteStr111];
        
        
        cell.lab1.textColor = RGBACOLOR(102, 102, 102, 1);
        cell.lab2.textColor = RGBACOLOR(102, 102, 102, 1);
        cell.lab3.textColor = RGBACOLOR(102, 102, 102, 1);
        
        
        cell.lines.hidden = YES;
        cell.btn.hidden = YES;
//        cell.line.hidden = YES;
        return cell;
    }
    if (indexPath.section == 2) {
        static NSString *identifierCell = @"cell3";
        Invioce_10_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
        if (cell == nil) {
            cell = [[Invioce_10_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.lab1.text = [NSString stringWithFormat:@"发票号：%@",self.str1];
        cell.lab2.text = [NSString stringWithFormat:@"发票类型：%@",self.str2];
        
        
        
        cell.lab3.textColor = [UIColor redColor];
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"发票金额：%@",self.str3]];
        NSRange range = NSMakeRange(0, 5);
        [noteStr addAttribute:NSForegroundColorAttributeName value:RGBACOLOR(102, 102, 102, 1) range:range];
        [cell.lab3 setAttributedText:noteStr];
        
        
        
        cell.lab4.text = [NSString stringWithFormat:@"发票抬头：%@",self.str4];
        cell.lab5.text = [NSString stringWithFormat:@"纳税人识别号：%@",self.str5];
        cell.lab6.text = [NSString stringWithFormat:@"地址信息：%@",self.str6];
        cell.lab7.text = [NSString stringWithFormat:@"电话：%@",self.str7];
        cell.lab8.text = [NSString stringWithFormat:@"银行名称：%@",self.str8];
        cell.lab9.text = [NSString stringWithFormat:@"银行帐号：%@",self.str9];
        
        if (self.str10 == nil) {
            cell.lab10.text = [NSString stringWithFormat:@"发票状态：%@",@"-"];
        }else{
            cell.lab10.text = [NSString stringWithFormat:@"发票状态：%@",self.str10];
        }
        
        
        cell.lab1.textColor = RGBACOLOR(102, 102, 102, 1);
        cell.lab2.textColor = RGBACOLOR(102, 102, 102, 1);
        cell.lab4.textColor = RGBACOLOR(102, 102, 102, 1);
        cell.lab5.textColor = RGBACOLOR(102, 102, 102, 1);
        cell.lab6.textColor = RGBACOLOR(102, 102, 102, 1);
        cell.lab7.textColor = RGBACOLOR(102, 102, 102, 1);
        cell.lab8.textColor = RGBACOLOR(102, 102, 102, 1);
        cell.lab9.textColor = RGBACOLOR(102, 102, 102, 1);
        cell.lab10.textColor = RGBACOLOR(102, 102, 102, 1);
        
//        cell.line.hidden = YES;
        return cell;
    }
    static NSString *identifierCell = @"cell4";
    TimeZhou_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[TimeZhou_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
   
    InvioceModel *model = [self.dataArray3 objectAtIndex:indexPath.row];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
   
    
    cell.lab1.text = [NSString stringWithFormat:@"%@",model.remark];
    cell.lab1.numberOfLines = 0;
    cell.lab1.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size = [cell.lab1 sizeThatFits:CGSizeMake(SCREEN_WIDTH-30, MAXFLOAT)];
    cell.lab1height.constant = size.height;
    height= size.height;
    
    cell.lab2.text = [NSString stringWithFormat:@"%@",model.operator];
    cell.lab3.text = [Manager TimeCuoToTimes:model.createTime];
    
    cell.img.backgroundColor = RGBACOLOR(230, 230, 230, 1);
    cell.line.backgroundColor = RGBACOLOR(230, 230, 230, 1);
    return cell;
}


- (void)lodone{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"supplierId":[Manager redingwenjianming:@"supplierId.text"],
            @"paymentOrderId":self.paymentOrderId,
            };
    [session POST:KURLNSString(@"servlet/purchase/purchaseorder/forlist") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        [weakSelf.dataArray removeAllObjects];
//        NSLog(@"---%@",dic);
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        for (NSDictionary *dict in arr) {
            InvioceModel *model = [InvioceModel mj_objectWithKeyValues:dict];
            
            InvioceModel1 *model2 = [InvioceModel1 mj_objectWithKeyValues:model.supplierInfo];
            model.supplierInfoModel = model2;
           
            [weakSelf.dataArray addObject:model];
        }
        [weakSelf.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}


- (void)lodtwo{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"supplierId":[Manager redingwenjianming:@"supplierId.text"],
            @"field1":self.field1,
            };
    [session POST:KURLNSString(@"servlet/purchase/purchaseorderitem/item/forlist") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        [weakSelf.dataArray1 removeAllObjects];
        //NSLog(@"---%@",dic);
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        for (NSDictionary *dict in arr) {
            InvioceModel *model = [InvioceModel mj_objectWithKeyValues:dict];
            
            InvioceModel1 *model2 = [InvioceModel1 mj_objectWithKeyValues:model.purchaseOrder];
            model.purchaseOrderModel = model2;
            
            [weakSelf.dataArray1 addObject:model];
        }
        [weakSelf.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}





- (void)lodfour{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"supplierId":[Manager redingwenjianming:@"supplierId.text"],
            @"paymentOrderId":self.paymentOrderId,
            };
    [session POST:KURLNSString(@"servlet/purchase/paymentorderlog/log/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        [weakSelf.dataArray3 removeAllObjects];
//        NSLog(@"---%@",dic);
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        for (NSDictionary *dict in arr) {
            InvioceModel *model = [InvioceModel mj_objectWithKeyValues:dict];
            [weakSelf.dataArray3 addObject:model];
        }
        [weakSelf.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}










- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIControl *view = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    view.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 120, 30)];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:18];
    
    
    UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    line1.backgroundColor = RGBACOLOR(230, 230, 230, 1);
    [view addSubview:line1];
    
    UILabel *line11 = [[UILabel alloc] initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, 1)];
    line11.backgroundColor = RGBACOLOR(230, 230, 230, 1);
    [view addSubview:line11];
    
    
    
    [view addSubview:label];
    
    if (section == 0) {
        label.text = [NSString stringWithFormat:@" 订单清单"];
        return view;
    }else if (section == 1) {
        label.text = [NSString stringWithFormat:@" 部件清单"];
        return view;
    }else if (section == 2) {
        label.text = [NSString stringWithFormat:@" 发票信息"];
        return view;
    }
    label.text = [NSString stringWithFormat:@" 操作日志"];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}
- (NSMutableArray *)dataArray1 {
    if (_dataArray1 == nil) {
        self.dataArray1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray1;
}

- (NSMutableArray *)dataArray3 {
    if (_dataArray3 == nil) {
        self.dataArray3 = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray3;
}
@end
