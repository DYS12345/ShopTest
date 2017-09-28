//
//  PaymentCodeViewController.h
//  ShopTest
//
//  Created by dong on 2017/9/5.
//  Copyright © 2017年 dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentCodeViewController : UIViewController

@property(nonatomic, strong) UIImage *image;
@property(nonatomic, copy) NSString *rid;
@property(nonatomic, copy) NSString *coin_money;
@property(nonatomic, copy) NSString *freight;
@property(nonatomic, copy) NSString *total_money;
@property (assign, nonatomic) NSInteger payWay; //1 weixin   2 zhifubao

@end
