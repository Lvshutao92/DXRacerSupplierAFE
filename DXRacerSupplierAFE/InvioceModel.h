//
//  InvioceModel.h
//  DXRacerSupplierAFE
//
//  Created by ilovedxracer on 2017/10/25.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InvioceModel1.h"
@interface InvioceModel : NSObject
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

@property(nonatomic,strong)NSString *stockInTime;
@property(nonatomic,strong)NSString *purchasePlanNo;

@property(nonatomic,strong)NSString *field4;


//@property(nonatomic,strong)NSString *field1;




@property(nonatomic,strong)NSDictionary *purchaseOrderInvoice;
@property(nonatomic,strong)InvioceModel1 *purchaseOrderInvoiceModel;

@property(nonatomic,strong)NSDictionary *supplierInfo;
@property(nonatomic,strong)InvioceModel1 *supplierInfoModel;


@property(nonatomic,strong)NSDictionary *purchasePaymentOrder;
@property(nonatomic,strong)InvioceModel1 *purchasePaymentOrderModel;

@property(nonatomic,strong)NSDictionary  *purchasePlan;
@property(nonatomic,strong)InvioceModel1 *purchasePlanModel;



@property(nonatomic,strong)NSString *supplierId;

@property(nonatomic,strong)NSString *operator;
@property(nonatomic,strong)NSString *remark;


@property(nonatomic,strong)NSString *paymentNo;
@property(nonatomic,strong)NSString *totalFee;
@property(nonatomic,strong)NSString *invoiceTime;
@property(nonatomic,strong)NSString *confirmTime;

@property(nonatomic,strong)NSString *paymentStatus;

@property(nonatomic,strong)NSString *purchaseOrderId;
@property(nonatomic,strong)NSString *quantity;
@property(nonatomic,strong)NSString *supplierPartNo;
@property(nonatomic,strong)NSString *partName;
@property(nonatomic,strong)NSString *location;
@property(nonatomic,strong)NSString *partNo;
@property(nonatomic,strong)NSString *price;
@property(nonatomic,strong)NSDictionary *purchaseOrder;
@property(nonatomic,strong)InvioceModel1 *purchaseOrderModel;





@end
