//
//  YuYueFahuoViewController.m
//  DXRacerSupplierAFE
//
//  Created by ilovedxracer on 2017/10/23.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "YuYueFahuoViewController.h"
#import "KSDatePicker.h"
@interface YuYueFahuoViewController ()<UITextFieldDelegate,THDatePickerViewDelegate>
@property (weak, nonatomic) THDatePickerView *dateView;
@end

@implementation YuYueFahuoViewController
- (void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"预约发货";
    self.text1.delegate = self;
    self.text2.delegate = self;
    self.text3.delegate = self;
    self.text1.text = self.str;
    
    if ([[[Manager sharedManager] iphoneType] isEqualToString:@"iPhone X"]) {
        self.height1.constant = 88-64+70;
        self.height2.constant = 88-64+70;
    }else{
        self.height1.constant = 70;
        self.height2.constant = 70;
    }
    THDatePickerView *dateView = [[THDatePickerView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 300)];
    dateView.delegate = self;
    dateView.title = @"请选择预约发货时间";
    [self.view addSubview:dateView];
    self.dateView = dateView;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([textField isEqual:self.text1]) {
        [self.text3 resignFirstResponder];
        return NO;
    }
    if ([textField isEqual:self.text2]) {
        [self.text3 resignFirstResponder];
        [UIView animateWithDuration:0.3 animations:^{
            self.dateView.frame = CGRectMake(0, SCREEN_HEIGHT - 300, SCREEN_WIDTH, 300);
            [self.dateView show];
        }];
        return NO;
    }
    return YES;
}

#pragma mark - THDatePickerViewDelegate
/**
 保存按钮代理方法
 
 @param timer 选择的数据
 */
- (void)datePickerViewSaveBtnClickDelegate:(NSString *)timer {
    self.text2.text = timer;
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 300);
    }];
}

/**
 取消按钮代理方法
 */
- (void)datePickerViewCancelBtnClickDelegate {
//    NSLog(@"取消点击");
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 300);
    }];
}



- (void)lodSave{
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    NSString *path = [documents stringByAppendingPathComponent:@"userName.text"];
    NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"id":self.idstr,
            @"username":str,
            @"purchaseOrderNo":self.text1.text,
            @"sendTime":self.text2.text,
            @"plateNumber":self.text3.text,
            };
    [session POST:KURLNSString(@"servlet/purchase/purchaseorder/delivery/save") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        if ([[dic objectForKey:@"result_code"] isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"保存成功" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
            
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"保存失败" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)clicksave:(id)sender {
    if (self.text2.text.length != 0 && self.text3.text.length != 0) {
        if ([XYQRegexPatternHelper validateCarNo:self.text3.text] == YES) {
            [self lodSave];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"车牌号错误" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"信息不能为空" message:@"温馨提示" preferredStyle:1];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
   
    
}
//+ (BOOL)validateCarNo:(NSString *)carNo;
@end
