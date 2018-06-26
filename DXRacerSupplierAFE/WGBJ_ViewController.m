//
//  WGBJ_ViewController.m
//  DXRacerSupplierAFE
//
//  Created by ilovedxracer on 2017/10/18.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "WGBJ_ViewController.h"
#import "GHGL_two_Cell.h"
@interface WGBJ_ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
    
   
    UIView *window;
    UITextField *text1;
    UITextField *text2;
    NSString *stu1;
    NSString *stu2;
    
}
@property (nonatomic, strong)UILabel *toplab;
@property (nonatomic, strong)UILabel *toplab1;
@property (nonatomic, strong)UIScrollView *BgView;


@property(nonatomic,strong)UITableView    *tableview;
@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)NSMutableArray *arr;
@end

@implementation WGBJ_ViewController
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
    text2.text = nil;
    stu2 = nil;
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
    self.toplab1.text = @"是否停产";
    [self.BgView addSubview:self.toplab1];
    
    NSArray *arr1 = @[@"是",@"否"];
    CGFloat w1 = 0;
    CGFloat h1 = h+100;
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
    
    
    _BgView.frame = CGRectMake(0, 0, self.view.frame.size.width, SCREEN_HEIGHT-200);
    _BgView.contentSize = CGSizeMake(0, h1+100);
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
    
    
    [self setUpReflash];
}

- (void)cancle{
    window.hidden = YES;
    text1.text = nil;
    stu1 = @"";
    text2.text = nil;
    stu2 = @"";
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
    if (text2.text.length == 0) {
        text2.text = @"";
    }
    if (stu2.length == 0) {
        stu2 = @"";
    }
    
    
    
    
    
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
    
    
    if (stu1 == nil || stu1.length == 0) {
        stu1 = @"";
    }
    stu1 = btn.titleLabel.text;
    
    
    if (stu2.length == 0) {
        stu2 = @"";
    }
    
    [self setUpReflash];
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
    if (stu2.length == 0) {
        stu2 = @"";
    }
    if ([btn.titleLabel.text isEqualToString:@"是"]) {
        stu2 = @"Y";
    }else if ([btn.titleLabel.text isEqualToString:@"否"]) {
        stu2 = @"N";
    }
    
    
    
    [self setUpReflash];
    window.hidden = YES;
}





- (void)lodbtn{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"supplierId":[Manager redingwenjianming:@"supplierId.text"],
            };
    [session POST:KURLNSString(@"servlet/parts/parts/notbind") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"%@",dic);
        weakSelf.arr = [dic objectForKey:@"classifyList"];
        [weakSelf setupButton];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}









- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBACOLOR(230, 236, 240, 1);
    
    [self lodbtn];
    
    UIBarButtonItem *bars = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(clicksearch)];
    self.navigationItem.rightBarButtonItem = bars;
    
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"GHGL_two_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    self.tableview.backgroundColor = RGBACOLOR(230, 236, 240, 1);
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    view.backgroundColor = RGBACOLOR(230, 236, 240, 1);
    self.tableview.tableHeaderView = view;
    
    if (stu1 == nil) {
        stu1 = @"";
    }
    if (stu2 == nil) {
        stu2 = @"";
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200+height;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    GHGL_two_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[GHGL_two_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor = RGBACOLOR(230, 236, 240, 1);
    
    Model *model = [self.dataArray objectAtIndex:indexPath.row];
    
    [cell.img sd_setImageWithURL:[NSURL URLWithString:NSString(model.picture)]placeholderImage:[UIImage imageNamed:@"user"]];
    cell.img.contentMode = UIViewContentModeScaleAspectFit;
    
    
    
    cell.lab1.text = model.name;
    cell.lab1.numberOfLines = 0;
    cell.lab1.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size1 = [cell.lab1 sizeThatFits:CGSizeMake(SCREEN_WIDTH-140, MAXFLOAT)];
    cell.lab1height.constant = size1.height;
    height = size1.height;
    
    
    
    cell.lab2.text = model.partNo;
    
    cell.lab3.text = [NSString stringWithFormat:@"%@/%@",model.classify,model.unit];
    
    
    
    if ([model.isAftersalePart isEqualToString:@"Y"]) {
        cell.lab4.text = @"是售后件";
    }else{
        cell.lab4.text = @"非售后件";
    }
    
    if ([model.isCountable isEqualToString:@"Y"]) {
        cell.lab5.text = @"是耗材部件";
    }else{
        cell.lab5.text = @"非耗材部件";
    }
    
    if ([model.stop isEqualToString:@"Y"]) {
        cell.lab6.text = @"停产";
    }else{
        cell.lab6.text = @"不停产";
    }
    
    
    
    
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
    
    if (text1.text.length == 0) {
        text1.text = @"";
    }
    if (text2.text.length == 0) {
        text2.text = @"";
    }
    
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"page":[NSString stringWithFormat:@"%ld",page],
            @"supplierId":[Manager redingwenjianming:@"supplierId.text"],
            @"sorttype":@"asc",
            @"sort":@"partNo",
            
            @"searchPendingbind":@"1",
            @"searchHasSupplier":@"N",
            @"mysearchSupplierId":@"3",
            
            @"partNo":text1.text,
            @"name":text2.text,
            @"classify":stu1,
            @"stop":stu2,
            };
    [session POST:KURLNSString(@"servlet/parts/parts/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"11-----------%@",dic);
        
        totalnum = [[dic objectForKey:@"total"] integerValue];
        [weakSelf.dataArray removeAllObjects];
        
        if (![[dic objectForKey:@"rows"] isEqual:[NSNull null]]) {
            NSMutableArray *arr = [dic objectForKey:@"rows"];
            for (NSDictionary *dict in arr) {
                Model *model = [Model mj_objectWithKeyValues:dict];
                
                Model1 *model1 = [Model1 mj_objectWithKeyValues:model.parts];
                model.parts_model = model1;
                
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
            @"sort":@"partNo",
            @"inventoryType":@"",
            
            @"searchPendingbind":@"1",
            @"searchHasSupplier":@"N",
            @"mysearchSupplierId":@"3",
            
            @"partNo":text1.text,
            @"name":text2.text,
            @"classify":stu1,
            @"stop":stu2,
            };
    
    [session POST:KURLNSString(@"servlet/parts/parts/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
        if (![[dic objectForKey:@"rows"] isEqual:[NSNull null]]) {
            NSMutableArray *arr = [dic objectForKey:@"rows"];
            for (NSDictionary *dict in arr) {
                Model *model = [Model mj_objectWithKeyValues:dict];
                
                Model1 *model1 = [Model1 mj_objectWithKeyValues:model.parts];
                model.parts_model = model1;
                
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
