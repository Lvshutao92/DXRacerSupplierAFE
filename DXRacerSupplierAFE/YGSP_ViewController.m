//
//  YGSP_ViewController.m
//  DXRacerSupplierAFE
//
//  Created by ilovedxracer on 2017/10/18.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "YGSP_ViewController.h"
#import "GHGL_three_Cell.h"
@interface YGSP_ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
    
    NSString *idstr;
}
@property(nonatomic,strong)UITableView    *tableview;
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation YGSP_ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBACOLOR(230, 236, 240, 1);
   
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"GHGL_three_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    self.tableview.backgroundColor = RGBACOLOR(230, 236, 240, 1);
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    view.backgroundColor = RGBACOLOR(230, 236, 240, 1);
    self.tableview.tableHeaderView = view;
    
    [self setUpReflash];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 235+height;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    GHGL_three_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[GHGL_three_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.contentView.backgroundColor = RGBACOLOR(230, 236, 240, 1);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    LRViewBorderRadius(cell.btn, 5, 1, RGBACOLOR(32, 157, 149, 1.0));
    LRViewBorderRadius(cell.btn1, 5, 1, RGBACOLOR(32, 157, 149, 1.0));
    
    Model *model = [self.dataArray objectAtIndex:indexPath.row];
    
    [cell.img sd_setImageWithURL:[NSURL URLWithString:NSString(model.tradeGoods_model.imageUrl)]placeholderImage:[UIImage imageNamed:@"user"]];
    
    cell.lab.text = model.tradeGoods_model.skuNameCn;
    cell.lab.numberOfLines = 0;
    cell.lab.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size1 = [cell.lab sizeThatFits:CGSizeMake(SCREEN_WIDTH-140, MAXFLOAT)];
    cell.labheight.constant = size1.height;
    height = size1.height;
    
    
    cell.lab1.text = [NSString stringWithFormat:@"FCNO：%@",model.tradeGoods_model.skuCode];
    
    
    cell.lab2.text = [NSString stringWithFormat:@"供应商：%@",model.supplierInfoModel.supplierName];
    cell.lab2.numberOfLines = 0;
    
    
    
    
    
    if (model.purchasePrice == nil) {
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"当前供货价：%@",@"-"]];
        NSRange range1 = NSMakeRange(0, 6);
        [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range1];
        [cell.lab3 setAttributedText:noteStr];
    }else{
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"当前供货价：%@",[Manager jinegeshi:model.purchasePrice]]];
        NSRange range1 = NSMakeRange(0, 6);
        [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range1];
        [cell.lab3 setAttributedText:noteStr];
    }
    
    
    [cell.btn addTarget:self action:@selector(clickbtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn1 addTarget:self action:@selector(clickbtn1:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)clickbtn:(UIButton *)sender{
    GHGL_three_Cell *cell = (GHGL_three_Cell *)[[sender.superview superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    Model *model = [self.dataArray objectAtIndex:indexpath.row];
    
    idstr = model.id;
    
    YBAlertView *alertView = [[YBAlertView alloc] initWithFrame:CGRectMake(50, kScreenH/2 - 150, kScreenW-100, 200)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, alertView.width, 30)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"报价申请";
    titleLabel.font = [UIFont systemFontOfSize:20];
    [alertView addSubview:titleLabel];
    
    UITextField *passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(titleLabel.frame) + 25, alertView.width-32, 45)];
    passwordTF.tag = 100;
    passwordTF.borderStyle = UITextBorderStyleRoundedRect;
    passwordTF.layer.borderWidth = 1;
    passwordTF.text = model.applyPrice;
    passwordTF.layer.borderColor = [UIColor colorWithWhite:.8 alpha:.5].CGColor;
    passwordTF.layer.cornerRadius = 5;
    [alertView addSubview:passwordTF];
    
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cancelBtn.frame = CGRectMake(16, CGRectGetMaxY(passwordTF.frame) + 30, passwordTF.width/2, 40);
    [cancelBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [alertView addSubview:cancelBtn];
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    confirmBtn.frame = CGRectMake(CGRectGetMaxX(cancelBtn.frame), CGRectGetMaxY(passwordTF.frame) + 30, passwordTF.width/2, 40);
    [confirmBtn addTarget:self action:@selector(confirmClick:) forControlEvents:UIControlEventTouchUpInside];
    [confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [alertView addSubview:confirmBtn];
    
    [alertView show];
    
}
- (void)cancelClick:(UIButton *)btn
{
    [btn.superview performSelector:@selector(close)];
}
-  (void)confirmClick:(UIButton *)btn
{
    [btn.superview performSelector:@selector(close)];
    UITextField *tf = [btn.superview viewWithTag:100];
    
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"supplierId":[Manager redingwenjianming:@"supplierId.text"],
            @"id":idstr,
            @"price":tf.text,
            };
    [session POST:KURLNSString(@"servlet/product/suppliertrade/apply") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //        NSLog(@"%@",dic);
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"申请报价成功" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf setUpReflash];
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}



- (void)clickbtn1:(UIButton *)sender{
    GHGL_three_Cell *cell = (GHGL_three_Cell *)[[sender.superview superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    Model *model = [self.dataArray objectAtIndex:indexpath.row];
    
    idstr = model.id;
    YBAlertView *alertView = [[YBAlertView alloc] initWithFrame:CGRectMake(50, kScreenH/2 - 150, kScreenW-100, 200)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, alertView.width, 30)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"关联编码";
    titleLabel.font = [UIFont systemFontOfSize:20];
    [alertView addSubview:titleLabel];
    
    UITextField *passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(titleLabel.frame) + 25, alertView.width-32, 45)];
    passwordTF.tag = 100;
    passwordTF.borderStyle = UITextBorderStyleRoundedRect;
    passwordTF.layer.borderWidth = 1;
    passwordTF.text = model.supplierTradeCode;
    passwordTF.layer.borderColor = [UIColor colorWithWhite:.8 alpha:.5].CGColor;
    passwordTF.layer.cornerRadius = 5;
    [alertView addSubview:passwordTF];
    
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cancelBtn.frame = CGRectMake(16, CGRectGetMaxY(passwordTF.frame) + 30, passwordTF.width/2, 40);
    [cancelBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [alertView addSubview:cancelBtn];
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    confirmBtn.frame = CGRectMake(CGRectGetMaxX(cancelBtn.frame), CGRectGetMaxY(passwordTF.frame) + 30, passwordTF.width/2, 40);
    [confirmBtn addTarget:self action:@selector(confirmClick1:) forControlEvents:UIControlEventTouchUpInside];
    [confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [alertView addSubview:confirmBtn];
    
    [alertView show];
}
-  (void)confirmClick1:(UIButton *)btn
{
    [btn.superview performSelector:@selector(close)];
    UITextField *tf = [btn.superview viewWithTag:100];
    
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"supplierId":[Manager redingwenjianming:@"supplierId.text"],
            @"id":idstr,
            @"code":tf.text,
            };
    [session POST:KURLNSString(@"servlet/product/suppliertrade/updatecode") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"关联编码成功" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf setUpReflash];
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
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
            @"supplierId":[Manager redingwenjianming:@"supplierId.text"],
            @"sorttype":@"asc",
            @"sort":@"undefined",
            };
    [session POST:KURLNSString(@"servlet/product/suppliertrade/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"----%@",dic);
        
        totalnum = [[dic objectForKey:@"total"] integerValue];
        [weakSelf.dataArray removeAllObjects];
        
        if (![[dic objectForKey:@"rows"] isEqual:[NSNull null]]) {
            NSMutableArray *arr = [dic objectForKey:@"rows"];
            for (NSDictionary *dict in arr) {
                Model *model = [Model mj_objectWithKeyValues:dict];
                
                Model1 *model1 = [Model1 mj_objectWithKeyValues:model.tradeGoods];
                model.tradeGoods_model = model1;
                
                
                Model2 *model2 = [Model2 mj_objectWithKeyValues:model.supplierInfo];
                model.supplierInfoModel = model2;
                
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
            @"supplierId":[Manager redingwenjianming:@"supplierId.text"],
            @"sorttype":@"asc",
            @"sort":@"undefined",
            };
    [session POST:KURLNSString(@"servlet/product/suppliertrade/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
        if (![[dic objectForKey:@"rows"] isEqual:[NSNull null]]) {
            NSMutableArray *arr = [dic objectForKey:@"rows"];
            for (NSDictionary *dict in arr) {
                Model *model = [Model mj_objectWithKeyValues:dict];
                
                Model1 *model1 = [Model1 mj_objectWithKeyValues:model.tradeGoods];
                model.tradeGoods_model = model1;
                
                
                Model2 *model2 = [Model2 mj_objectWithKeyValues:model.supplierInfo];
                model.supplierInfoModel = model2;
                
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
