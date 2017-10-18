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
#import "ShowPoictureStaticViewController.h"

@interface ShowPictureViewController () <SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet SDCycleScrollView *cycleScrollView3;

@end

@implementation ShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cycleScrollView3.imageURLStringsGroup = ((DongApplication*)[DongApplication sharedApplication]).imageUrlAry;
    _cycleScrollView3.delegate = self;
    _cycleScrollView3.showPageControl = NO;
    _cycleScrollView3.titleLabelHeight = 125;
    _cycleScrollView3.titleLabelTextAlignment = NSTextAlignmentCenter;
    _cycleScrollView3.titleLabelTextFont = [UIFont systemFontOfSize:30];
    [self.view addSubview:_cycleScrollView3];
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    [((DongApplication*)[DongApplication sharedApplication]) resetIdleTimer:1000000000];
    
    ShowPoictureStaticViewController *vc = [ShowPoictureStaticViewController new];
    vc.image = [self fullScreenshots];
    vc.idStr = ((DongApplication*)[DongApplication sharedApplication]).idOAry[index];
    [self presentViewController:vc animated:NO completion:nil];
}

-(UIImage*)fullScreenshots{
    
    UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];
    
    UIGraphicsBeginImageContext(screenWindow.frame.size);//全屏截图，包括window
    
    [screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *viewImage =UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return viewImage;
}

@end
