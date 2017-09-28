//
//  SearchListModel.h
//  ShopTest
//
//  Created by dong on 2017/9/15.
//  Copyright © 2017年 dong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchListModel : NSObject

@property(nonatomic, copy) NSString *_id;
@property(nonatomic, copy) NSString *cover_url;
@property(nonatomic, copy) NSString *market_price;
@property(nonatomic, copy) NSString *sale_price;
@property(nonatomic, copy) NSString *title;

@end
