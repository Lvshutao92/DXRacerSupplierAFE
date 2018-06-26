//
//  YuYueFahuoViewController.h
//  DXRacerSupplierAFE
//
//  Created by ilovedxracer on 2017/10/23.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YuYueFahuoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *text1;

@property (weak, nonatomic) IBOutlet UITextField *text2;

@property (weak, nonatomic) IBOutlet UITextField *text3;

@property(nonatomic,strong)NSString *str;
@property(nonatomic,strong)NSString *idstr;



@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height1;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height2;


@end
