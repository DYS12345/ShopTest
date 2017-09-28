//
//  ThemeViewController.m
//  ShopTest
//
//  Created by dong on 2017/9/13.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "ThemeViewController.h"
#import "UserModel.h"
#import "DKNightVersion.h"

@interface ThemeViewController ()

@property (weak, nonatomic) IBOutlet UIButton *balckBtn;
@property (weak, nonatomic) IBOutlet UIButton *redBtn;
@property (weak, nonatomic) IBOutlet UIButton *rwBtn;
@property (weak, nonatomic) IBOutlet UIButton *goldBtn;

@end

@implementation ThemeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)black:(UIButton*)sender {
    sender.selected = YES;
    sender.userInteractionEnabled = NO;
    self.redBtn.selected = NO;
    self.redBtn.userInteractionEnabled = YES;
    self.rwBtn.selected = NO;
    self.rwBtn.userInteractionEnabled = YES;
    self.goldBtn.selected = NO;
    self.goldBtn.userInteractionEnabled = YES;
    
    UserModel *usermodel = [[UserModel findAll] lastObject];
    usermodel.theme = @"normal";
    [usermodel saveOrUpdate];
    [DKNightVersionManager sharedManager].themeVersion = @"normal";
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (IBAction)red:(UIButton*)sender {
    sender.selected = YES;
    sender.userInteractionEnabled = NO;
    self.balckBtn.selected = NO;
    self.balckBtn.userInteractionEnabled = YES;
    self.rwBtn.selected = NO;
    self.rwBtn.userInteractionEnabled = YES;
    self.goldBtn.selected = NO;
    self.goldBtn.userInteractionEnabled = YES;
    
    UserModel *usermodel = [[UserModel findAll] lastObject];
    usermodel.theme = @"hong";
    [usermodel saveOrUpdate];
    [DKNightVersionManager sharedManager].themeVersion = @"hong";
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (IBAction)rw:(UIButton*)sender {
    sender.selected = YES;
    sender.userInteractionEnabled = NO;
    self.redBtn.selected = NO;
    self.redBtn.userInteractionEnabled = YES;
    self.balckBtn.selected = NO;
    self.balckBtn.userInteractionEnabled = YES;
    self.goldBtn.selected = NO;
    self.goldBtn.userInteractionEnabled = YES;
    
    UserModel *usermodel = [[UserModel findAll] lastObject];
    usermodel.theme = @"hongbai";
    [usermodel saveOrUpdate];
    [DKNightVersionManager sharedManager].themeVersion = @"hongbai";
}

- (IBAction)gold:(UIButton*)sender {
    sender.selected = YES;
    sender.userInteractionEnabled = NO;
    self.redBtn.selected = NO;
    self.redBtn.userInteractionEnabled = YES;
    self.rwBtn.selected = NO;
    self.rwBtn.userInteractionEnabled = YES;
    self.balckBtn.selected = NO;
    self.balckBtn.userInteractionEnabled = YES;
    
    UserModel *usermodel = [[UserModel findAll] lastObject];
    usermodel.theme = @"jin";
    [usermodel saveOrUpdate];
    [DKNightVersionManager sharedManager].themeVersion = @"jin";
}

@end
