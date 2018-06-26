//
//  LoginViewController.m
//  DXRacerSupplierAFE
//
//  Created by ilovedxracer on 2017/10/16.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>
{
    NSString *appstore_verson;
    NSString *appstore_newverson;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupshuxingdaila];
    
    self.btn.layer.masksToBounds = YES;
    self.btn.layer.cornerRadius  = 5;
    LRViewBorderRadius(self.img, 5, 0, [UIColor whiteColor]);
    self.text1.text  = [Manager redingwenjianming:@"bianhao.text"];
    self.text2.text  = [Manager redingwenjianming:@"user.text"];
    self.text3.text  = [Manager redingwenjianming:@"password.text"];
    
    
   
    
    
    [self lodverson];
   
}


- (void)lodverson{
    NSString *dom= [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    NSString *tex= [dom stringByAppendingPathComponent:@"newversion.text"];
    //取出存入的上次版本号版本号
    appstore_verson = [NSString stringWithContentsOfFile:tex encoding:NSUTF8StringEncoding error:nil];
    
    __weak typeof(self) weakSelf = self;
    AFHTTPSessionManager *session = [Manager returnsession];
    [session POST:@"https://itunes.apple.com/lookup?id=1309457456" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        NSMutableArray *arr = [dic objectForKey:@"results"];
        NSDictionary *dict = [arr lastObject];
        //app store版本号
        appstore_newverson = dict[@"version"];
        
        //写入版本号
        NSString *doucments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
        NSString *text= [doucments stringByAppendingPathComponent:@"newversion.text"];
        [appstore_newverson writeToFile:text atomically:YES encoding:NSUTF8StringEncoding error:nil];
        
        //NSLog(@"appstore版本：%@----存入的版本号：%@",appstore_newverson,appstore_verson);
        
        if (![appstore_verson isEqualToString:appstore_newverson] && appstore_verson != nil){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"有新的版本需要更新，是否前往" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"稍后再说" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            UIAlertAction *sure = [UIAlertAction actionWithTitle:@"立即更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/jie-zou-da-shi/id1309457456?mt=8"]];
            }];
            [alert addAction:cancel];
            [alert addAction:sure];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}









- (IBAction)clickBtnLogin:(id)sender {
        
        [self.text1 resignFirstResponder];
        [self.text2 resignFirstResponder];
        [self.text3 resignFirstResponder];
        
        AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
        [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:
//                    NSLog(@"未知网络");
                    [self lodlogin];
                    break;
                case AFNetworkReachabilityStatusNotReachable:
//                    NSLog(@"没有网络(断网)");
                    [self noNetWorking];
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
//                    NSLog(@"手机自带网络");
                    [self lodlogin];
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
//                    NSLog(@"WIFI");
                    [self lodlogin];
                    break;
            }
        }];
        [manager startMonitoring];
  
}
- (void)noNetWorking{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"无法连接网络，前往设置界面，查看该应用是否被允许连接网络！" message:@"温馨提示" preferredStyle:1];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)lodlogin {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = NSLocalizedString(@"加载中....", @"HUD loading title");
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    if (self.text1.text != nil && self.text2.text && self.text3.text) {
        dic = @{@"businessId":self.text1.text,
                @"username":self.text2.text,
                @"password":self.text3.text,
                @"ipAddress":[[Manager sharedManager] getIPAddress:YES],
                };
        
        [session POST:KURLNSString(@"user/login") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [Manager returndictiondata:responseObject];
//NSLog(@"++%@",dic);
            if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]){

                if ([[dic objectForKey:@"rows"]objectForKey:@"supplierUser"] != nil && ![[[dic objectForKey:@"rows"]objectForKey:@"supplierUser"] isEqual:[NSNull null]]) {
                    NSString *str = [NSString stringWithFormat:@"%@",[[[dic objectForKey:@"rows"]objectForKey:@"supplierUser"]objectForKey:@"supplierId"]];
                    [Manager writewenjianming:@"supplierId.text" content:str];
                    
                    [Manager writewenjianming:@"supplierName.text" content:[[[dic objectForKey:@"rows"] objectForKey:@"supplierInfo"]objectForKey:@"supplierName"]];
                }else{
                    [Manager writewenjianming:@"supplierId.text" content:@""];
                    
                    [Manager writewenjianming:@"supplierName.text" content:@""];
                }
                
                
                
                
                
                [Manager writewenjianming:@"userName.text" content:[[[dic objectForKey:@"rows"]objectForKey:@"systemUser"] objectForKey:@"username"]];
                [Manager writewenjianming:@"userName.text" content:[[[dic objectForKey:@"rows"]objectForKey:@"systemUser"]objectForKey:@"username"]];
                NSString *str1 = [NSString stringWithFormat:@"%@",[[[dic objectForKey:@"rows"]objectForKey:@"systemUser"]objectForKey:@"id"]];
                [Manager writewenjianming:@"userId.text" content:str1];
                
                
//                [Manager writewenjianming:@"supplierUserId.text" content:[NSString stringWithFormat:@"%@",[[[dic objectForKey:@"rows"]objectForKey:@"supplierUser"]objectForKey:@"supplierId"]]];
                
                
                
                [Manager writewenjianming:@"bianhao.text" content:weakSelf.text1.text];
                [Manager writewenjianming:@"user.text" content:weakSelf.text2.text];
                [Manager writewenjianming:@"password.text" content:weakSelf.text3.text];
                
                
                
                NSDictionary *dict = [[NSDictionary alloc]init];
                NSNotification *notification =[NSNotification notificationWithName:@"hiddenlogin" object:nil userInfo:dict];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
            }else{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"登录失败，请检查登录信息是否正确" message:@"温馨提示" preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alert addAction:cancel];
                [self presentViewController:alert animated:YES completion:nil];
            }
            [hud hideAnimated:YES];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"登录失败，请检查登录信息是否正确" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
            [hud hideAnimated:YES];
        }];
    }
    
    
}


