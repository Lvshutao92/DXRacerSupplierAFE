//
//  OrderList_ViewController.m
//  DXRacerSupplierAFE
//
//  Created by ilovedxracer on 2017/10/23.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "OrderList_ViewController.h"
#import "DDGL_list_Cell.h"
#import "Model.h"
#import "Model2.h"
#import "OrderListDetailsTableViewController.h"
#import "YuYueFahuoViewController.h"
#import "Model1.h"


@interface OrderList_ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
    
    UIView *window;
    
    UITextField *text1;
    UITextField *text2;
    UITextField *text3;
    UITextField *text4;
    UITextField *text5;
    UITextField *text30;
    UITextField *text40;
    UITextField *text50;
    NSString *stu;
    
     NSString *str1;
     NSString *str2;
     NSString *str3;
     NSString *str4;
     NSString *str5;
     NSString *str6;
    
  UIImageView *img;
    
}
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArray;


@property (nonatomic, strong)UILabel *toplab;
@property (nonatomic, strong)UIScrollView *BgView;



@end

@implementation OrderList_ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBACOLOR(230, 236, 240, 1);img = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, 200, 200, 200)];
    img.image = [UIImage imageNamed:@"noinformation"];
    [self.view addSubview:img];
    self.navigationItem.title = @"订单列表";
    
    str1 = @"";
    str2 = @"";
    str3 = @"";
    str4 = @"";
    str5 = @"";
    str6 = @"";
    stu = @"";
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
    
    self.tableview.backgroundColor = RGBACOLOR(235, 239, 241, 1);
    
    
    UIView *vi = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    vi.backgroundColor = [UIColor colorWithWhite:.87 alpha:.5];
    self.tableview.tableHeaderView = vi;
    
    
    [self setupButton];
    
    [self setUpReflash];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewappear:) name:@"viewappear" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(one:) name:@"searchIndex=0" object:nil];
}
- (void)one:(NSNotification *)text {
    [self.view bringSubviewToFront:window];
    window.hidden = NO;
    text1.text = nil;
    text2.text = nil;
    text3.text = nil;
    text4.text = nil;
    text5.text = nil;
    text30.text = nil;
    text40.text = nil;
    text50.text = nil;
    stu = nil;
}













