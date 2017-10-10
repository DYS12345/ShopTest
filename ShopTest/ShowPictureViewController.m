//
//  ShowPictureViewController.m
//  ShopTest
//
//  Created by dong on 2017/9/29.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "ShowPictureViewController.h"
#import "UserModel.h"
#import "BaseNavController.h"
#import "LoginViewController.h"
#import "GoodsViewController.h"
#import "SDCycleScrollView.h"
#import "FBConfig.h"
#import "DongApplication.h"
#import "FBAPI.h"
#import "RowsModel.h"
#import "GoodsDetailModel.h"

@interface ShowPictureViewController () <SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView3;

@end

@implementation ShowPictureViewController

-(SDCycleScrollView *)cycleScrollView3{
    if (!_cycleScrollView3) {
        _cycleScrollView3 = [SDCycleScrollView new];
        _cycleScrollView3.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }
    return _cycleScrollView3;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cycleScrollView3.imageURLStringsGroup = ((DongApplication*)[DongApplication sharedApplication]).imageUrlAry;
    _cycleScrollView3.delegate = self;
    _cycleScrollView3.showPageControl = NO;
    [self.view addSubview:_cycleScrollView3];
    
//    NSArray *imageNames = @[@"1.png",
//                            @"2.png",
//                            @"3.png",
//                            @"4.png",
//                            @"5.png",
//                            @"6.png",
//                            @"7.png",
//                            @"8.png",
//                            @"9.png",
//                            @"10.png",
//                            @"11.png",
//                            @"12.png",
//                            @"13.png",
//                            @"14.png",
//                            @"15.png",
//                            @"16.png",
//                            @"17.png",
//                            @"18.png"
//                            ];
    
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
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