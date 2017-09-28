//
//  OrderModel.h
//  ShopTest
//
//  Created by dong on 2017/9/22.
//  Copyright © 2017年 dong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject

@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *status_label;
@property (nonatomic, copy) NSString *rid;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, copy) NSString *express_name; //物流
@property (nonatomic, copy) NSString *express_no; //运单号
@property (nonatomic, copy) NSString *items_count;
@property (nonatomic, copy) NSString *pay_money;
@property (nonatomic, copy) NSString *freight;
@property (nonatomic, copy) NSString *delivery_type;  //1、快递  2、自提

@end
