//
//  AppDelegate.m
//  ShopTest
//
//  Created by dong on 2017/8/30.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseNavController.h"
#import "Vc.h"
#import "LoginViewController.h"
#import "UserModel.h"
#import "GoodsViewController.h"
#import "SVProgressHUD.h"
#import "DKNightVersion.h"
#import "DKNightVersion.h"
#import "DongApplication.h"
#import "ShowPictureViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    UserModel *model = [[UserModel findAll] lastObject];
    BaseNavController *navVC;
    if (!model.isLogin) {
        navVC = [[BaseNavController alloc] initWithRootViewController:[LoginViewController new]];
    } else {
        navVC = [[BaseNavController alloc] initWithRootViewController:[GoodsViewController new]];
    }
    self.window.rootViewController = navVC;
    [self.window makeKeyAndVisible];
    
    UserModel *userModel = [[UserModel findAll] lastObject];
    if (!userModel.theme) {
        [DKNightVersionManager sharedManager].themeVersion = @"normal";
    } else {
        [DKNightVersionManager sharedManager].themeVersion = userModel.theme;
    }
    
    if ([[DKNightVersionManager sharedManager].themeVersion isEqualToString:@"normal"] | [[DKNightVersionManager sharedManager].themeVersion isEqualToString:@"hong"]) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }
    
    [SVProgressHUD setMaximumDismissTimeInterval:2];
    
    [((DongApplication*)[DongApplication sharedApplication]) resetIdleTimer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidTimeout:) name:kApplicationDidTimeoutNotification object:nil];
    
    return YES;
}

-(void)applicationDidTimeout:(NSNotification*)notif {
    ShowPictureViewController *vc = [ShowPictureViewController new];
    self.window.rootViewController = vc;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kApplicationDidTimeoutNotification object:nil];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {

}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
