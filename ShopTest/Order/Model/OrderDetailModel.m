//
//  OrderDetailModel.m
//  ShopTest
//
//  Created by dong on 2017/9/22.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "OrderDetailModel.h"
#import "MJExtension.h"

@implementation OrderDetailModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"userName" : @"express_info.name",
             @"phone" : @"express_info.phone",
             @"address" : @"express_info.address",
             @"zip" : @"express_info.zip",
             @"cover_url" : @"items.cover_url"
             };
}

@end