- (void)setupButton {
    window = [[UIView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_HEIGHT)];
    window.backgroundColor = [UIColor colorWithWhite:.85 alpha:.5];
//    window.windowLevel = UIWindowLevelNormal;
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
    
    
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 100, 40)];
    lab2.text = @"采购单编号";
    [self.BgView addSubview:lab2];
    
    
    
    
    
    text2 = [[UITextField alloc] initWithFrame:CGRectMake(10, 145, SCREEN_WIDTH-20, 40)];
    text2.delegate = self;
    text2.borderStyle = UITextBorderStyleRoundedRect;
    text2.placeholder = @"请输入采购单编号";
    [self.BgView addSubview: text2];
    
    
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 195, SCREEN_WIDTH-20, 40)];
    lab3.text = @"发货时间";
    [self.BgView addSubview:lab3];
    
    text3 = [[UITextField alloc] initWithFrame:CGRectMake(10, 240, SCREEN_WIDTH/2-25, 40)];
    text3.delegate = self;
    text3.borderStyle = UITextBorderStyleRoundedRect;
    text3.placeholder = @"开始时间";
    [self.BgView addSubview: text3];
    
    UILabel *l3 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-15, 240, 30, 40)];
    l3.text = @"-";
    l3.textAlignment = NSTextAlignmentCenter;
    [self.BgView addSubview:l3];
    
    
    text30 = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+15, 240, SCREEN_WIDTH/2-25, 40)];
    text30.delegate = self;
    text30.borderStyle = UITextBorderStyleRoundedRect;
    text30.placeholder = @"结束时间";
    [self.BgView addSubview: text30];
    
    
    
    
    
    
    
    UILabel *lab4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 290, SCREEN_WIDTH-20, 40)];
    lab4.text = @"最晚交货日期";
    [self.BgView addSubview:lab4];
    
    text4 = [[UITextField alloc] initWithFrame:CGRectMake(10, 335, SCREEN_WIDTH/2-25, 40)];
    text4.delegate = self;
    text4.borderStyle = UITextBorderStyleRoundedRect;
    text4.placeholder = @"开始日期";
    [self.BgView addSubview: text4];
    
    
    UILabel *l4 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-15, 335, 30, 40)];
    l4.text = @"-";
    l4.textAlignment = NSTextAlignmentCenter;
    [self.BgView addSubview:l4];
    
    text40 = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+15, 335, SCREEN_WIDTH/2-25, 40)];
    text40.delegate = self;
    text40.borderStyle = UITextBorderStyleRoundedRect;
    text40.placeholder = @"结束日期";
    [self.BgView addSubview: text40];
    
    
    
    
    UILabel *lab5 = [[UILabel alloc]initWithFrame:CGRectMake(10, 385, SCREEN_WIDTH-20, 40)];
    lab5.text = @"入库时间";
    [self.BgView addSubview:lab5];
    
    text5 = [[UITextField alloc] initWithFrame:CGRectMake(10, 430, SCREEN_WIDTH/2-25, 40)];
    text5.delegate = self;
    text5.borderStyle = UITextBorderStyleRoundedRect;
    text5.placeholder = @"开始时间";
    [self.BgView addSubview: text5];
    
    UILabel *l5 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-15, 430, 30, 40)];
    l5.text = @"-";
    l5.textAlignment = NSTextAlignmentCenter;
    [self.BgView addSubview:l5];
    
    
    text50 = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+15, 430, SCREEN_WIDTH/2-25, 40)];
    text50.delegate = self;
    text50.borderStyle = UITextBorderStyleRoundedRect;
    text50.placeholder = @"结束时间";
    [self.BgView addSubview: text50];
    
    
    
    
    self.toplab = [[UILabel alloc]initWithFrame:CGRectMake(10, 480, SCREEN_WIDTH-20, 40)];
    self.toplab.text = @"订单状态";
    [self.BgView addSubview:self.toplab];
    
    NSArray *arr = @[@"待确认",@"已确认",@"已入库",@"已退货",@"已取消"];
    CGFloat w = 0;//保存前一个button的宽以及前一个button距离屏幕边缘的距离
    CGFloat h = 525;//用来控制button距离父视图的高
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
    
    
    _BgView.frame = CGRectMake(0, 10, self.view.frame.size.width, SCREEN_HEIGHT-250);
    self.BgView.contentSize = CGSizeMake(0, SCREEN_HEIGHT+10);
    [window addSubview:_BgView];
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT-250, SCREEN_WIDTH/2, 50);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:btn];
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0,SCREEN_HEIGHT-249, SCREEN_WIDTH/2, 49);
    btn1.backgroundColor = [UIColor whiteColor];
    [btn1 setTitle:@"取消" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:btn1];
    
    
    UILabel *lin = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-250,SCREEN_WIDTH/2, 1)];
    lin.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
    [window addSubview:lin];
    
    [self.view addSubview:window];
    [self.view bringSubviewToFront:window];
    
}

- (void)cancle{
    window.hidden = YES;
    text1.text = nil;
    text2.text = nil;
    text3.text = nil;
    text4.text = nil;
    text5.text = nil;
    text30.text = nil;
    text40.text = nil;
    text50.text = nil;
   
    stu = @"";
}




