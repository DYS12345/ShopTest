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
        [self resetIdleTimer];
    }
    NSSet *allTouches = [event allTouches];
    if(allTouches.count > 0){
        UITouchPhase phase = ((UITouch*)[allTouches anyObject]).phase;
        if (phase == UITouchPhaseBegan) {
            [self resetIdleTimer];
        }
    }
}

-(void)resetIdleTimer{
    if(_myidleTimer){
        [_myidleTimer invalidate];
    }
    int timeout = KApplicationTimeoutInMinutes * 60;
    _myidleTimer = [NSTimer scheduledTimerWithTimeInterval:timeout target:self selector:@selector(idleTimerExceeded) userInfo:nil repeats:NO];
}

-(void)idleTimerExceeded{
    [[NSNotificationCenter defaultCenter] postNotificationName:kApplicationDidTimeoutNotification object:nil];
}

@end
