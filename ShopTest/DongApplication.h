//
//  DongApplication.h
//  ShopTest
//
//  Created by dong on 2017/9/29.
//  Copyright © 2017年 dong. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KApplicationTimeoutInMinutes 0.1
#define kApplicationDidTimeoutNotification @"ApplicationDidTimeout"

@interface DongApplication : UIApplication

{
    NSTimer *_myidleTimer;
}

@property (strong, nonatomic) NSArray *imageUrlAry;
@property (strong, nonatomic) NSArray *idOAry;

-(void)resetIdleTimer:(NSInteger)n;

@end
