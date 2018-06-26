//
//  ShouYeViewController.m
//  DXRacerSupplierAFE
//
//  Created by ilovedxracer on 2017/12/21.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "ShouYeViewController.h"
#import "MineInformatiomViewController.h"

#import "GongHuoViewController.h"
#import "YGBJ_ViewController.h"
#import "WGBJ_ViewController.h"
#import "YGSP_ViewController.h"

#import "Order_GL_ViewController.h"

#import "InvioceGuanLiTableViewController.h"


#import "ResourceViewController.h"

#import "DXRacerController.h"

#import "BaoBiaoTableViewController.h"
#import "UserTableViewController.h"
@interface ShouYeViewController ()<UINavigationControllerDelegate>
{
    float height;
    UILabel *lab;
    NSString *totalMoney;
}
@property(nonatomic, strong)UIScrollView *scrollview;
@property(nonatomic, strong)NSMutableArray *imgArray;


@property(nonatomic, strong)UIImageView *bgimg;
@property(nonatomic, strong)UIImageView *img;
@property(nonatomic, strong)UIImageView *userImageView;

@property(nonatomic, strong)NSMutableArray *dataSourceArray;
@end

@implementation ShouYeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航控制器的代理为self
    self.navigationController.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.bgimg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250)];
    self.bgimg.image = [UIImage imageNamed:@"sybg"];
    self.bgimg.userInteractionEnabled = YES;
    [self.view addSubview:self.bgimg];
    
    self.img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 250, SCREEN_WIDTH, 25)];
    self.img.image = [UIImage imageNamed:@"syc"];
    [self.view addSubview:self.img];
    
    
    self.scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 285, SCREEN_WIDTH, SCREEN_HEIGHT-295)];
    
    self.userImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-40, 70, 80, 80)];
    self.userImageView.layer.cornerRadius = 40;
    self.userImageView.layer.masksToBounds = YES;
    self.userImageView.userInteractionEnabled = YES;
    self.userImageView.image = [UIImage imageNamed:@"user"];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImageview:)];
    [self.userImageView addGestureRecognizer:tap];
    
//    UIImage *theImage = [UIImage imageNamed:@"user"];
//    theImage = [theImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//    self.userImageView.image = theImage;
//    self.userImageView.tintColor = RGBACOLOR(32, 157, 149, 1.0);
    
    [self.bgimg addSubview:self.userImageView];
    lab = [[UILabel alloc]initWithFrame:CGRectMake(20, 160, SCREEN_WIDTH-40, 50)];
    lab.numberOfLines = 0;
    lab.font = [UIFont systemFontOfSize:18];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = [UIColor whiteColor];
    lab.text = [NSString stringWithFormat:@"%@\n%@",[Manager redingwenjianming:@"userName.text"],[Manager redingwenjianming:@"supplierName.text"]];
    
    [self.bgimg addSubview:lab];
    
    [self.view addSubview:self.scrollview];
    
    
    self.dataSourceArray = [@[@"订单管理",@"发票管理",@"迪锐克斯",@"报表管理",@"供货管理"]mutableCopy];
    self.imgArray = [@[@"ddgl",@"fpgl",@"dxracer",@"bbgl",@"ghgl"]mutableCopy];
    
    
    
    [self setbutton];
    
    [self lod];
}




- (void)lod{
    AFHTTPSessionManager *session = [Manager returnsession];
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"id":[Manager redingwenjianming:@"supplierId.text"],
            };
    [session POST:KURLNSString(@"servlet/purchase/purchaseorderinvoice/supplier/apply") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        NSDictionary *dic = [diction objectForKey:@"rows"];
        //        NSLog(@"+++---%@",dic);
        [Manager sharedManager].stockInDays = [NSString stringWithFormat:@"%@",[[dic objectForKey:@"supplierInvoice"] objectForKey:@"stockInDays"]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}






- (void)setbutton {
    
    int b = 0;
    int hangshu;
    if (self.dataSourceArray.count % 3 == 0 ) {
        hangshu = (int )self.dataSourceArray.count / 3;
    } else {
        hangshu = (int )self.dataSourceArray.count / 3 + 1;
    }
    //j是小于你设置的列数
    for (int i = 0; i < hangshu; i++) {
        for (int j = 0; j < 3; j++) {
            CustomButton *btn = [CustomButton buttonWithType:UIButtonTypeCustom];
            if ( b  < self.dataSourceArray.count) {
                 
                btn.frame = CGRectMake((10  + j * (SCREEN_WIDTH-20)/3), (i * 120*SCALE_HEIGHT) ,(SCREEN_WIDTH-20)/3, 120*SCALE_HEIGHT);
                
                btn.backgroundColor = [UIColor whiteColor];
                btn.tag = b;
                [btn setTitle:self.dataSourceArray[b] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                
                height = i * 120*SCALE_HEIGHT;
                [self.scrollview setContentSize:CGSizeMake(SCREEN_WIDTH, height)];

                
                UIImage *image = [UIImage imageNamed:self.imgArray[b]];
                [btn setImage:image forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(yejian:) forControlEvents:UIControlEventTouchUpInside];
                [btn.layer setBorderColor:[UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1].CGColor];
                [btn.layer setBorderWidth:0.5f];
                [btn.layer setMasksToBounds:YES];
                [self.scrollview addSubview:btn];
                if (b > self.dataSourceArray.count)
                {
                    [btn removeFromSuperview];
                }
            }
            b++;
        }
    }
    
    
}
- (void)yejian:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"我的信息"]) {
        MineInformatiomViewController *info = [[MineInformatiomViewController alloc]init];
        [self.navigationController pushViewController:info animated:YES];
    }else if ([sender.titleLabel.text isEqualToString:@"供货管理"]){
         GongHuoViewController *vc = [[GongHuoViewController alloc] init];
        vc.navigationItem.title = @"供货管理";
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([sender.titleLabel.text isEqualToString:@"订单管理"]) {
        Order_GL_ViewController *info = [[Order_GL_ViewController alloc]init];
        [Manager sharedManager].searchIndex = 0;
        [self.navigationController pushViewController:info animated:YES];
    }else if ([sender.titleLabel.text isEqualToString:@"资源中心"]) {
        ResourceViewController *info = [[ResourceViewController alloc]init];
        [self.navigationController pushViewController:info animated:YES];
    }else if ([sender.titleLabel.text isEqualToString:@"发票管理"]){
        InvioceGuanLiTableViewController *info = [[InvioceGuanLiTableViewController alloc]init];
        [self.navigationController pushViewController:info animated:YES];
    }else if ([sender.titleLabel.text isEqualToString:@"迪锐克斯"]) {
        DXRacerController *info = [[DXRacerController alloc]init];
        [self.navigationController pushViewController:info animated:YES];
    }else if ([sender.titleLabel.text isEqualToString:@"报表管理"]) {
        BaoBiaoTableViewController *info = [[BaoBiaoTableViewController alloc]init];
        [self.navigationController pushViewController:info animated:YES];
    }
    
}




- (void)clickImageview:(UITapGestureRecognizer *)gesture{
    UserTableViewController *install = [[UserTableViewController alloc]init];
    [self.navigationController pushViewController:install animated:YES];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)clickEdit{
   
}
- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
    //处于后台后登录角标归0
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}





#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

- (NSMutableArray *)dataSourceArray {
    if (_dataSourceArray == nil) {
        self.dataSourceArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSourceArray;
}
- (NSMutableArray *)imgArray {
    if (_imgArray == nil) {
        self.imgArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _imgArray;
}
@end
