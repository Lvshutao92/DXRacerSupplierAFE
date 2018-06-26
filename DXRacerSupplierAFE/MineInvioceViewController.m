//
//  MineInvioceViewController.m
//  DXRacerSupplierAFE
//
//  Created by ilovedxracer on 2017/10/18.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "MineInvioceViewController.h"
#import "MineInvioce_12_Cell.h"
#import "InvioceModel.h"
#import "InvioceModel1.h"
#import "MineInviocedetailsController.h"
#import "MineinvioceSearchViewController.h"
@interface MineInvioceViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
    NSString *str;

    
    UIView *window;
    UITextField *text1;
    UITextField *text2;
    UITextField *text3;
    NSString *stu1;
    NSString *stu2;
    
    NSString *idstr;
}
@property (nonatomic, strong)UILabel *toplab;
@property (nonatomic, strong)UILabel *toplab1;
@property (nonatomic, strong)UIScrollView *BgView;




@property(nonatomic,strong)UITableView    *tableview;
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation MineInvioceViewController
- (void)clicksearch{
    [self.view bringSubviewToFront:window];
    window.hidden = NO;
    text1.text = nil;
    stu1 = nil;
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
    lab1.text = @"发票申请号";
    [self.BgView addSubview:lab1];
    
    text1 = [[UITextField alloc] initWithFrame:CGRectMake(10,50, SCREEN_WIDTH-20, 40)];
    text1.delegate = self;
    text1.placeholder = @"请输入发票申请号";
    text1.text = @"";
    text1.borderStyle = UITextBorderStyleRoundedRect;
    [self.BgView addSubview: text1];
    
    

    
    
    self.toplab = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, SCREEN_WIDTH-20, 40)];
    self.toplab.text = @"付款单状态";
    [self.BgView addSubview:self.toplab];
    
    NSArray *arr = @[@"已创建",@"待寄送",@"待确认",@"已退回",@"待收款",@"已取消",@"已收款"];
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
    
    
    
    
    
    self.toplab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, h+50, SCREEN_WIDTH-20, 40)];
    self.toplab1.text = @"发票状态";
    [self.BgView addSubview:self.toplab1];
    
    NSArray *arr1 = @[@"待寄送",@"待确认",@"待付款",@"已付款"];
    CGFloat w1 = 0;//保存前一个button的宽以及前一个button距离屏幕边缘的距离
    CGFloat h1 = h+95;//用来控制button距离父视图的高
    for (int i = 0; i < arr1.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.tag = 100 + i;
        button.backgroundColor = [UIColor colorWithWhite:.8 alpha:.3];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 5.0;
        
        [button addTarget:self action:@selector(handleClick1:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //根据计算文字的大小
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:22.f]};
        CGSize size = CGSizeMake(MAXFLOAT, 25);
        CGFloat length = [arr1[i] boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size.width;
        //为button赋值
        [button setTitle:arr1[i] forState:UIControlStateNormal];
        //设置button的frame
        button.frame = CGRectMake(10 + w1, h1, length + 20 , 40);
        //当button的位置超出屏幕边缘时换行 只是button所在父视图的宽度
        if(10 + w1 + length + 20 > self.view.frame.size.width){
            w1 = 0; //换行时将w置为0
            h1 = h1 + button.frame.size.height + 10;//距离父视图也变化
            button.frame = CGRectMake(10 + w1, h1, length + 20, 40);//重设button的frame
        }
        w1 = button.frame.size.width + button.frame.origin.x;
        [_BgView addSubview:button];
        
    }
    
    
    
    
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(10, h1+50, SCREEN_WIDTH-20, 40)];
    lab3.text = @"开票时间";
    [self.BgView addSubview:lab3];
    
    text2 = [[UITextField alloc] initWithFrame:CGRectMake(10, h1+95, SCREEN_WIDTH/2-25, 40)];
    text2.delegate = self;
    text2.text = @"";
    text2.borderStyle = UITextBorderStyleRoundedRect;
    text2.placeholder = @"开始时间";
    [self.BgView addSubview: text2];
    
    UILabel *l3 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-15, h1+95, 30, 40)];
    l3.text = @"-";
    l3.textAlignment = NSTextAlignmentCenter;
    [self.BgView addSubview:l3];
    
    
    text3 = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+15, h1+95, SCREEN_WIDTH/2-25, 40)];
    text3.delegate = self;
    text3.text = @"";
    text3.borderStyle = UITextBorderStyleRoundedRect;
    text3.placeholder = @"结束时间";
    [self.BgView addSubview: text3];
    
    
    
    
    _BgView.frame = CGRectMake(0, 0, self.view.frame.size.width, SCREEN_HEIGHT-200);
    _BgView.contentSize = CGSizeMake(0, h1+200);
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
    text2.text = nil;
    text3.text = nil;
    stu1 = @"";
    stu2 = @"";
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
    
    if (stu1.length == 0) {
        stu1 = @"";
    }
    if (stu2.length == 0) {
        stu2 = @"";
    }
    
    
    [self setUpReflash];
    window.hidden = YES;
}

