//
//  UserModel.h
//  ShopTest
//
//  Created by dong on 2017/8/30.
//  Copyright © 2017年 dong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKDBModel.h"
#import "MJExtension.h"

@interface UserModel : JKDBModel

@property (nonatomic, assign) BOOL isLogin;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *true_nickname;
@property (nonatomic, copy) NSString *first_login;
@property (nonatomic, copy) NSString *storage_id;
@property (nonatomic, copy) NSString *theme;
@property (nonatomic, strong) NSArray *searhHistoryAry;
@property (nonatomic, copy) NSString *psd;

@end
