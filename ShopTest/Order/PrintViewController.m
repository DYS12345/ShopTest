//
//  PrintViewController.m
//  ShopTest
//
//  Created by dong on 2017/10/19.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "PrintViewController.h"
#import "OrderModel.h"
#import "FBAPI.h"
#import "DKNightVersion.h"

@interface PrintViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *printSuccessView;
@property (weak, nonatomic) IBOutlet UIView *printFailView;
@property (weak, nonatomic) IBOutlet UIView *rePrintView;
@property (weak, nonatomic) IBOutlet UIImageView *printImageView;

@end

@implementation PrintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView.image = self.image;
    self.printSuccessView.hidden = YES;
    self.printFailView.hidden = YES;
    
    self.rePrintView.dk_backgroundColorPicker = DKColorPickerWithKey(priceText);
    self.rePrintView.layer.masksToBounds = YES;
    self.rePrintView.layer.cornerRadius = 2;
    
    NSMutableArray *imageAry = [NSMutableArray array];
    for (int i = 1; i<=60; i++) {
        NSString *str = [NSString stringWithFormat:@"d%04d", i];
        UIImage *image = [UIImage imageNamed:str];
        [imageAry addObject:image];
    }
    self.printImageView.animationImages = imageAry;
    self.printImageView.animationDuration = 6;
    self.printImageView.animationRepeatCount = 0;
    [self.printImageView startAnimating];
    
    NSDictionary *param = @{
                            @"rid" : self.model.rid
                            };
    FBRequest *request = [FBAPI postWithUrlString:@"/shopping/print_order" requestDictionary:param delegate:self];
    [request startRequestSuccess:^(FBRequest *request, id result) {
        if ([result[@"success"] integerValue] == 1) {
            [self.printImageView stopAnimating];
            self.printSuccessView.hidden = NO;
        } else {
            [self.printImageView stopAnimating];
            self.printFailView.hidden = NO;
        }
    } failure:^(FBRequest *request, NSError *error) {
    }];
}

- (IBAction)rePrint:(id)sender {
    self.printFailView.hidden = YES;
    [self.printImageView startAnimating];
    NSDictionary *param = @{
                            @"rid" : self.model.rid
                            };
    FBRequest *request = [FBAPI postWithUrlString:@"/shopping/print_order" requestDictionary:param delegate:self];
    [request startRequestSuccess:^(FBRequest *request, id result) {
        if ([result[@"success"] integerValue] == 1) {
            [self.printImageView stopAnimating];
            self.printSuccessView.hidden = NO;
        } else {
            [self.printImageView stopAnimating];
            self.printFailView.hidden = NO;
        }
    } failure:^(FBRequest *request, NSError *error) {
    }];
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
