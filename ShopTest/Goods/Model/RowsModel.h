//
//  RowsModel.h
//  ShopTest
//
//  Created by dong on 2017/8/31.
//  Copyright © 2017年 dong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsModel.h"

@interface RowsModel : NSObject

@property(nonatomic, copy) NSString *_id;
@property(nonatomic, copy) NSString *created_on;
@property(nonatomic, strong) GoodsModel *product;
@property(nonatomic, copy) NSString *product_id;
@property(nonatomic, copy) NSString *scene_id;
@property(nonatomic, copy) NSString *status;
@property(nonatomic, copy) NSString *type;
@property(nonatomic, copy) NSString *tag;

@end
