//
//  UserViewController.h
//  ShopTest
//
//  Created by dong on 2017/9/14.
//  Copyright © 2017年 dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UserViewControllerDelegate <NSObject>

-(void)orderDismiss;
-(void)consoleDismiss;

@end

@interface UserViewController : UIViewController

@property(nonatomic, strong) UINavigationController *navi;
@property(nonatomic, strong) UIViewController *goodsVc;
@property(nonatomic, weak) id <UserViewControllerDelegate> delegate;

@end
