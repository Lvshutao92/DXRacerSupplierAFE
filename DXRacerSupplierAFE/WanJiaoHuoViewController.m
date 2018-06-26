//
//  WanJiaoHuoViewController.m
//  DXRacerSupplierAFE
//
//  Created by ilovedxracer on 2017/11/7.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "WanJiaoHuoViewController.h"
#import "Order_6_3_TableViewController.h"
#import "DDGL_list_Cell.h"
#import "InvioceModel.h"
#import "InvioceModel1.h"
#import "WanJiaoHuoTableViewController.h"

@interface WanJiaoHuoViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
    
    
    UIView *window;
    
    UITextField *text1;
    NSString *stu;
    
    UIImageView *img;
}
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArray;


@property (nonatomic, strong)UILabel *toplab;
@property (nonatomic, strong)UIScrollView *BgView;
@end

@implementation WanJiaoHuoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBACOLOR(230, 236, 240, 1);
    
    img = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, 200, 200, 200)];
    img.image = [UIImage imageNamed:@"noinformation"];
    [self.view addSubview:img];
    
    
    CGFloat height;
    if ([[[Manager sharedManager] iphoneType] isEqualToString:@"iPhone X"]) {
        height = 88;
    }else{
        height = 64;
    }
    stu = @"";
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, height+50, SCREEN_WIDTH, SCREEN_HEIGHT-110)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"DDGL_list_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    UIView *vi = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    vi.backgroundColor = [UIColor colorWithWhite:.87 alpha:.5];
    self.tableview.tableHeaderView = vi;
    self.tableview.backgroundColor = RGBACOLOR(235, 239, 241, 1);
    [self setupButton];
    [self setUpReflash];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(last:) name:@"searchIndex=last" object:nil];
}
- (void)last:(NSNotification *)text {
    [self.view bringSubviewToFront:window];
    window.hidden = NO;
    text1.text = nil;
    stu = nil;
}



- (void)setupButton {
    window = [[UIView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_HEIGHT)];
    window.backgroundColor = [UIColor colorWithWhite:.85 alpha:.5];
    //window.windowLevel = UIWindowLevelNormal;
    window.alpha = 1.f;
    window.hidden = YES;
    
    
    self.BgView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 0)];
    self.BgView.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH-20, 40)];
    lab1.text = @"订单编号";
    [self.BgView addSubview:lab1];
    
    text1 = [[UITextField alloc] initWithFrame:CGRectMake(10,50, SCREEN_WIDTH-20, 40)];
    text1.delegate = self;
    text1.placeholder = @"请输入订单编号";
    text1.text = @"";
    text1.borderStyle = UITextBorderStyleRoundedRect;
    [self.BgView addSubview: text1];
    
    
    
    
    self.toplab = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, SCREEN_WIDTH-20, 40)];
    self.toplab.text = @"罚款状态";
    [self.BgView addSubview:self.toplab];
    
    NSArray *arr = @[@"可申请免处罚",@"已申请免处罚",@"待缴罚金",@"待开发票",@"已开票",@"免处罚"];
    CGFloat w = 0;//保存前一个button的宽以及前一个button距离屏幕边缘的距离
    CGFloat h = 145;//用来控制button距离父视图的高
    for (int i = 0; i < arr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.tag = 100 + i;
        button.backgroundColor = [UIColor colorWithWhite:.8 alpha:.3];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 5.0;
        
        [button addTarget:self action:@selector(handleClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //根据计算文字的大小
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:22.f]};
        CGSize size = CGSizeMake(MAXFLOAT, 25);
        CGFloat length = [arr[i] boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size.width;
        //为button赋值
        [button setTitle:arr[i] forState:UIControlStateNormal];
        //设置button的frame
        button.frame = CGRectMake(10 + w, h, length + 20 , 40);
        //当button的位置超出屏幕边缘时换行 只是button所在父视图的宽度
        if(10 + w + length + 20 > self.view.frame.size.width){
            w = 0; //换行时将w置为0
            h = h + button.frame.size.height + 10;//距离父视图也变化
            button.frame = CGRectMake(10 + w, h, length + 20, 40);//重设button的frame
        }
        w = button.frame.size.width + button.frame.origin.x;
        [_BgView addSubview:button];
        
    }
    
    
    _BgView.frame = CGRectMake(0, 10, self.view.frame.size.width, SCREEN_HEIGHT-350);
    [window addSubview:_BgView];
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT-350, SCREEN_WIDTH/2, 50);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:btn];
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0,SCREEN_HEIGHT-349, SCREEN_WIDTH/2, 49);
    btn1.backgroundColor = [UIColor whiteColor];
    [btn1 setTitle:@"取消" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:btn1];
    
    
    UILabel *lin = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-350,SCREEN_WIDTH/2, 1)];
    lin.backgroundColor = [UIColor colorWithWhite:.85 alpha:.5];
    [window addSubview:lin];
    
    [self.view addSubview:window];
    [self.view bringSubviewToFront:window];
    
}