- (void)sure{
    [self.view sendSubviewToBack:img];
    [text1 resignFirstResponder];
    [text2 resignFirstResponder];
    
    
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
    if (text30.text.length == 0) {
        text30.text = @"";
    }
    if (text40.text.length == 0) {
        text40.text = @"";
    }
    if (text50.text.length == 0) {
        text50.text = @"";
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
    [text2 resignFirstResponder];
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
    if (text30.text.length == 0) {
        text30.text = @"";
    }
    if (text40.text.length == 0) {
        text40.text = @"";
    }
    if (text50.text.length == 0) {
        text50.text = @"";
    }
    
    if ([btn.titleLabel.text isEqualToString:@"待确认"]) {
        stu = @"created";
    }else if ([btn.titleLabel.text isEqualToString:@"已确认"]) {
        stu = @"confirmed";
    }else if ([btn.titleLabel.text isEqualToString:@"已入库"]) {
        stu = @"finished";
    }else if ([btn.titleLabel.text isEqualToString:@"已退货"]) {
        stu = @"returned";
    }else if ([btn.titleLabel.text isEqualToString:@"已取消"]) {
        stu = @"canceled";
    }
//    NSLog(@"---------------%@",stu);
    [self setUpReflash];
    window.hidden = YES;
}












- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:text3]) {
        [text1 resignFirstResponder];
        [text2 resignFirstResponder];
        
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
    if ([textField isEqual:text30]) {
        [text1 resignFirstResponder];
        [text2 resignFirstResponder];
        
        KSDatePicker *picker = [[KSDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 300)];
        picker.appearance.radius = 5;
        picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
            if (buttonType == KSDatePickerButtonCommit) {
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *str = [formatter stringFromDate:currentDate];
                text30.text = str;
            }
        };
        [window bringSubviewToFront:picker];
        [picker show];
        
        return NO;
    }
    
    if ([textField isEqual:text4]) {
        [text1 resignFirstResponder];
        [text2 resignFirstResponder];
        
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
    if ([textField isEqual:text40]) {
        [text1 resignFirstResponder];
        [text2 resignFirstResponder];
        
        KSDatePicker *picker = [[KSDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 300)];
        picker.appearance.radius = 5;
        picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
            if (buttonType == KSDatePickerButtonCommit) {
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *str = [formatter stringFromDate:currentDate];
                text40.text = str;
            }
        };
        [window bringSubviewToFront:picker];
        [picker show];
        
        return NO;
    }
    if ([textField isEqual:text5]) {
        [text1 resignFirstResponder];
        [text2 resignFirstResponder];
        
        KSDatePicker *picker = [[KSDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 300)];
        picker.appearance.radius = 5;
        picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
            if (buttonType == KSDatePickerButtonCommit) {
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *str = [formatter stringFromDate:currentDate];
                text5.text = str;
            }
        };
        [window bringSubviewToFront:picker];
        [picker show];
        
        return NO;
    }
    if ([textField isEqual:text50]) {
        [text1 resignFirstResponder];
        [text2 resignFirstResponder];
        
        KSDatePicker *picker = [[KSDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 300)];
        picker.appearance.radius = 5;
        picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
            if (buttonType == KSDatePickerButtonCommit) {
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *str = [formatter stringFromDate:currentDate];
                text50.text = str;
            }
        };
        [window bringSubviewToFront:picker];
        [picker show];
        
        return NO;
    }
    
    
    return YES;
}

























