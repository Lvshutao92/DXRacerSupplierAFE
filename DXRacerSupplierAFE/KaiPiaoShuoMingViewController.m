//
//  KaiPiaoShuoMingViewController.m
//  DXRacerSupplierAFE
//
//  Created by ilovedxracer on 2017/10/25.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//
#import "KaiPiaoShuoMingViewController.h"

@interface KaiPiaoShuoMingViewController ()

@end

@implementation KaiPiaoShuoMingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBACOLOR(230, 236, 240, 1);
    self.navigationItem.title = @"开票说明";
    
    
    
    CGFloat height;
    if ([[[Manager sharedManager] iphoneType] isEqualToString:@"iPhone X"]) {
        self.lab1top.constant = 100;
    }else{
        height = 80;
    }
    
    
    
    
    
    [self lod];
}

- (void)lod{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"id":[Manager redingwenjianming:@"supplierId.text"],
            };
    [session POST:KURLNSString(@"servlet/purchase/purchaseorderinvoice/supplier/apply") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        NSDictionary *dic = [diction objectForKey:@"rows"];
//        NSLog(@"+++---%@",dic);
        NSString *str1 = [NSString stringWithFormat:@"%@",[[dic objectForKey:@"supplierInvoice"] objectForKey:@"purchaseOrderStatus"]];
        NSString *str;
        if ([str1 isEqualToString:@"created"]) {
            str = @"待确认";
        }else if ([str1 isEqualToString:@"confirmed"]) {
            str = @"已确认";
        }else if ([str1 isEqualToString:@"finished"]) {
            str = @"已入库";
        }else if ([str1 isEqualToString:@"returned"]) {
            str = @"已退货";
        }else if ([str1 isEqualToString:@"canceled"]) {
            str = @"已取消";
        }
        NSString *str2 = [NSString stringWithFormat:@"%@",[[dic objectForKey:@"supplierInvoice"] objectForKey:@"stockInDays"]];
        
        // 创建Attributed
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"1.%@的采购单%@天后可开票",str,str2]];
        // 需要改变的区间
        NSRange range1 = NSMakeRange(2, 3);
        NSRange range2 = NSMakeRange(9, str2.length);
        // 改变颜色
        [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range1];
        [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range2];
        // 改变字体大小及类型
        [noteStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-BoldOblique" size:20] range:range1];
        [noteStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-BoldOblique" size:20] range:range2];
        // 为label添加Attributed
        [weakSelf.lab1 setAttributedText:noteStr];
        
        
        if ([[dic objectForKey:@"supplierInvoice"] objectForKey:@"minValue"] == nil || [[[dic objectForKey:@"supplierInvoice"] objectForKey:@"minValue"] isEqual:[NSNull null]]) {
            ;
            weakSelf.lab2.text = @"-";
        }else{
            NSString *string1 = [[dic objectForKey:@"supplierInvoice"] objectForKey:@"minValue"];
            weakSelf.lab2.text = [NSString stringWithFormat:@"%.2f",[string1 floatValue]];
        }
        
        if ([[dic objectForKey:@"supplierInvoice"] objectForKey:@"maxValue"] == nil || [[[dic objectForKey:@"supplierInvoice"] objectForKey:@"maxValue"] isEqual:[NSNull null]]) {
            weakSelf.lab3.text =  @"-";
        }else{
            NSString *string2 = [[dic objectForKey:@"supplierInvoice"] objectForKey:@"maxValue"];
            weakSelf.lab3.text = [NSString stringWithFormat:@"%.2f",[string2 floatValue]];
        }
        
        
        
        
        
        weakSelf.lab4.text = [[dic objectForKey:@"configInvoice"] objectForKey:@"payerCode"];
        
        
        
        weakSelf.lab5.text = [[dic objectForKey:@"configInvoice"] objectForKey:@"companyName"];
        weakSelf.lab5.numberOfLines = 0;
        weakSelf.lab5.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize size = [weakSelf.lab5 sizeThatFits:CGSizeMake(SCREEN_WIDTH-100, MAXFLOAT)];
        weakSelf.titleHeight.constant = size.height;
        weakSelf.addrtop.constant     = size.height;
        
        
        
        weakSelf.lab6.text = [[dic objectForKey:@"configInvoice"] objectForKey:@"address"];
        weakSelf.lab6.numberOfLines = 0;
        weakSelf.lab6.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize size1 = [weakSelf.lab6 sizeThatFits:CGSizeMake(SCREEN_WIDTH-110, MAXFLOAT)];
        weakSelf.addrHeight.constant = size1.height;
        weakSelf.phonetop.constant   = size1.height;
        
        
        
        
        weakSelf.lab7.text = [[dic objectForKey:@"configInvoice"] objectForKey:@"telephone"];
        
        weakSelf.lab8.text = [[dic objectForKey:@"configInvoice"] objectForKey:@"bankName"];
        weakSelf.lab8.numberOfLines = 0;
        weakSelf.lab8.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize size2 = [weakSelf.lab8 sizeThatFits:CGSizeMake(SCREEN_WIDTH-110, MAXFLOAT)];
        weakSelf.bankHeight.constant = size2.height;
        weakSelf.bankcounttop.constant  = size2.height;
        
        
        weakSelf.lab9.text = [[dic objectForKey:@"configInvoice"] objectForKey:@"bankAccount"];
 
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}


@end