- (void)cancle{
    window.hidden = YES;
    text1.text = nil;
    stu = @"";
}




- (void)sure{
    [self.view sendSubviewToBack:img];
    [text1 resignFirstResponder];
    
    if (text1.text.length == 0) {
        text1.text = @"";
    }
    if (stu.length == 0) {
        stu = @"";
    }
    [self setUpReflash];
    window.hidden = YES;
}

- (void)handleClick:(UIButton *)btn{
    [self.view sendSubviewToBack:img];
    [text1 resignFirstResponder];
    if (text1.text.length == 0) {
        text1.text = @"";
    }
    if (stu.length == 0) {
        stu = @"";
    }
    if ([btn.titleLabel.text isEqualToString:@"可申请免处罚"]) {
        stu = @"pendingApply";
    }else if ([btn.titleLabel.text isEqualToString:@"已申请免处罚"]) {
        stu = @"pendingCheck";
    }else if ([btn.titleLabel.text isEqualToString:@"待缴罚金"]) {
        stu = @"pendingPayment";
    }else if ([btn.titleLabel.text isEqualToString:@"待开发票"]) {
        stu = @"pendingInvoice";
    }else if ([btn.titleLabel.text isEqualToString:@"已开票"]) {
        stu = @"finished";
    }else if ([btn.titleLabel.text isEqualToString:@"免处罚"]) {
        stu = @"unfined";
    }
    
    [self setUpReflash];
    window.hidden = YES;
}












- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    InvioceModel *model = [self.dataArray objectAtIndex:indexPath.row];
    if (model.field1.length == 0 || model.field1 == nil){
        return 200;
    }
    return 170;
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
    
    InvioceModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.btn.hidden = YES;
    cell.btnwidth.constant = 0;
    cell.btn_btn1_juli.constant = 0;
    
    [cell.btn1 setTitle: @"申请免处罚" forState:UIControlStateNormal];
    cell.lab00.text = @"入库时间：";
    cell.lab0.text = @"处罚状态：";
    
    cell.contentView.backgroundColor = RGBACOLOR(235, 239, 241, 1);
    
    cell.view.layer.borderWidth = 1.0f;
    cell.view.layer.borderColor = [UIColor colorWithWhite:.8 alpha:.3].CGColor;
    cell.view.layer.shadowColor = [UIColor colorWithWhite:.5 alpha:.3].CGColor;
    cell.view.layer.shadowOpacity = 0.8f;
    cell.view.layer.shadowRadius = 5.0;
    cell.view.layer.shadowOffset = CGSizeMake(0, 1);
    
    
    LRViewBorderRadius(cell.btn, 10, 1, RGBACOLOR(72, 168, 161, 1));
    LRViewBorderRadius(cell.btn1, 10, 1, RGBACOLOR(72, 168, 161, 1));
    
    cell.lab1.text  = model.purchaseOrderNo;
    cell.lab2.text  = [Manager jinegeshi:model.totalAmount];
    cell.lab3.text  = model.stockInTime;
    
    if (model.field1.length == 0 || model.field1 == nil){
        cell.btn1.hidden = NO;
        cell.lab4.text  = @"可申请免处罚";
        cell.lab4.textColor = [UIColor blueColor];
    }else if ([model.field1 isEqualToString:@"pendingCheck"]){
        cell.lab4.text  = @"已申请免处罚";
        cell.lab4.textColor = [UIColor magentaColor];
        cell.btn1.hidden = YES;
    }else if ([model.field1 isEqualToString:@"pendingPayment"]){
        cell.lab4.text  = @"待缴罚金";
         cell.lab4.textColor = [UIColor redColor];
        cell.btn1.hidden = YES;
    }else if ([model.field1 isEqualToString:@"unfined"]){
        cell.lab4.text  = @"免处罚";
        cell.lab4.textColor = [UIColor orangeColor];
        cell.btn1.hidden = YES;
    }
    
    
    [cell.btn1 addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];

  
    
    
    
    
    
