//
//  UserViewController.m
//  ShopTest
//
//  Created by dong on 2017/9/14.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "UserViewController.h"
#import "UserModel.h"
#import "DKNightVersion.h"
#import "FBAPI.h"
#import "LoginViewController.h"
#import "BaseNavController.h"
#import "OrderViewController.h"
#import "ValidationViewController.h"

@interface UserViewController ()

@property (weak, nonatomic) IBOutlet UIButton *balckBtn;
@property (weak, nonatomic) IBOutlet UIButton *redBtn;
@property (weak, nonatomic) IBOutlet UIButton *rwBtn;
@property (weak, nonatomic) IBOutlet UIButton *goldBtn;
@property (weak, nonatomic) IBOutlet UIButton *logOutBtn;

@end

@implementation UserViewController

- (IBAction)shopOrder:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        if ([self.delegate respondsToSelector:@selector(orderDismiss)]) {
            [self.delegate orderDismiss];
        }
    }];
}

- (IBAction)console:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        if ([self.delegate respondsToSelector:@selector(consoleDismiss)]) {
            [self.delegate consoleDismiss];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.logOutBtn dk_setBackgroundColorPicker:DKColorPickerWithKey(priceText)];
    self.logOutBtn.layer.masksToBounds = YES;
    self.logOutBtn.layer.cornerRadius = 3;
    
    UserModel *userModel = [[UserModel findAll] lastObject];
    if ([userModel.theme isEqualToString:@"normal"]) {
        self.balckBtn.selected = YES;
        self.balckBtn.userInteractionEnabled = NO;
    } else if ([userModel.theme isEqualToString:@"hong"]) {
        self.redBtn.selected = YES;
        self.redBtn.userInteractionEnabled = NO;
    } else if ([userModel.theme isEqualToString:@"hongbai"]) {
        self.rwBtn.selected = YES;
        self.rwBtn.userInteractionEnabled = NO;
    } else if ([userModel.theme isEqualToString:@"jin"]) {
        self.goldBtn.selected = YES;
        self.goldBtn.userInteractionEnabled = NO;
    }
}

- (IBAction)logOut:(id)sender {
    NSDictionary *param = @{
                            @"from_to" : @(4)
                            };
    FBRequest *request = [FBAPI postWithUrlString:@"/auth/logout" requestDictionary:param delegate:self];
    [request startRequestSuccess:^(FBRequest *request, id result) {
        [UserModel clearTable];
        BaseNavController *navVC = [[BaseNavController alloc] initWithRootViewController:[LoginViewController new]];
        [self presentViewController:navVC animated:YES completion:nil];
    } failure:^(FBRequest *request, NSError *error) {
        
    }];
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