- (void)handleClick:(UIButton *)btn{
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
    
    
    if (stu2.length == 0) {
        stu2 = @"";
    }
    
    
    
    
    if ([btn.titleLabel.text isEqualToString:@"已创建"]) {
        stu1 = @"created";
    }else if ([btn.titleLabel.text isEqualToString:@"待寄送"]) {
        stu1 = @"delivery";
    }else if ([btn.titleLabel.text isEqualToString:@"待确认"]) {
        stu1 = @"pendingConfirm";
    }else if ([btn.titleLabel.text isEqualToString:@"已退回"]) {
        stu1 = @"returned";
    }else if ([btn.titleLabel.text isEqualToString:@"待收款"]) {
        stu1 = @"pendingPayment";
    }else if ([btn.titleLabel.text isEqualToString:@"已收款"]) {
        stu1 = @"payed";
    }else if ([btn.titleLabel.text isEqualToString:@"已取消"]) {
        stu1 = @"canceled";
    }
    
    if (stu1 == nil || stu1.length == 0) {
        stu1 = @"";
    }
    
    
    [self setUpReflash];
    window.hidden = YES;
}

- (void)handleClick1:(UIButton *)btn{
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
    
    
    if (stu1.length == 0) {
        stu1 = @"";
    }
    
    if ([btn.titleLabel.text isEqualToString:@"待寄送"]) {
        stu2 = @"created";
    }else if ([btn.titleLabel.text isEqualToString:@"待确认"]) {
        stu2 = @"pendingConfirm";
    }else if ([btn.titleLabel.text isEqualToString:@"待付款"]) {
        stu2 = @"confirmed";
    }else if ([btn.titleLabel.text isEqualToString:@"已付款"]) {
        stu2 = @"finished";
    }
    
    if (stu2 == nil || stu2.length == 0) {
        stu2 = @"";
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
    return YES;
}




















- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBACOLOR(230, 236, 240, 1);;
    self.navigationItem.title = @"我的发票";
    
    
    UIBarButtonItem *bars = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(clicksearch)];
    self.navigationItem.rightBarButtonItem = bars;
    
    
    if (text1.text.length == 0) {
        text1.text = @"";
    }
    if (text2.text.length == 0) {
        text2.text = @"";
    }
    if (text3.text.length == 0) {
        text3.text = @"";
    }
    
    if (stu1.length == 0) {
        stu1 = @"";
    }
    if (stu2.length == 0) {
        stu2 = @"";
    }
    
   
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"MineInvioce_12_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableview.backgroundColor = RGBACOLOR(230, 236, 240, 1);
    [self.view addSubview:self.tableview];
    
    [self setupButton];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    view.backgroundColor = RGBACOLOR(230, 236, 240, 1);
    self.tableview.tableHeaderView = view;
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 485;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MineInviocedetailsController *details = [[MineInviocedetailsController alloc]init];
    details.navigationItem.title = @"详情";
    InvioceModel *model = [self.dataArray objectAtIndex:indexPath.row];
    details.field1 = model.id;
    details.paymentOrderId = model.id;
    
    if (model.purchaseOrderInvoiceModel.invoiceNo == nil) {
        details.str1  = @"-";
    }else{
        details.str1  = model.purchaseOrderInvoiceModel.invoiceNo;
    }
    
    if (model.purchaseOrderInvoiceModel.invoiceType == nil) {
        details.str2  = @"-";
    }else{
        details.str2  = model.purchaseOrderInvoiceModel.invoiceType;
    }
    
    
    details.str3  = [Manager jinegeshi:model.purchaseOrderInvoiceModel.totalFee];
    
    
    if (model.purchaseOrderInvoiceModel.title == nil) {
        details.str4  = @"-";
    }else{
        details.str4  = model.purchaseOrderInvoiceModel.title;
    }
    
    if (model.purchaseOrderInvoiceModel.code == nil) {
        details.str5  = @"-";
    }else{
        details.str5  = model.purchaseOrderInvoiceModel.code;
    }
    
    if (model.purchaseOrderInvoiceModel.address == nil) {
        details.str6  = @"-";
    }else{
         details.str6  = model.purchaseOrderInvoiceModel.address;
    }
   
    if (model.purchaseOrderInvoiceModel.telephone == nil) {
        details.str7  = @"-";
    }else{
        details.str7  = model.purchaseOrderInvoiceModel.telephone;
    }
    
    if (model.purchaseOrderInvoiceModel.bankName == nil) {
        details.str8  = @"-";
    }else{
        details.str8  = model.purchaseOrderInvoiceModel.bankName;
    }
    
    if (model.purchaseOrderInvoiceModel.bankNo == nil) {
        details.str9  = @"-";
    }else{
        details.str9  = model.purchaseOrderInvoiceModel.bankNo;
    }
    
    
    if ([model.purchaseOrderInvoiceModel.invoiceStatus isEqualToString:@"created"]) {
        details.str10 = @"已创建";
    }else if ([model.purchaseOrderInvoiceModel.invoiceStatus isEqualToString:@"delivery"]) {
        details.str10 = @"待寄送";
    }else if ([model.purchaseOrderInvoiceModel.invoiceStatus isEqualToString:@"pendingConfirm"]) {
        details.str10 = @"待确认";
    }else if ([model.purchaseOrderInvoiceModel.invoiceStatus isEqualToString:@"returned"]) {
        details.str10 = @"已退货";
    }else if ([model.purchaseOrderInvoiceModel.invoiceStatus isEqualToString:@"pendingPayment"]) {
        details.str10 = @"待收款";
    }else if ([model.purchaseOrderInvoiceModel.invoiceStatus isEqualToString:@"payed"]) {
        details.str10 = @"已收款";
    }else if ([model.purchaseOrderInvoiceModel.invoiceStatus isEqualToString:@"canceled"]) {
        details.str10 = @"已取消";
    }
    
    [self.navigationController pushViewController:details animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    MineInvioce_12_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[MineInvioce_12_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
   
    cell.bottomlab.backgroundColor = RGBACOLOR(230, 236, 240, 1);
    cell.leftlab.backgroundColor = RGBACOLOR(230, 236, 240, 1);
    cell.rightlab.backgroundColor = RGBACOLOR(230, 236, 240, 1);
    
    InvioceModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.lab1.text = [NSString stringWithFormat:@"申请单号：%@",model.paymentNo];
    
    if (model.purchaseOrderInvoiceModel.invoiceNo == nil || model.purchaseOrderInvoiceModel.invoiceNo.length == 0 || [model.purchaseOrderInvoiceModel.invoiceNo isEqual:[NSNull null]]) {
        cell.lab2.text = [NSString stringWithFormat:@"发票编号：%@",@"-"];
    }else{
        cell.lab2.text = [NSString stringWithFormat:@"发票编号：%@",model.purchaseOrderInvoiceModel.invoiceNo];
    }
    
    
    cell.lab3.textColor = [UIColor redColor];
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"含税金额：%@",[Manager jinegeshiLiangWei:model.totalFee]]];
    NSRange range = NSMakeRange(0, 5);
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
    [cell.lab3 setAttributedText:noteStr];
    

    
    CGFloat qushui   = [model.totalFee doubleValue];
    CGFloat baifenbi = 1 + [model.field4 doubleValue]/100;
    
    CGFloat zong = qushui / baifenbi * [model.field4 doubleValue]/100;
    
    CGFloat shu = floor(zong*100)/100 + 0.01;