//    cell.lab1.text = [NSString stringWithFormat:@"订单编号：%@",model.purchaseOrderNo];
//    cell.lab2.text = [NSString stringWithFormat:@"工厂订单编号：%@",model.orderNo];
//
//
//    if (model.stockInOrderNo == nil) {
//        cell.lab3.text = [NSString stringWithFormat:@"入库单号：%@",@"-"];
//    }else{
//        cell.lab3.text = [NSString stringWithFormat:@"入库单号：%@",model.stockInOrderNo];
//    }
//
//
//
//

//    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"入库时间：%@",model.stockInTime]];
//    NSRange range = NSMakeRange(0, 5);
//    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
//    [cell.lab4 setAttributedText:noteStr];
//
//    cell.lab5.text = [NSString stringWithFormat:@"最晚交货日期：%@",model.planProductionDate];
//
//
//    NSMutableAttributedString *noteStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"总金额（元）：%@",[Manager jinegeshi:model.totalAmount]]];
//    NSRange range1 = NSMakeRange(0, 7);
//    [noteStr1 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range1];
//    [cell.lab6 setAttributedText:noteStr1];
//
//    if ([model.supplierInfoModel.field10 isEqualToString:@"0"]) {
//        NSMutableAttributedString *noteStr2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"罚款比例：%@",@"免罚款"]];
//        NSRange range2 = NSMakeRange(0, 5);
//        [noteStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range2];
//        [cell.lab7 setAttributedText:noteStr2];
//
//
//        NSMutableAttributedString *noteStr20 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"应处罚金：%@",@"免罚款"]];
//        NSRange range20 = NSMakeRange(0, 5);
//        [noteStr20 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range20];
//        [cell.lab8 setAttributedText:noteStr20];
//    }else{
//        NSMutableAttributedString *noteStr2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"罚款比例：%@%%",model.supplierInfoModel.field10]];
//        NSRange range2 = NSMakeRange(0, 5);
//        [noteStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range2];
//        [cell.lab7 setAttributedText:noteStr2];
//
//
//        NSString *str1 = [model.stockInTime substringToIndex:10];
//        NSDate * ValueDate1 = [self StringTODate:str1];
//
//        NSString *str2 = model.planProductionDate;
//        NSDate * ValueDate2 = [self StringTODate:str2];
//
//        NSInteger days = [Manager calcDaysFromBegin:ValueDate2 end:ValueDate1];
//
//        CGFloat time = [model.totalAmount floatValue]*[model.supplierInfoModel.field10 floatValue]/100*days;
//
//        NSMutableAttributedString *noteStr20 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"应处罚金：¥%.04f",time]];
//        NSRange range20 = NSMakeRange(0, 5);
//        [noteStr20 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range20];
//        [cell.lab8 setAttributedText:noteStr20];
//    }
//
//
//
   

