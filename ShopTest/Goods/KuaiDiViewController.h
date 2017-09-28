//
//  KuaiDiViewController.h
//  ShopTest
//
//  Created by dong on 2017/9/5.
//  Copyright © 2017年 dong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"
#import "GoodsDetailModel.h"

@interface KuaiDiViewController : UIViewController

@property(nonatomic, strong) UIImage *image;
@property (nonatomic, strong) GoodsDetailModel *model;
@property (nonatomic, copy) NSString *color;
@property (nonatomic, copy) NSString *rid;

@end
