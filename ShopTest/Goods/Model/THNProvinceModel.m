//
//  THNProvinceModel.m
//  Fiu
//
//  Created by FLYang on 2016/10/21.
//  Copyright © 2016年 taihuoniao. All rights reserved.
//

#import "THNProvinceModel.h"

@implementation THNProvinceModel

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[@"_id"] isKindOfClass:[NSNull class]]){
        self.idField = dictionary[@"_id"];
    }
    if(![dictionary[@"created_on"] isKindOfClass:[NSNull class]]){
        self.createdOn = [dictionary[@"created_on"] integerValue];
    }
    if(![dictionary[@"layer"] isKindOfClass:[NSNull class]]){
        self.layer = [dictionary[@"layer"] integerValue];
    }
    if(![dictionary[@"name"] isKindOfClass:[NSNull class]]){
        self.cityName = dictionary[@"name"];
    }
    if(![dictionary[@"oid"] isKindOfClass:[NSNull class]]){
        self.oid = dictionary[@"oid"];
    }
    if(![dictionary[@"pid"] isKindOfClass:[NSNull class]]){
        self.pid = dictionary[@"pid"];
    }
    if(![dictionary[@"sort"] isKindOfClass:[NSNull class]]){
        self.sort = [dictionary[@"sort"] integerValue];
    }
    
    return self;
}

@end
