//
//  GoodsDetailModel.h
//  ShopTest
//
//  Created by dong on 2017/9/4.
//  Copyright © 2017年 dong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
#import "Sku.h"

@interface GoodsDetailModel : NSObject

@property (nonatomic, strong) NSArray *asset;
@property (nonatomic, strong) NSArray *pad_asset;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *skus_count;
@property (nonatomic, copy) NSString *market_price;
@property (nonatomic, copy) NSString *sale_price;
@property (nonatomic, copy) NSString *short_title;
@property (nonatomic, copy) NSString *advantage;
@property (nonatomic, strong) NSArray *skus;
@property (nonatomic, copy) NSString *cover_url;

@end
