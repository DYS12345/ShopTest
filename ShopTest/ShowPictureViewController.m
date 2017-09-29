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

@interface ShowPictureViewController () <SDCycleScrollViewDelegate>

@end

@implementation ShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSArray *imageNames = @[@"1.png",
                            @"2.png",
                            @"3.png",
                            @"4.png",
                            @"5.png",
                            @"6.png",
                            @"7.png",
                            @"8.png",
                            @"9.png",
                            @"10.png",
                            @"11.png",
                            @"12.png",
                            @"13.png",
                            @"14.png",
                            @"15.png",
                            @"16.png",
                            @"17.png",
                            @"18.png"
                            ];
    
    SDCycleScrollView *cycleScrollView3 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) shouldInfiniteLoop:YES imageNamesGroup:imageNames];
    cycleScrollView3.delegate = self;
    cycleScrollView3.showPageControl = NO;
//    cycleScrollView3.imageURLStringsGroup = imagesURLStrings;
    [self.view addSubview:cycleScrollView3];
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
//    [((DongApplication*)[DongApplication sharedApplication]) resetIdleTimer];
    
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
