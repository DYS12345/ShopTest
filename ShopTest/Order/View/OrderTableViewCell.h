//
//  OrderTableViewCell.h
//  ShopTest
//
//  Created by 董永胜 on 2017/9/21.
//  Copyright © 2017年 dong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderModel;
@class OrderDetailModel;

@interface OrderTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *pullBtn;
@property (weak, nonatomic) IBOutlet UIButton *pullClickBtn;
@property (weak, nonatomic) IBOutlet UILabel *pullLabel;
@property (weak, nonatomic) IBOutlet UIView *orderDetailView;
@property (strong, nonatomic) OrderModel *model;
@property (strong, nonatomic) OrderDetailModel *orderDetailModel;
@property (weak, nonatomic) IBOutlet UIButton *printBtn;

@end
