//
//  OrderModel.m
//  ShopTest
//
//  Created by dong on 2017/9/22.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "OrderModel.h"
#import "MJExtension.h"

@implementation OrderModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"quantity" : @"items.quantity",
             @"name" : @"express_info.name"
             };
}

@end
