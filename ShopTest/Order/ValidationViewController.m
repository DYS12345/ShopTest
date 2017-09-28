//
//  ValidationViewController.m
//  ShopTest
//
//  Created by dong on 2017/9/20.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "ValidationViewController.h"
#import "UserModel.h"
#import "SVProgressHUD.h"
#import "OrderViewController.h"
#import "ConsoleViewController.h"
#import "DKNightVersion.h"

@interface ValidationViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imgeView;
@property (weak, nonatomic) IBOutlet UIView *showView;
@property (weak, nonatomic) IBOutlet UIView *textView;
@property (weak, nonatomic) IBOutlet UITextField *tf;
@property (weak, nonatomic) IBOutlet UIButton *querenBtn;

@end

@implementation ValidationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imgeView.image = self.image;
    
    self.showView.layer.masksToBounds = YES;
    self.showView.layer.cornerRadius = 5;
    
    self.textView.layer.masksToBounds = YES;
    self.textView.layer.cornerRadius = 3;
    
    self.querenBtn.layer.masksToBounds = YES;
    self.querenBtn.layer.cornerRadius = 3;
    
    [self.querenBtn dk_setBackgroundColorPicker:DKColorPickerWithKey(priceText)];
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)display:(UIButton*)sender {
    sender.selected = !sender.selected;
    self.tf.secureTextEntry = !sender.selected;
}

- (IBAction)queren:(id)sender {
    if (self.tf.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请输入密码"];
    }
    UserModel *model = [[UserModel findAll] lastObject];
    if ([model.psd isEqualToString:self.tf.text]) {
        [self dismissViewControllerAnimated:YES completion:^{
            if (self.c == 2) {
                OrderViewController *vc = [OrderViewController new];
                [self.navi pushViewController:vc animated:YES];
            } else {
                ConsoleViewController *vc = [ConsoleViewController new];
                [self.navi pushViewController:vc animated:YES];
            }
        }];
    } else {
        [SVProgressHUD showErrorWithStatus:@"密码错误"];
    }
}

@end
