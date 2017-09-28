//
//  THNChooseCityViewController.h
//  Fiu
//
//  Created by FLYang on 2016/10/19.
//  Copyright © 2016年 taihuoniao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBAPI.h"


/**
 获取选择的地址id

 @param provinceId 省份id 1级
 @param cityId     城市id 2级
 @param countyId   地区id 3级
 @param streetId   街道id 4级
 */
typedef void(^GetChooseAddressId)(NSString *provinceId, NSString *cityId, NSString *countyId, NSString *streetId);


/**
 获取选择的地址名称

 @param provinceName 省份
 @param cityName     城市
 @param countyName   地区
 @param streetName   街道
 */
typedef void(^GetChooseAddressName)(NSString *provinceName, NSString *cityName, NSString *countyName, NSString *streetName);

@interface THNChooseCityViewController : UIViewController<
    UITableViewDelegate,
    UITableViewDataSource,
    UIScrollViewDelegate
>

/**
 省份
 */
@property (nonatomic, strong) FBRequest *provinceRequest;
@property (nonatomic, strong) UITableView *chooseCityTable;
@property (nonatomic, strong) NSMutableArray *provinceMarr;
@property (nonatomic, strong) NSMutableArray *provinceIdMarr;

/**
 城市
 */
@property (nonatomic, strong) FBRequest *cityRequest;
@property (nonatomic, strong) NSMutableArray *cityMarr;
@property (nonatomic, strong) NSMutableArray *cityIdMarr;

/**
 地区
 */
@property (nonatomic, strong) FBRequest *countyRequest;
@property (nonatomic, strong) NSMutableArray *countyMarr;
@property (nonatomic, strong) NSMutableArray *countyIdMarr;

/**
 街道
 */
@property (nonatomic, strong) FBRequest *streetRequest;
@property (nonatomic, strong) NSMutableArray *streetMarr;
@property (nonatomic, strong) NSMutableArray *streetIdMarr;

/**
 选择地址提示视图
 */
@property (nonatomic, strong) UIView *promptView;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UILabel *textLable;

/**
 获取选择的地址id
 */
@property (nonatomic, copy) GetChooseAddressId getChooseAddressId;
@property (nonatomic, strong) NSMutableArray *addressIdMarr;

/**
 获取选择的地址名称
 */
@property (nonatomic, copy) GetChooseAddressName getChooseAddressName;
@property (nonatomic, strong) NSMutableArray *addressNameMarr;

@end
