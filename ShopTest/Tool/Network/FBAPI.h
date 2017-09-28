//
//  FBAPI.h
//  parrot
//
//  Created by xiaoyi on 15/11/15.
//  Copyright © 2015年 taihuoniao. All rights reserved.
//

#import "FBRequest.h"

@interface FBAPI : FBRequest

- (NSString *)uuid;
- (NSString *)time;
- (NSString *)apptype;

+ (instancetype)getWithUrlString:(NSString *)urlString
               requestDictionary:(NSDictionary *)requestDictionary
                        delegate:(id)delegate;

+ (instancetype)postWithUrlString:(NSString *)urlString
                requestDictionary:(NSDictionary *)requestDictionary
                         delegate:(id)delegate;

+ (instancetype)uploadWithUrlString:(NSString *)urlString
                  requestDictionary:(NSDictionary *)requestDictionary
                           delegate:(id)delegate;

@end
