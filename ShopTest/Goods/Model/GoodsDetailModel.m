//
//  GoodsDetailModel.m
//  ShopTest
//
//  Created by dong on 2017/9/4.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "GoodsDetailModel.h"

@implementation GoodsDetailModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"title" : @"brand.title"
             };
}

@end
