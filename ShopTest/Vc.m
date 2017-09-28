//
//  Vc.m
//  ShopTest
//
//  Created by dong on 2017/8/30.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "Vc.h"
#import "LoginViewController.h"
#import "GoodsViewController.h"

@interface Vc ()

@end

@implementation Vc

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)login:(id)sender {
    LoginViewController *vc = [LoginViewController new];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)goods:(id)sender {
    GoodsViewController *vc = [GoodsViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
