//
//  PrintViewController.h
//  ShopTest
//
//  Created by dong on 2017/10/19.
//  Copyright © 2017年 dong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderModel;

@interface PrintViewController : UIViewController

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) OrderModel *model;

@end
