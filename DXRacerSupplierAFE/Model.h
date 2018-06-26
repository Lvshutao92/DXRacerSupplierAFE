//
//  Model.h
//  DXRacerSupplierAFE
//
//  Created by ilovedxracer on 2017/10/19.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model2.h"
#import "Model1.h"
@interface Model : NSObject
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
@property(nonatomic,strong)NSString *purchaseOrderInvoice;

@property(nonatomic,strong)NSString *partNo;
@property(nonatomic,strong)NSString *partName;

@property(nonatomic,strong)NSString *operator;
@property(nonatomic,strong)NSString *remark;

@property(nonatomic,strong)NSString *supplierPartNo;
@property(nonatomic,strong)NSString *quantity;
@property(nonatomic,strong)NSString *price;
@property(nonatomic,strong)NSString *location;



@property (nonatomic,assign) BOOL isSelect;
@property (nonatomic,assign) NSInteger number;

@property(nonatomic,strong)NSDictionary *purchasePaymentOrder;
@property(nonatomic,strong)Model2 *purchasePaymentOrderModel;

@property(nonatomic,strong)NSDictionary *purchasePlan;
@property(nonatomic,strong)Model2 *purchasePlanModel;

@property(nonatomic,strong)NSDictionary *supplierInfo;
@property(nonatomic,strong)Model2 *supplierInfoModel;


@property(nonatomic,strong)NSDictionary *purchaseOrder;
@property(nonatomic,strong)Model1 *purchaseOrderModel;

@property(nonatomic,strong)NSString *stockInTime;






@property(nonatomic,strong)NSDictionary *purchaseOrderInvoice_ed;
@property(nonatomic,strong)Model1 *purchaseOrderInvoice_model;

@property(nonatomic,strong)NSString *companyNameCn;
@property(nonatomic,strong)NSString *companyNameEn;



@property(nonatomic,strong)NSDictionary *configAddrType;
@property(nonatomic,strong)Model1 *configAddrType_model;
@property(nonatomic,strong)NSString *receiveProvince;
@property(nonatomic,strong)NSString *receiveCity;
@property(nonatomic,strong)NSString *receiveArea;
@property(nonatomic,strong)NSString *receiveAddress;
@property(nonatomic,strong)NSString *zip;



@property(nonatomic,strong)NSString *person;

@property(nonatomic,strong)NSDictionary *configDept;
@property(nonatomic,strong)Model1 *configDept_model;

@property(nonatomic,strong)NSString *qq;
@property(nonatomic,strong)NSString *wechat;
@property(nonatomic,strong)NSString *telephone;
@property(nonatomic,strong)NSString *mobile;
@property(nonatomic,strong)NSString *email;




@property(nonatomic,strong)NSString *companyName;
@property(nonatomic,strong)NSString *payerCode;
@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSString *bankName;
@property(nonatomic,strong)NSString *bankAccount;



@property(nonatomic,strong)NSString *bankNo;



//
@property(nonatomic,strong)NSDictionary *parts;
@property(nonatomic,strong)Model1 *parts_model;
@property(nonatomic,strong)NSString *supplierPartsCode;
@property(nonatomic,strong)NSString *purchasePrice;
@property(nonatomic,strong)NSString *applyPrice;
@property(nonatomic,strong)NSString *picture;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *unit;
@property(nonatomic,strong)NSString *classify;


@property(nonatomic,strong)NSString *isAftersalePart;
@property(nonatomic,strong)NSString *isCountable;
@property(nonatomic,strong)NSString *stop;


//
@property(nonatomic,strong)NSDictionary *tradeGoods;
@property(nonatomic,strong)Model1 *tradeGoods_model;


@property(nonatomic,strong)NSString *supplierTradeCode;

@property(nonatomic,strong)NSString *image_url;
@property(nonatomic,strong)NSString *part_no;
@property(nonatomic,strong)NSString *part_name;
@property(nonatomic,strong)NSString *total_amount;



@end
