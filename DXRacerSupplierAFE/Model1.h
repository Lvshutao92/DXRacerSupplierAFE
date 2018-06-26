//
//  Model1.h
//  DXRacerSupplierAFE
//
//  Created by ilovedxracer on 2017/10/19.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model2.h"
@interface Model1 : NSObject
@property(nonatomic,strong)NSString *createTime;
@property(nonatomic,strong)NSString *field1;
@property(nonatomic,strong)NSString *id;
@property(nonatomic,strong)NSString *cancelTime;
@property(nonatomic,strong)NSString *invoiceId;
@property(nonatomic,strong)NSString *isApplyPayment;
@property(nonatomic,strong)NSString *manual;
@property(nonatomic,strong)NSString *needRecreate;
@property(nonatomic,strong)NSString *orderNo;
@property(nonatomic,strong)NSString *planProductionDate;
@property(nonatomic,strong)NSString *purchaseOrderNo;
@property(nonatomic,strong)NSString *purchaseOrderType;
@property(nonatomic,strong)NSString *status;
@property(nonatomic,strong)NSString *totalAmount;
@property(nonatomic,strong)NSString *supplierNo;
@property(nonatomic,strong)NSString *originalPurchaseOrderNo;
@property(nonatomic,strong)NSString *plateNumber;
@property(nonatomic,strong)NSString *sendTime;
@property(nonatomic,strong)NSString *receivePersonName;
@property(nonatomic,strong)NSString *receivePersonTel;
@property(nonatomic,strong)NSString *stockInOrderNo;
@property(nonatomic,strong)NSString *returnTime;


@property(nonatomic,strong)NSString *purchasePaymentOrder;
@property(nonatomic,strong)NSString *purchaseOrderInvoice;

@property(nonatomic,strong)NSDictionary *supplierInfo;
@property(nonatomic,strong)Model2 *supplierInfoModel;


@property(nonatomic,strong)NSString *invoiceNo;

@property(nonatomic,strong)NSString *typeCn;

@property(nonatomic,strong)NSString *englishName;
@property(nonatomic,strong)NSString *chineseName;
//
@property(nonatomic,strong)NSString *picture;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *unit;
@property(nonatomic,strong)NSString *classify;
@property(nonatomic,strong)NSString *stop;
@property(nonatomic,strong)NSString *partNo;


//
@property(nonatomic,strong)NSString *skuCode;
@property(nonatomic,strong)NSString *skuNameCn;
@property(nonatomic,strong)NSString *imageUrl;






@end





