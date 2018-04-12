//
//  LoginViewController.m
//  ShopTest
//
//  Created by dong on 2017/8/30.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "LoginViewController.h"
#import "SVProgressHUD.h"
#import "FBAPI.h"
#import "FBConfig.h"
#import "UserModel.h"
#import "UIColor+Extension.h"
#import "GoodsViewController.h"

@interface LoginViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *psdTF;
@property (weak, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet UIView *psdView;
@property (weak, nonatomic) IBOutlet UIButton *psdSeeBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (nonatomic, strong) UIView *left;
@property (nonatomic, strong) UIView *left2;

@end

static NSString * const XMGPlacerholderColorKeyPath = @"_placeholderLabel.textColor";

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    [self circle:self.phoneView];
    [self circle:self.psdView];
    [self circle:self.loginBtn];
    
    [self.userNameTF setValue:[UIColor colorWithHexString:@"#8B8B8B"] forKeyPath:XMGPlacerholderColorKeyPath];
    self.userNameTF.tintColor = [UIColor whiteColor];
    self.userNameTF.leftView = self.left;
    self.userNameTF.leftViewMode = UITextFieldViewModeAlways;
    
    [self.psdTF setValue:[UIColor colorWithHexString:@"#8B8B8B"] forKeyPath:XMGPlacerholderColorKeyPath];
    self.psdTF.tintColor = [UIColor whiteColor];
    self.psdTF.leftView = self.left2;
    self.psdTF.leftViewMode = UITextFieldViewModeAlways;
    
    self.psdTF.delegate = self;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self login:self.loginBtn];
    return YES;
}

- (IBAction)psdSee:(UIButton*)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.psdTF.secureTextEntry = NO;
    } else {
        self.psdTF.secureTextEntry = YES;
    }
}

-(UIView *)left{
    if (!_left) {
        _left = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        _left.backgroundColor = [UIColor clearColor];
    }
    return _left;
}

-(UIView *)left2{
    if (!_left2) {
        _left2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        _left2.backgroundColor = [UIColor clearColor];
    }
    return _left2;
}

-(void)circle:(UIView*)sender{
    sender.layer.masksToBounds = YES;
    sender.layer.cornerRadius = 3;
}

- (IBAction)login:(id)sender {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD show];
    if (self.userNameTF.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"账号未填写"];
    } else if (self.psdTF.text.length < 6) {
        [SVProgressHUD showInfoWithStatus:@"密码位数不够"];
    } else {
        NSDictionary *params = @{
                                 @"mobile":self.userNameTF.text,
                                 @"password":self.psdTF.text,
                                 @"from_to":@4
                                 };
        FBRequest *request = [FBAPI postWithUrlString:@"/auth/login" requestDictionary:params delegate:self];
        [request startRequestSuccess:^(FBRequest *request, id result) {
            [SVProgressHUD dismiss];
            NSLog(@"wqddqw %@", result);
            if ([result[@"success"] integerValue] == 1) {
                NSDictionary *dataDict = [result objectForKey:@"data"];
                UserModel *model = [UserModel mj_objectWithKeyValues:dataDict];
                model.isLogin = YES;
                model.psd = self.psdTF.text;
                [model saveOrUpdate];
                GoodsViewController *vc = [GoodsViewController new];
                [self.navigationController pushViewController:vc animated:YES];
            } else {
                [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@", result[@"message"]]];
            }
        } failure:^(FBRequest *request, NSError *error) {
            [SVProgressHUD dismiss];
        }];
    }
}

@end
