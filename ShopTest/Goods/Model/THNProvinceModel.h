//
//  THNProvinceModel.h
//  Fiu
//
//  Created by FLYang on 2016/10/21.
//  Copyright © 2016年 taihuoniao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THNProvinceModel : NSObject

@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) NSString * oid;
@property (nonatomic, strong) NSString * pid;
@property (nonatomic, assign) NSInteger layer;
@property (nonatomic, strong) NSString * cityName;
@property (nonatomic, assign) NSInteger sort;
@property (nonatomic, assign) NSInteger createdOn;
@property (nonatomic, assign) NSInteger updatedOn;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
