//
//  DDGL_list_Cell.h
//  DXRacerSupplierAFE
//
//  Created by ilovedxracer on 2017/12/21.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDGL_list_Cell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *view;

@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UILabel *lab2;
@property (weak, nonatomic) IBOutlet UILabel *lab3;
@property (weak, nonatomic) IBOutlet UILabel *lab4;

@property (weak, nonatomic) IBOutlet UILabel *lab5;


@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnwidth;


@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btn1width;



@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btn_btn1_juli;


@property (weak, nonatomic) IBOutlet UILabel *lab0;
@property (weak, nonatomic) IBOutlet UILabel *lab00;
@property (weak, nonatomic) IBOutlet UILabel *lab;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lab00width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lab0width;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labwidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *width1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *width2;

@end