//
//    cell.btn.layer.masksToBounds = YES;
//    cell.btn.layer.cornerRadius  = 10;
//    cell.btn.layer.borderWidth = 1;
//    cell.btn.layer.borderColor = [UIColor blackColor].CGColor;
//    [cell.btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
//
//
//
//
//    NSString *str1 = [model.stockInTime substringToIndex:10];
//    NSDate * ValueDate1 = [self StringTODate:str1];
//    NSString *str2 = model.planProductionDate;
//    NSDate * ValueDate2 = [self StringTODate:str2];
//    NSInteger days = [Manager calcDaysFromBegin:ValueDate2 end:ValueDate1];
//
//
//
//
////    cell.lab0.text = [NSString stringWithFormat:@"延期天数：%ld天",days];
//    cell.lab0.textColor = [UIColor redColor];
//    NSMutableAttributedString *noteStrss = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"延期天数：%ld天",days]];
//    NSRange rangedd = NSMakeRange(0, 5);
//    [noteStrss addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:rangedd];
//    [cell.lab0 setAttributedText:noteStrss];
//
    
    return cell;
}
//字符串转日期
- (NSDate *)StringTODate:(NSString *)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY-MMMM-dd";
    [dateFormatter setMonthSymbols:[NSArray arrayWithObjects:@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",nil]];
    NSDate * ValueDate = [dateFormatter dateFromString:sender];
    return ValueDate;
}
- (void)clickBtn:(UIButton *)sender{
    
    DDGL_list_Cell *cell = (DDGL_list_Cell *)[[sender.superview superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    InvioceModel *model = [self.dataArray objectAtIndex:indexpath.row];
   
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"username":[Manager redingwenjianming:@"userName.text"],
            @"idStr":model.id,
            };
    [session POST:KURLNSString(@"servlet/purchase/purchaseorder/unfine") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        if ([[dic objectForKey:@"result_code"] isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"申请成功" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                 [weakSelf setUpReflash];
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
           
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"申请失败" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    InvioceModel *model = [self.dataArray objectAtIndex:indexPath.row];
    WanJiaoHuoTableViewController *order = [[WanJiaoHuoTableViewController alloc]init];
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
            @"status":@"finished",
            @"delay":@"delay",
            @"supplierId":[Manager redingwenjianming:@"supplierId.text"],
            @"sorttype":@"asc",
            @"sort":@"planProductionDate",
            @"purchaseOrderNo":text1.text,
            @"field1":stu,
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
            InvioceModel *model = [InvioceModel mj_objectWithKeyValues:dict];

            InvioceModel1 *model1 = [InvioceModel1 mj_objectWithKeyValues:model.supplierInfo];
            model.supplierInfoModel = model1;

            InvioceModel1 *model2 = [InvioceModel1 mj_objectWithKeyValues:model.purchaseOrderInvoice];
            model.purchaseOrderInvoiceModel = model2;
            
            InvioceModel1 *model3 = [InvioceModel1 mj_objectWithKeyValues:model.purchasePaymentOrder];
            model.purchasePaymentOrderModel = model3;
            
            InvioceModel1 *model4 = [InvioceModel1 mj_objectWithKeyValues:model.purchasePlan];
            model.purchasePlanModel = model4;
            
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
            @"delay":@"delay",
            @"supplierId":[Manager redingwenjianming:@"supplierId.text"],
            @"sorttype":@"asc",
            @"sort":@"planProductionDate",
            @"purchaseOrderNo":text1.text,
            @"field1":stu,
            };

    [session POST:KURLNSString(@"servlet/purchase/purchaseorder/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        NSMutableArray *arr = [[diction objectForKey:@"rows"] objectForKey:@"resultList"];
        for (NSDictionary *dict in arr) {
            InvioceModel *model = [InvioceModel mj_objectWithKeyValues:dict];
            
            InvioceModel1 *model1 = [InvioceModel1 mj_objectWithKeyValues:model.supplierInfo];
            model.supplierInfoModel = model1;
            
            InvioceModel1 *model2 = [InvioceModel1 mj_objectWithKeyValues:model.purchaseOrderInvoice];
            model.purchaseOrderInvoiceModel = model2;
            
            InvioceModel1 *model3 = [InvioceModel1 mj_objectWithKeyValues:model.purchasePaymentOrder];
            model.purchasePaymentOrderModel = model3;
            
            InvioceModel1 *model4 = [InvioceModel1 mj_objectWithKeyValues:model.purchasePlan];
            model.purchasePlanModel = model4;
            
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