- (void)setupshuxingdaila {
    self.text1.delegate = self;
    self.text1.borderStyle = UITextBorderStyleRoundedRect;
    self.text1.keyboardType = UIKeyboardTypePhonePad;
    self.text1.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    
    
    self.text2.delegate = self;
    self.text2.borderStyle = UITextBorderStyleRoundedRect;
    self.text2.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.text3.delegate = self;
    self.text3.borderStyle = UITextBorderStyleRoundedRect;
    self.text3.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.text3.secureTextEntry = YES;
    self.text3.keyboardType = UIKeyboardTypeASCIICapable;
    
    
    self.text1.backgroundColor =  RGBACOLOR(255, 255, 255, .5);
    self.text2.backgroundColor =  RGBACOLOR(255, 255, 255, .5);
    self.text3.backgroundColor =  RGBACOLOR(255, 255, 255, .5);
    
    
    LRViewBorderRadius(self.text1, 5, 1, RGBACOLOR(152, 214, 210, 1));
    LRViewBorderRadius(self.text2, 5, 1, RGBACOLOR(152, 214, 210, 1));
    LRViewBorderRadius(self.text3, 5, 1, RGBACOLOR(152, 214, 210, 1));
    
    [self vie1];
    [self vie2];
    [self vie3];
}
- (void)vie1{
    _text1.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *loginImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"qybm"]];
    loginImgV.frame = CGRectMake(10, 10, 20, 20);
    loginImgV.contentMode = UIViewContentModeScaleAspectFit;
    UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [lv addSubview:loginImgV];
    _text1.leftView = lv;
}
- (void)vie2{
    _text2.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *loginImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user-1"]];
    loginImgV.frame = CGRectMake(10, 10, 20, 20);
    loginImgV.contentMode = UIViewContentModeScaleAspectFit;
    UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [lv addSubview:loginImgV];
    _text2.leftView = lv;
}
- (void)vie3{
    _text3.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *loginImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Lock"]];
    loginImgV.frame = CGRectMake(10, 10, 20, 20);
    loginImgV.contentMode = UIViewContentModeScaleAspectFit;
    UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [lv addSubview:loginImgV];
    _text3.leftView = lv;
}




@end