- (void)viewappear:(NSNotification *)text {
    [self setUpReflash];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    Model *model = [self.dataArray objectAtIndex:indexPath.row];
    if ([model.status isEqualToString:@"created"] || [model.status isEqualToString:@"confirmed"]) {
        return 220;
    }
    return 180;
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
    cell.view.layer.shadowRadius = 10.0;
    cell.view.layer.shadowOffset = CGSizeMake(0, 1);
    
    
    
    
    Model *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.lab1.text  = model.purchaseOrderNo;
    
    cell.lab2.text  = [Manager jinegeshi:model.totalAmount];
    cell.lab3.text  = model.planProductionDate;
    
    
    if ([model.status isEqualToString:@"created"]) {
        cell.lab4.textColor = RGBACOLOR(227, 154, 70, 1);
        cell.lab4.text  = @"待确认";
    }else if ([model.status isEqualToString:@"confirmed"]) {
        cell.lab4.textColor = RGBACOLOR(55, 154, 254, 1);
        cell.lab4.text  = @"已确认";
    }else if ([model.status isEqualToString:@"finished"]) {
        cell.lab4.textColor = RGBACOLOR(0, 157, 147, 1.0);
        cell.lab4.text  = @"已入库";
    }else if ([model.status isEqualToString:@"returned"]) {
        cell.lab4.textColor = RGBACOLOR(249, 76, 82, 1);
        cell.lab4.text  = @"已退货";
    }else if ([model.status isEqualToString:@"canceled"]) {
        cell.lab4.textColor = RGBACOLOR(113, 113, 113, 1);
        cell.lab4.text  = @"已取消";
    }
   
    
    
    if ([model.status isEqualToString:@"confirmed"]){
        cell.btn.hidden = NO;
        cell.btn_btn1_juli.constant = 10;
        cell.btnwidth.constant = 80;
    }else{
        cell.btn.hidden = YES;
        cell.btnwidth.constant = 0;
        cell.btn_btn1_juli.constant = 0;
    }
    
    
    if ([model.status isEqualToString:@"created"]) {
        cell.btn1.hidden = NO;
    }else{
        cell.btn1.hidden = YES;
    }
    
   
    
    LRViewBorderRadius(cell.btn, 10, 1, RGBACOLOR(72, 168, 161, 1));
    LRViewBorderRadius(cell.btn1, 10, 1, RGBACOLOR(72, 168, 161, 1));
    [cell.btn addTarget:self action:@selector(clickBtnSend:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn1 addTarget:self action:@selector(clickBtnSure:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}
- (void)clickBtnSend:(UIButton *)sender{
    DDGL_list_Cell *cell = (DDGL_list_Cell *)[[sender.superview superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    Model *model = [self.dataArray objectAtIndex:indexpath.row];
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
    Model *model = [self.dataArray objectAtIndex:indexpath.row];
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
                [weakSelf setUpReflash];
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













- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderListDetailsTableViewController *details = [[OrderListDetailsTableViewController alloc]init];
    Model *model = self.dataArray[indexPath.row];
    details.purchaseOrderId = model.id;
    
    MainTabbarViewController *tabBarVc = (MainTabbarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    MainNavigationViewController *Nav = [tabBarVc selectedViewController];
    [Nav pushViewController:details animated:YES];
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
            @"sort":@"planProductionDate",
            
            @"orderNo":text1.text,
            @"purchaseOrderNo":text2.text,
            @"status":stu,
            
            @"sendBeginTime":text3.text,
            @"sendEndTime":text30.text,
            
            @"planProductionBeginTime":text4.text,
            @"planProductionEndTime":text40.text,
            
            @"stockInBeginTime":text5.text,
            @"stockInEndTime":text50.text,
            };
    
//    NSLog(@"%@",dic);
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
            Model *model = [Model mj_objectWithKeyValues:dict];
            
            Model2 *model1 = [Model2 mj_objectWithKeyValues:model.purchasePaymentOrder];
            model.purchasePaymentOrderModel = model1;
            
            Model2 *model2 = [Model2 mj_objectWithKeyValues:model.purchasePlan];
            model.purchasePlanModel = model2;
            
            Model2 *model3 = [Model2 mj_objectWithKeyValues:model.supplierInfo];
            model.supplierInfoModel = model3;
            
            
            Model1 *model4 = [Model1 mj_objectWithKeyValues:model.purchaseOrderInvoice_ed];
            model.purchaseOrderInvoice_model = model4;
            
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
            @"sorttype":@"asc",
            @"sort":@"planProductionDate",
            
            
            @"orderNo":text1.text,
            @"purchaseOrderNo":text2.text,
            @"status":stu,
            
            @"sendBeginTime":text3.text,
            @"sendEndTime":text30.text,
            
            @"planProductionBeginTime":text4.text,
            @"planProductionEndTime":text40.text,
            
            @"stockInBeginTime":text5.text,
            @"stockInEndTime":text50.text,
            };
    [session POST:KURLNSString(@"servlet/purchase/purchaseorder/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        
        for (NSDictionary *dict in arr) {
            Model *model = [Model mj_objectWithKeyValues:dict];
            
            Model2 *model1 = [Model2 mj_objectWithKeyValues:model.purchasePaymentOrder];
            model.purchasePaymentOrderModel = model1;
            
            Model2 *model2 = [Model2 mj_objectWithKeyValues:model.purchasePlan];
            model.purchasePlanModel = model2;
            
            Model2 *model3 = [Model2 mj_objectWithKeyValues:model.supplierInfo];
            model.supplierInfoModel = model3;
            
            
            Model1 *model4 = [Model1 mj_objectWithKeyValues:model.purchaseOrderInvoice_ed];
            model.purchaseOrderInvoice_model = model4;
            
            
            
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
