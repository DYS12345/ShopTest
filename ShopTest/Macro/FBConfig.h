//
//  FBConfig.h
//  fineix
//
//  Created by FLYang on 16/3/18.
//  Copyright © 2016年 taihuoniao. All rights reserved.
//

#ifndef FBConfig_h
#define FBConfig_h

// API ROOT URL
//#define kDomainBaseUrl @"https://m.taihuoniao.com/app/api"           //生产环境
#define kDomainBaseUrl @"https://api.taihuoniao.com"          //  上线正式环境
//#define kDomainBaseUrl @"http://t.taihuoniao.com/app/api"     //  开发环境

//  屏幕宽
#define SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height
//  屏幕高
#define SCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width

#define kAppDebug 1
#define KAppType              @"2"
#define kChannel              @"appstore"

// 客户端版本
#define kClientVersion        @"2.1.0"
#define kClientID             @"1415289600"
#define kClientSecret         @"545d9f8aac6b7a4d04abffe5"

#define kFontFamily           @"HelveticaNeue"

// App Store ID
#define kAppStoreId           @"Fiu2.0"
#define kAppName              @"Fiu"

// Error Domain
#define kDomain               @"TaiHuoNiao"
#define kServerError          60001
#define kParseError           60002
#define kNetError             60003

#define kUserInfoPath         @"FB__StoreUserInfo__"
#define kLocalKeyUUID         @"FB__UUID__"

#define WEAKSELF  __weak __typeof(self)weakSelf = self;
#endif /* FBConfig_h */
