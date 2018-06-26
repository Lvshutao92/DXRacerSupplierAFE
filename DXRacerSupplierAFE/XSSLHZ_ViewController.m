//
//  XSSLHZ_ViewController.m
//  DXRacerSupplierAFE
//
//  Created by ilovedxracer on 2017/12/27.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "XSSLHZ_ViewController.h"
#import "SLHZ_Cell.h"
@interface XSSLHZ_ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
    
    
    UILabel *lab1;
    
    NSString *idstr;
    
    CGFloat heights;
    
    UIView *window;
    UITextField *text1;
    UITextField *text2;
    NSString *stu1;
    NSString *stu2;
    NSString *stu3;
}
@property (nonatomic, strong)UILabel *toplab;
@property (nonatomic, strong)UILabel *toplab1;
@property (nonatomic, strong)UILabel *toplab2;
@property (nonatomic, strong)UIScrollView *BgView;

@property(nonatomic,strong)NSMutableArray *arr;



@property(nonatomic,strong)UITableView    *tableview;
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation XSSLHZ_ViewController

- (NSMutableArray *)arr {
    if (_arr == nil) {
        self.arr = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr;
}
- (void)clicksearch{
    [self.view bringSubviewToFront:window];
    window.hidden = NO;
    text1.text = nil;
    stu1 = nil;
    stu2 = nil;
    stu3 = nil;
    text2.text = nil;
}

- (void)setupButton {
    
    CGFloat height;
    if ([[[Manager sharedManager] iphoneType] isEqualToString:@"iPhone X"]) {
        height = 88;
    }else{
        height = 64;
    }
    
    
    window = [[UIView alloc] initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, SCREEN_HEIGHT)];
    window.backgroundColor = [UIColor colorWithWhite:.85 alpha:.5];
    //window.windowLevel = UIWindowLevelNormal;
    window.alpha = 1.f;
    window.hidden = YES;
    
    
    self.BgView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
    self.BgView.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH-20, 40)];
    lab1.text = @"部件编码";
    [self.BgView addSubview:lab1];
    
    text1 = [[UITextField alloc] initWithFrame:CGRectMake(10,50, SCREEN_WIDTH-20, 40)];
    text1.delegate = self;
    text1.placeholder = @"请输入部件编码";
    text1.text = @"";
    text1.borderStyle = UITextBorderStyleRoundedRect;
    [self.BgView addSubview: text1];
    
    
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 100, 40)];
    lab2.text = @"部件名称";
    [self.BgView addSubview:lab2];
    
    text2 = [[UITextField alloc] initWithFrame:CGRectMake(10, 145, SCREEN_WIDTH-20, 40)];
    text2.delegate = self;
    text2.text = @"";
    text2.borderStyle = UITextBorderStyleRoundedRect;
    text2.placeholder = @"请输入部件名称";
    [self.BgView addSubview: text2];
    
    
    
    
    self.toplab = [[UILabel alloc]initWithFrame:CGRectMake(10, 195, SCREEN_WIDTH-20, 40)];
    self.toplab.text = @"部件分类";
    [self.BgView addSubview:self.toplab];
    
    //    self.arr = @[@"配件(OMP)",@"配件",@"扶手",@"五星脚"];
    CGFloat w = 0;//保存前一个button的宽以及前一个button距离屏幕边缘的距离
    CGFloat h = 240;//用来控制button距离父视图的高
    for (int i = 0; i < self.arr.count; i++) {
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
        CGFloat length = [self.arr[i] boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size.width;
        //为button赋值
        [button setTitle:self.arr[i] forState:UIControlStateNormal];
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
    
    
    
    
    self.toplab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, h+50, SCREEN_WIDTH-20, 40)];
    self.toplab1.text = @"是否已结款";
    [self.BgView addSubview:self.toplab1];
    NSArray  *arr1 = @[@"已结款",@"未结款"];
    CGFloat w1 = 0;
    CGFloat h1 = h+95;
    for (int i = 0; i < arr1.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.tag = 100 + i;
        button.backgroundColor = [UIColor colorWithWhite:.8 alpha:.3];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 5.0;
        [button addTarget:self action:@selector(handleClick1:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:22.f]};
        CGSize size = CGSizeMake(MAXFLOAT, 25);
        CGFloat length = [arr1[i] boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size.width;
        [button setTitle:arr1[i] forState:UIControlStateNormal];
        button.frame = CGRectMake(10 + w1, h1, length + 20 , 40);
        if(10 + w1 + length + 20 > self.view.frame.size.width){
            w1 = 0;
            h1 = h1 + button.frame.size.height + 10;
            button.frame = CGRectMake(10 + w1, h1, length + 20, 40);
        }
        w1 = button.frame.size.width + button.frame.origin.x;
        [_BgView addSubview:button];
    }
    
    
    
    self.toplab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, h1+50, SCREEN_WIDTH-20, 40)];
    self.toplab2.text = @"条件";
    [self.BgView addSubview:self.toplab2];
    NSArray  *arr2 = @[@"已送货未入库",@"已入库未开票",@"已开票未回款",@"已回款"];
    CGFloat w2 = 0;
    CGFloat h2 = h1+95;
    for (int i = 0; i < arr2.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.tag = 100 + i;
        button.backgroundColor = [UIColor colorWithWhite:.8 alpha:.3];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 5.0;
        [button addTarget:self action:@selector(handleClick2:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:22.f]};
        CGSize size = CGSizeMake(MAXFLOAT, 25);
        CGFloat length = [arr2[i] boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size.width;
        [button setTitle:arr2[i] forState:UIControlStateNormal];
        button.frame = CGRectMake(10 + w2, h2, length + 20 , 40);
        if(10 + w2 + length + 20 > self.view.frame.size.width){
            w2 = 0;
            h2 = h2 + button.frame.size.height + 10;
            button.frame = CGRectMake(10 + w2, h2, length + 20, 40);
        }
        w2 = button.frame.size.width + button.frame.origin.x;
        [_BgView addSubview:button];
    }
    
    
    
    
    
    _BgView.frame = CGRectMake(0, 0, self.view.frame.size.width, SCREEN_HEIGHT-200);
    _BgView.contentSize = CGSizeMake(0, h2+100);
    [window addSubview:_BgView];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT-200, SCREEN_WIDTH/2, 50);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:btn];
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0,SCREEN_HEIGHT-199, SCREEN_WIDTH/2, 49);
    btn1.backgroundColor = [UIColor whiteColor];
    [btn1 setTitle:@"取消" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:btn1];
    
    
    UILabel *lin = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-200,SCREEN_WIDTH/2, 1)];
    lin.backgroundColor = [UIColor colorWithWhite:.85 alpha:.5];
    [window addSubview:lin];
    
    [self.view addSubview:window];
    [self.view bringSubviewToFront:window];
    
    
    [self lod];
    [self setUpReflash];
}

