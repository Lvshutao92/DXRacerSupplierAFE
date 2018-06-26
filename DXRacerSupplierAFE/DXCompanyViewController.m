//
//  DXCompanyViewController.m
//  DXRacerSupplierAFE
//
//  Created by ilovedxracer on 2017/10/18.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "DXCompanyViewController.h"
#import "Model.h"
@interface DXCompanyViewController ()<UITextFieldDelegate>
{
    
    UIView *bgview;
    
    UIImageView *img;
    
    UILabel *lab1;
    UILabel *lab2;
    
    
   
}
@end

@implementation DXCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBACOLOR(230, 236, 240, 1);
  
    CGFloat height;
    if ([[[Manager sharedManager] iphoneType] isEqualToString:@"iPhone X"]) {
        height = 88;
    }else{
        height = 64;
    }
    
    
    
    
    bgview = [[UIView alloc]initWithFrame:CGRectMake(10, height+10, SCREEN_WIDTH-20, 250)];
    bgview.backgroundColor = [UIColor whiteColor];
    
    
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-65, 20, 130, 130)];
    img.image = [UIImage imageNamed:@"user"];
    img.contentMode = UIViewContentModeScaleAspectFit;
    LRViewBorderRadius(img, 65, 5, [UIColor colorWithWhite:.8 alpha:.3]);
    [bgview addSubview:img];
    
    
    lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 170, SCREEN_WIDTH-40, 20)];
    lab1.textAlignment = NSTextAlignmentCenter;
    [bgview addSubview:lab1];
    
    lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 210, SCREEN_WIDTH-40, 20)];
    lab2.textAlignment = NSTextAlignmentCenter;
    [bgview addSubview:lab2];
    
    
    [self.view addSubview:bgview];
       
    [self lod];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return NO;
}


- (void)lod{
    AFHTTPSessionManager *session = [Manager returnsession];
//    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            };
    [session POST:KURLNSString(@"servlet/server/dxracercompany") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"******%@",dic);
        lab1.text = [[[dic objectForKey:@"rows"] objectForKey:@"data"] objectForKey:@"companyNameCn"];
        lab2.text = [[[dic objectForKey:@"rows"] objectForKey:@"data"] objectForKey:@"companyNameEn"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}















@end
