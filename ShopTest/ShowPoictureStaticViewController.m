//
//  ShowPoictureStaticViewController.m
//  ShopTest
//
//  Created by dong on 2017/10/17.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "ShowPoictureStaticViewController.h"
#import "UserModel.h"
#import "BaseNavController.h"
#import "LoginViewController.h"
#import "GoodsViewController.h"
#import "FBAPI.h"
#import "GoodsDetailModel.h"
#import "GoodsDetailViewController.h"
#import "DKNightVersion.h"

@interface ShowPoictureStaticViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *decLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;

@end

@implementation ShowPoictureStaticViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView.image = self.image;
    
    NSDictionary *param2 = @{
                             @"id" : self.idStr
                             };
    FBRequest *request2 = [FBAPI postWithUrlString:@"/product/view" requestDictionary:param2 delegate:self];
    [request2 startRequestSuccess:^(FBRequest *request, id result) {
        GoodsDetailModel *detailModel = [GoodsDetailModel mj_objectWithKeyValues:result[@"data"]];
        self.titleLabel.text = detailModel.short_title;
        self.decLabel.text = detailModel.advantage;
        self.priceLabel.text = [NSString stringWithFormat:@"￥%@", detailModel.sale_price];
    } failure:^(FBRequest *request, NSError *error) {
        
    }];
    
    self.priceLabel.dk_textColorPicker = DKColorPickerWithKey(priceText);
    self.detailBtn.dk_backgroundColorPicker = DKColorPickerWithKey(priceText);
}

- (IBAction)buyTap:(id)sender {
    GoodsDetailViewController *vc = [GoodsDetailViewController new];
    vc.infoId = self.idStr;
    vc.flagCategory = 2;
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)close:(id)sender {
    UserModel *model = [[UserModel findAll] lastObject];
    BaseNavController *navVC;
    if (!model.isLogin) {
        navVC = [[BaseNavController alloc] initWithRootViewController:[LoginViewController new]];
    } else {
        navVC = [[BaseNavController alloc] initWithRootViewController:[GoodsViewController new]];
    }
    [UIApplication sharedApplication].keyWindow.rootViewController = navVC;
}

@end
