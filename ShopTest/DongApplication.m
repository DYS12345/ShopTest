//
//  DongApplication.m
//  ShopTest
//
//  Created by dong on 2017/9/29.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "DongApplication.h"

@implementation DongApplication

-(void)sendEvent:(UIEvent *)event{
    [super sendEvent:event];
    if(!_myidleTimer){
        [self resetIdleTimer:0];
    }
    NSSet *allTouches = [event allTouches];
    if(allTouches.count > 0){
        UITouchPhase phase = ((UITouch*)[allTouches anyObject]).phase;
        if (phase == UITouchPhaseBegan) {
            [self resetIdleTimer:0];
        }
    }
}

-(void)resetIdleTimer:(NSInteger)n{
    if(_myidleTimer){
        [_myidleTimer invalidate];
    }
    if (n == 0) {
        int timeout = KApplicationTimeoutInMinutes * 60;
        _myidleTimer = [NSTimer scheduledTimerWithTimeInterval:timeout target:self selector:@selector(idleTimerExceeded) userInfo:nil repeats:NO];
    } else {
        NSInteger timeout = n * 60;
        _myidleTimer = [NSTimer scheduledTimerWithTimeInterval:timeout target:self selector:@selector(idleTimerExceeded) userInfo:nil repeats:NO];
    }
}

-(void)idleTimerExceeded{
    [[NSNotificationCenter defaultCenter] postNotificationName:kApplicationDidTimeoutNotification object:nil];
}

@end