- (void)cancle{
    window.hidden = YES;
    text1.text = @"";
    stu1 = @"";
    stu2 = @"";
    stu3 = @"";
    text2.text = @"";
}




- (void)sure{
    [text1 resignFirstResponder];
    [text2 resignFirstResponder];
    if (text1.text.length == 0) {
        text1.text = @"";
    }
    if (stu1.length == 0) {
        stu1 = @"";
    }
    if (stu2.length == 0) {
        stu2 = @"";
    }
    if (stu3.length == 0) {
        stu3 = @"";
    }
    if (text2.text.length == 0) {
        text2.text = @"";
    }
    [self lod];
    [self setUpReflash];
    window.hidden = YES;
}

- (void)handleClick:(UIButton *)btn{
    [text1 resignFirstResponder];
    [text2 resignFirstResponder];
    if (text1.text.length == 0) {
        text1.text = @"";
    }
    if (text2.text.length == 0) {
        text2.text = @"";
    }
    
    stu1 = btn.titleLabel.text;
    if (stu1 == nil || stu1.length == 0) {
        stu1 = @"";
    }
    
    if (stu2 == nil || stu2.length == 0) {
        stu2 = @"";
    }
    
    if (stu3 == nil || stu3.length == 0) {
        stu3 = @"";
    }
    
    [self setUpReflash];
    [self lod];
    window.hidden = YES;
}
- (void)handleClick1:(UIButton *)btn{
    [text1 resignFirstResponder];
    [text2 resignFirstResponder];
    if (text1.text.length == 0) {
        text1.text = @"";
    }
    if (text2.text.length == 0) {
        text2.text = @"";
    }
    
    
    if (stu1 == nil || stu1.length == 0) {
        stu1 = @"";
    }
    
    
    if ([btn.titleLabel.text isEqualToString:@"已结款"]) {
        stu2 = @"finished";
    }else if ([btn.titleLabel.text isEqualToString:@"未结款"]) {
        stu2 = @"unFinished";
    }
    if (stu2 == nil || stu2.length == 0) {
        stu2 = @"";
    }
    
    if (stu3 == nil || stu3.length == 0) {
        stu3 = @"";
    }
    
    [self setUpReflash];
    [self lod];
    window.hidden = YES;
}
- (void)handleClick2:(UIButton *)btn{
    [text1 resignFirstResponder];
    [text2 resignFirstResponder];
    if (text1.text.length == 0) {
        text1.text = @"";
    }
    if (text2.text.length == 0) {
        text2.text = @"";
    }
    
    if (stu1 == nil || stu1.length == 0) {
        stu1 = @"";
    }
    
    if (stu2 == nil || stu2.length == 0) {
        stu2 = @"";
    }
    
    
    if ([btn.titleLabel.text isEqualToString:@"已送货未入库"]) {
        stu3 = @"unStockIn";
    }else if ([btn.titleLabel.text isEqualToString:@"已入库未开票"]) {
        stu3 = @"unInvoiced";
    }else if ([btn.titleLabel.text isEqualToString:@"已开票未回款"]) {
        stu3 = @"unPayed";
    }else if ([btn.titleLabel.text isEqualToString:@"已回款"]) {
        stu3 = @"payed";
    }
    if (stu3 == nil || stu3.length == 0) {
        stu3 = @"";
    }
    
    [self setUpReflash];
    [self lod];
    window.hidden = YES;
}


