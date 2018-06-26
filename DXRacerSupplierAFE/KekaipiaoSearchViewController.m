//
//  KekaipiaoSearchViewController.m
//  DXRacerSupplierAFE
//
//  Created by ilovedxracer on 2017/10/26.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "KekaipiaoSearchViewController.h"
#import "KSDatePicker.h"
#import "SearchKekaipiaoViewController.h"
@interface KekaipiaoSearchViewController ()<UITextFieldDelegate>

@end

@implementation KekaipiaoSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.text1.delegate = self;
    self.text2.delegate = self;
    self.text3.delegate = self;
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)clickBtnSearch:(id)sender {
    SearchKekaipiaoViewController *search = [[SearchKekaipiaoViewController alloc]init];
    search.purchaseOrderNo = self.text1.text;
    search.sendBeginTime = self.text2.text;
    search.sendEndTime = self.text3.text;
    search.type = self.type;
    [self.navigationController pushViewController:search animated:YES];
}





- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:self.text2]) {
        [self.text1 resignFirstResponder];
        KSDatePicker* picker = [[KSDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 300)];
        picker.appearance.radius = 5;
        picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
            if (buttonType == KSDatePickerButtonCommit) {
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *str = [formatter stringFromDate:currentDate];
                self.text2.text = str;
            }
        };
        [picker show];
        return NO;
    }
    if ([textField isEqual:self.text3]) {
        [self.text1 resignFirstResponder];
        KSDatePicker* picker = [[KSDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 300)];
        picker.appearance.radius = 5;
        picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
            if (buttonType == KSDatePickerButtonCommit) {
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *str = [formatter stringFromDate:currentDate];
                self.text3.text = str;
            }
        };
        [picker show];
        return NO;
    }
    return YES;
}

@end
