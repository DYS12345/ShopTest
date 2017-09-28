//
//  OrderDetailModel.h
//  ShopTest
//
//  Created by dong on 2017/9/22.
//  Copyright © 2017年 dong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderDetailModel : NSObject

@property (nonatomic, copy) NSString *rid;
@property (nonatomic, copy) NSString *express_company;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, copy) NSString *delivery_type;  //1、快递  2、自提
@property (nonatomic, copy) NSString *express_no;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *zip;
@property (nonatomic, copy) NSString *freight;

@property (nonatomic, strong) NSArray *items;

@property (nonatomic, copy) NSString *cover_url;
@property (nonatomic, copy) NSString *sku;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *items_count;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *statusStr;

@end