- (void)lodbtn{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            };
    [session POST:KURLNSString(@"servlet/parts/supplierparts") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //NSLog(@"%@",dic);
        
        weakSelf.arr = [dic objectForKey:@"classifyList"];
        [weakSelf setupButton];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}

















- (void)lod{
    AFHTTPSessionManager *session = [Manager returnsession];
//    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"page":[NSString stringWithFormat:@"%ld",page],
            @"supplierId":[Manager redingwenjianming:@"supplierId.text"],
            @"sorttype":@"asc",
            @"sort":@"part_no",
            
            @"partNo":text1.text,
            @"partName":text2.text,
            @"classify":stu1,
            @"finish":stu2,
            @"condition":stu3,
            };
    [session POST:KURLNSString(@"servlet/report/report/getTotalAmountMapForSupplier") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
        if (![[dic objectForKey:@"countMap"] isEqual:[NSNull null]]) {
            NSString *str = [NSString stringWithFormat:@"当前条件搜索总金额：%@",[Manager jinegeshiLiangWei:[[dic objectForKey:@"countMap"] objectForKey:@"total_amount"]]];
            
            NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:str];
            NSRange range = NSMakeRange(0, 10);
            [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
            [lab1 setAttributedText:noteStr];
        }else{
            NSString *str = [NSString stringWithFormat:@"当前条件搜索总金额：%@",@"0.00"];
            
            NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:str];
            NSRange range = NSMakeRange(0, 10);
            [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
            [lab1 setAttributedText:noteStr];
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBACOLOR(230, 236, 240, 1);
    if (stu1.length == 0) {
        stu1 = @"";
    }
    if (stu2.length == 0) {
        stu2 = @"";
    }
    if (stu3.length == 0) {
        stu3 = @"";
    }
    [self lodbtn];
    
    if ([[[Manager sharedManager] iphoneType] isEqualToString:@"iPhone X"]) {
        heights = 88;
    }else{
        heights = 64;
    }
    
    lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, heights+10, SCREEN_WIDTH-20, 20)];
    lab1.textColor = [UIColor redColor];
    [self.view addSubview:lab1];
    
    
    UIBarButtonItem *bars = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(clicksearch)];
    self.navigationItem.rightBarButtonItem = bars;
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, heights+40, SCREEN_WIDTH, SCREEN_HEIGHT-heights-40)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"SLHZ_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    self.tableview.backgroundColor = RGBACOLOR(230, 236, 240, 1);
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180+height;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    SLHZ_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[SLHZ_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.contentView.backgroundColor = RGBACOLOR(230, 236, 240, 1);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    Model *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.img.contentMode = UIViewContentModeScaleAspectFit;
    [cell.img sd_setImageWithURL:[NSURL URLWithString:NSString(model.image_url)]placeholderImage:[UIImage imageNamed:@"user"]];

    
    cell.lab1.text = model.part_name;
    cell.lab2.text = model.part_no;
    cell.lab3.text = [Manager jinegeshi:model.price];
    cell.lab4.text = model.quantity;
    cell.lab5.text = [Manager jinegeshi:model.total_amount];
    

    
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
            @"supplierId":[Manager redingwenjianming:@"supplierId.text"],
            @"sorttype":@"asc",
            @"sort":@"part_no",
            
            @"partNo":text1.text,
            @"partName":text2.text,
            @"classify":stu1,
            @"finish":stu2,
            @"condition":stu3,
            };
    [session POST:KURLNSString(@"servlet/report/report/supplier/item/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        totalnum = [[dic objectForKey:@"total"] integerValue];
        [weakSelf.dataArray removeAllObjects];
        
        if (![[dic objectForKey:@"rows"] isEqual:[NSNull null]]) {
            NSMutableArray *arr = [dic objectForKey:@"rows"];
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
            @"supplierId":[Manager redingwenjianming:@"supplierId.text"],
            @"sorttype":@"asc",
            @"sort":@"part_no",
            
            @"partNo":text1.text,
            @"partName":text2.text,
            @"classify":stu1,
            @"finish":stu2,
            @"condition":stu3,
            };
    [session POST:KURLNSString(@"servlet/report/report/supplier/item/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        if (![[dic objectForKey:@"rows"] isEqual:[NSNull null]]) {
            NSMutableArray *arr = [dic objectForKey:@"rows"];
           
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
