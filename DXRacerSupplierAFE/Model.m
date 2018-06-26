//
//  Model.m
//  DXRacerSupplierAFE
//
//  Created by ilovedxracer on 2017/10/19.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "Model.h"

@implementation Model


+ (id)mj_replacedKeyFromPropertyName121:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"purchaseOrderInvoice_ed"]) propertyName = @"purchaseOrderInvoice";
    return propertyName;
}

@end
