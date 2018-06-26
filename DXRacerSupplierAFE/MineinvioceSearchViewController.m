//
//  MineinvioceSearchViewController.m
//  DXRacerSupplierAFE
//
//  Created by ilovedxracer on 2017/10/26.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "MineinvioceSearchViewController.h"
#import "KSDatePicker.h"
#import "MineInvioceViewController.h"
@interface MineinvioceSearchViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableview1;
@property(nonatomic, strong)NSMutableArray *dataArray1;

@property(nonatomic, strong)UITableView *tableview2;
@property(nonatomic, strong)NSMutableArray *dataArray2;
@end

@implementation MineinvioceSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.text1.delegate = self;
    self.text2.delegate = self;
    self.text3.delegate = self;
    self.text4.delegate = self;
    self.text5.delegate = self;
    
    self.dataArray1 = [@[@"全部付款单状态",@"已创建",@"待寄送",@"待确认",@"已退回",@"待收款",@"已取消",@"已收款"]mutableCopy];
    self.dataArray2 = [@[@"全部发票状态",@"待寄送",@"待确认",@"待付款",@"已付款"]mutableCopy];
    
    self.tableview1 = [[UITableView alloc]initWithFrame:CGRectMake(120, 180, SCREEN_WIDTH-130, 200)];
    [self.tableview1.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview1.layer setBorderWidth:1];
    self.tableview1.delegate = self;
    self.tableview1.dataSource = self;
    self.tableview1.hidden = YES;
    [self.tableview1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [self.view addSubview:self.tableview1];
    [self.view bringSubviewToFront:self.tableview1];
    
    self.tableview2 = [[UITableView alloc]initWithFrame:CGRectMake(120, 240, SCREEN_WIDTH-130, 200)];
    [self.tableview2.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview2.layer setBorderWidth:1];
    self.tableview2.delegate = self;
    self.tableview2.dataSource = self;
    self.tableview2.hidden = YES;
    [self.tableview2 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell2"];
    [self.view addSubview:self.tableview2];
    [self.view bringSubviewToFront:self.tableview2];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        self.tableview1.hidden = YES;
        self.text2.text = self.dataArray1[indexPath.row];
        
        
        
    }
    if ([tableView isEqual:self.tableview2]) {
        self.tableview2.hidden = YES;
        self.text3.text = self.dataArray2[indexPath.row];
        
        
        
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:self.tableview1]) {
        return self.dataArray1.count;
    }
    return self.dataArray2.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        cell.textLabel.text = self.dataArray1[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray2[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (IBAction)clickbtnsearch:(id)sender {

    MineInvioceViewController *invioce = [[MineInvioceViewController alloc]init];
    invioce.isorno = @"isorno";
    invioce.paymentNo = self.text1.text;
    
    
    if ([self.text2.text isEqualToString:@"全部付款单状态"]) {
        invioce.paymentStatus = @"";
    }else if ([self.text2.text isEqualToString:@"已创建"]) {
        invioce.paymentStatus = @"created";
    }else if ([self.text2.text isEqualToString:@"待寄送"]) {
        invioce.paymentStatus = @"delivery";
    }else if ([self.text2.text isEqualToString:@"待确认"]) {
        invioce.paymentStatus = @"pendingConfirm";
    }else if ([self.text2.text isEqualToString:@"已退回"]) {
        invioce.paymentStatus = @"returned";
    }else if ([self.text2.text isEqualToString:@"待收款"]) {
        invioce.paymentStatus = @"pendingPayment";
    }else if ([self.text2.text isEqualToString:@"已取消"]) {
        invioce.paymentStatus = @"canceled";
    }else if ([self.text2.text isEqualToString:@"已收款"]) {
        invioce.paymentStatus = @"payed";
    }
   
    if ([self.text3.text isEqualToString:@"全部发票状态"]) {
        invioce.invoiceStatus = @"";
    }else if ([self.text3.text isEqualToString:@"待寄送"]) {
        invioce.invoiceStatus = @"created";
    }else if ([self.text3.text isEqualToString:@"待确认"]) {
        invioce.invoiceStatus = @"pendingConfirm";
    }else if ([self.text3.text isEqualToString:@"待付款"]) {
        invioce.invoiceStatus = @"confirmed";
    }else if ([self.text3.text isEqualToString:@"已付款"]) {
        invioce.invoiceStatus = @"finished";
    }
    
    invioce.beginTime = self.text4.text;
    invioce.endTime   = self.text5.text;
    [self.navigationController pushViewController:invioce animated:YES];
  
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:self.text2]){
        [self.text1 resignFirstResponder];
        self.tableview2.hidden = YES;
        if (self.tableview1.hidden == YES) {
            self.tableview1.hidden = NO;
        }else{
            self.tableview1.hidden = YES;
        }
        return NO;
    }
    if ([textField isEqual:self.text3]){
        [self.text1 resignFirstResponder];
        self.tableview1.hidden = YES;
        if (self.tableview2.hidden == YES) {
            self.tableview2.hidden = NO;
        }else{
            self.tableview2.hidden = YES;
        }
        return NO;
    }
    
    if ([textField isEqual:self.text4]) {
        [self.text1 resignFirstResponder];
        self.tableview1.hidden = YES;
        self.tableview2.hidden = YES;
        KSDatePicker* picker = [[KSDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 300)];
        picker.appearance.radius = 5;
        picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
            if (buttonType == KSDatePickerButtonCommit) {
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *str = [formatter stringFromDate:currentDate];
                self.text4.text = str;
            }
        };
        [picker show];
        return NO;
    }
    if ([textField isEqual:self.text5]) {
        [self.text1 resignFirstResponder];
        self.tableview1.hidden = YES;
        self.tableview2.hidden = YES;
        KSDatePicker* picker = [[KSDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 300)];
        picker.appearance.radius = 5;
        picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
            if (buttonType == KSDatePickerButtonCommit) {
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *str = [formatter stringFromDate:currentDate];
                self.text5.text = str;
            }
        };
        [picker show];
        return NO;
    }
    
    self.tableview1.hidden = YES;
    self.tableview2.hidden = YES;
    return YES;
}
- (NSMutableArray *)dataArray1 {
    if (_dataArray1 == nil) {
        self.dataArray1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray1;
}
- (NSMutableArray *)dataArray2 {
    if (_dataArray2 == nil) {
        self.dataArray2 = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray2;
}

@end