//    NSLog(@"------%.2f",floor(zong*100)/100);
    
 
    
    
    NSString *st = [NSString stringWithFormat:@"%lf",[model.totalFee doubleValue] - shu];
    
    
   
    
    cell.lab4.textColor = [UIColor redColor];
    NSMutableAttributedString *noteStr4 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"去税金额：%@",[Manager jinegeshiLiangWei:st]]];
    NSRange range4 = NSMakeRange(0, 5);
    [noteStr4 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range4];
    [cell.lab4 setAttributedText:noteStr4];
    
    
    cell.lab5.textColor = [UIColor redColor];
    NSMutableAttributedString *noteStr5 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"税金：%@",[Manager jinegeshiLiangWei:[NSString stringWithFormat:@"%lf",shu]]]];
    NSRange range5 = NSMakeRange(0, 3);
    [noteStr5 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range5];
    [cell.lab5 setAttributedText:noteStr5];
    
    
    
    
    cell.lab6.textColor = [UIColor redColor];
    NSMutableAttributedString *noteStr6 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"税点：%@%%",model.field4]];
    NSRange range6 = NSMakeRange(0, 3);
    [noteStr6 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range6];
    [cell.lab6 setAttributedText:noteStr6];
    
    
    
    
    
    
    
    
    
    
    if (model.purchaseOrderInvoiceModel.logisticName == nil) {
        cell.lab7.text = [NSString stringWithFormat:@"快递公司：%@",@"-"];
    }else{
        cell.lab7.text = [NSString stringWithFormat:@"快递公司：%@",model.purchaseOrderInvoiceModel.logisticName];
    }
    if (model.purchaseOrderInvoiceModel.logisticsNo == nil) {
        cell.lab8.text = [NSString stringWithFormat:@"快递单号：%@",@"-"];
    }else{
        cell.lab8.text = [NSString stringWithFormat:@"快递单号：%@",model.purchaseOrderInvoiceModel.logisticsNo];
    }
    if (model.invoiceTime == nil) {
        model.invoiceTime = @"-";
    }
    if (model.confirmTime == nil) {
        model.confirmTime = @"-";
    }
    
    if (model.purchaseOrderInvoice == nil || model.purchaseOrderInvoiceModel.deliveryTime == nil) {
        cell.lab9.text = [NSString stringWithFormat:@"寄送时间：%@",@"-"];
    }else{
        cell.lab9.text = [NSString stringWithFormat:@"寄送时间：%@",model.purchaseOrderInvoiceModel.deliveryTime];
    }
    
    
    
    
    cell.lab10.text = [NSString stringWithFormat:@"确认时间：%@",model.confirmTime];
    
    
    
    
    if (model.field1 == nil) {
        cell.lab11.textColor = [UIColor redColor];
        NSMutableAttributedString *noteStr11 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"预计付款日期：%@",@"-"]];
        NSRange range11 = NSMakeRange(0, 7);
        [noteStr11 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range11];
        [cell.lab11 setAttributedText:noteStr11];
    }else{
        cell.lab11.textColor = [UIColor redColor];
        NSMutableAttributedString *noteStr11 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"预计付款日期：%@",model.field1]];
        NSRange range11 = NSMakeRange(0, 7);
        [noteStr11 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range11];
        [cell.lab11 setAttributedText:noteStr11];
    }
   

    
   
    if ([model.paymentStatus isEqualToString:@"created"]) {
        cell.lab12.textColor = [UIColor blueColor];
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:@"状态：已创建"];
        NSRange range = NSMakeRange(0, 3);
        [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
        [cell.lab12 setAttributedText:noteStr];
    }else if ([model.paymentStatus isEqualToString:@"delivery"]) {
        cell.lab12.textColor = RGBACOLOR(55, 154, 254, 1);
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:@"状态：待寄送"];
        NSRange range = NSMakeRange(0, 3);
        [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
        [cell.lab12 setAttributedText:noteStr];
    }else if ([model.paymentStatus isEqualToString:@"pendingConfirm"]) {
        cell.lab12.textColor = RGBACOLOR(0, 157, 147, 1.0);
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:@"状态：待确认"];
        NSRange range = NSMakeRange(0, 3);
        [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
        [cell.lab12 setAttributedText:noteStr];
    }else if ([model.paymentStatus isEqualToString:@"returned"]) {
        cell.lab12.textColor = RGBACOLOR(249, 76, 82, 1);
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:@"状态：已退货"];
        NSRange range = NSMakeRange(0, 3);
        [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
        [cell.lab12 setAttributedText:noteStr];
    }else if ([model.paymentStatus isEqualToString:@"pendingPayment"]) {
        cell.lab12.textColor = [UIColor magentaColor];
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:@"状态：待收款"];
        NSRange range = NSMakeRange(0, 3);
        [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
        [cell.lab12 setAttributedText:noteStr];
    }else if ([model.paymentStatus isEqualToString:@"payed"]) {
        cell.lab12.textColor = [UIColor cyanColor];
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:@"状态：已收款"];
        NSRange range = NSMakeRange(0, 3);
        [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
        [cell.lab12 setAttributedText:noteStr];
    }else if ([model.paymentStatus isEqualToString:@"canceled"]) {
        cell.lab12.textColor = [UIColor lightGrayColor];
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:@"状态：已取消"];
        NSRange range = NSMakeRange(0, 3);
        [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
        [cell.lab12 setAttributedText:noteStr];
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
    
    
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"page":[NSString stringWithFormat:@"%ld",page],
            @"supplierId":[Manager redingwenjianming:@"supplierId.text"],
            @"paymentNo":text1.text,
            @"paymentStatus":stu1,
            @"purchaseOrderInvoice.invoiceStatus":stu2,
            @"beginTime":text2.text,
            @"endTime":text3.text,
            @"sorttype":@"desc",
            @"sort":@"id",
            };
    [session POST:KURLNSString(@"servlet/purchase/purchasepaymentorder/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"%@",dic);
        totalnum = [[dic objectForKey:@"total"] integerValue];
        [weakSelf.dataArray removeAllObjects];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        for (NSDictionary *dict in arr) {
            InvioceModel *model = [InvioceModel mj_objectWithKeyValues:dict];
            
            InvioceModel1 *model2 = [InvioceModel1 mj_objectWithKeyValues:model.supplierInfo];
            model.supplierInfoModel = model2;
            
            InvioceModel1 *model3 = [InvioceModel1 mj_objectWithKeyValues:model.purchaseOrderInvoice];
            model.purchaseOrderInvoiceModel = model3;
            
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
            @"supplierId":[Manager redingwenjianming:@"supplierId.text"],
            @"paymentNo":text1.text,
            @"paymentStatus":stu1,
            @"purchaseOrderInvoice.invoiceStatus":stu2,
            @"beginTime":text2.text,
            @"endTime":text3.text,
            @"sorttype":@"desc",
            @"sort":@"id",
            };
    [session POST:KURLNSString(@"servlet/purchase/purchasepaymentorder/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        NSMutableArray *arr = [[diction objectForKey:@"rows"] objectForKey:@"resultList"];
        for (NSDictionary *dict in arr) {
            InvioceModel *model = [InvioceModel mj_objectWithKeyValues:dict];
            
            InvioceModel1 *model2 = [InvioceModel1 mj_objectWithKeyValues:model.supplierInfo];
            model.supplierInfoModel = model2;
            
            InvioceModel1 *model3 = [InvioceModel1 mj_objectWithKeyValues:model.purchaseOrderInvoice];
            model.purchaseOrderInvoiceModel = model3;
            
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
