//
//  UserModel.m
//  ShopTest
//
//  Created by dong on 2017/8/30.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"userId" : @"_id",
             @"storage_id" : @"identify.storage_id"
             };
}


@end
