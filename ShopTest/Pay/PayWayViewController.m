//
//  PayWayViewController.m
//  ShopTest
//
//  Created by dong on 2017/9/13.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "PayWayViewController.h"
#import "DKNightVersion.h"
#import "PaymentCodeViewController.h"

@interface PayWayViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@property (weak, nonatomic) IBOutlet UIView *showView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *zhifubaoStateBtn;
@property (weak, nonatomic) IBOutlet UIButton *weixinStateBtn;
@property (assign, nonatomic) NSInteger payWay; //1 weixin   2 zhifubao

@end

@implementation PayWayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView.image = self.image;
    
    self.buyBtn.layer.masksToBounds = YES;
    self.buyBtn.layer.cornerRadius = 3;
    [self.buyBtn dk_setBackgroundColorPicker:DKColorPickerWithKey(priceText)];
    
    self.showView.layer.masksToBounds = YES;
    self.showView.layer.cornerRadius = 5;
    
    self.priceLabel.text = [NSString stringWithFormat:@"应付款：￥%.0f", [self.total_money floatValue] - [self.coin_money floatValue] + [self.freight floatValue]];
    self.priceLabel.dk_textColorPicker = DKColorPickerWithKey(priceText);
    
    [self.weixinStateBtn dk_setImage:DKImagePickerWithNames(@"Selectedblack", @"red", @"red", @"SelectedGolden") forState:UIControlStateSelected];
    [self.zhifubaoStateBtn dk_setImage:DKImagePickerWithNames(@"Selectedblack", @"red", @"red", @"SelectedGolden") forState:UIControlStateSelected];
    
    self.weixinStateBtn.selected = YES;
    self.weixinStateBtn.userInteractionEnabled = NO;
    self.payWay = 1;
}

- (IBAction)buy:(id)sender {
    PaymentCodeViewController *vc = [PaymentCodeViewController new];
    vc.payWay = self.payWay;
    vc.image = self.image;
    vc.rid = self.rid;
    vc.coin_money = self.coin_money;
    vc.freight = self.freight;
    vc.total_money = self.total_money;
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)selectZhifubao:(id)sender {
    self.payWay = 2;
    self.zhifubaoStateBtn.selected = YES;
    self.zhifubaoStateBtn.userInteractionEnabled = NO;
    self.weixinStateBtn.selected = NO;
    self.weixinStateBtn.userInteractionEnabled = YES;
}

- (IBAction)selectWeiXin:(id)sender {
    self.payWay = 1;
    self.zhifubaoStateBtn.selected = NO;
    self.zhifubaoStateBtn.userInteractionEnabled = YES;
    self.weixinStateBtn.selected = YES;
    self.weixinStateBtn.userInteractionEnabled = NO;
}

- (IBAction)otherClose:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
