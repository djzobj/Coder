//
//  DJZTimer.m
//  Coder
//
//  Created by 张得军 on 2019/10/18.
//  Copyright © 2019 张得军. All rights reserved.
//

#import "DJZTimer.h"

@interface DJZTimerForwarder : NSObject

- (instancetype)initWithWorker:(id)worker;

@end

@interface DJZTimerForwarder ()

@property (nonatomic, weak) id worker;

@end

@implementation DJZTimerForwarder

- (instancetype)initWithWorker:(id)worker {
    self = [super init];
    if (self) {
        _worker = worker;
    }
    return self;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    return [_worker methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    if ([_worker respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:_worker];
    }
}

@end

@interface DJZTimer ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) DJZTimerForwarder *forwarder;

@end

@implementation DJZTimer

+ (DJZTimer *)timerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo {
    DJZTimer *timer = [[DJZTimer alloc] initWithTimeInterval:ti target:aTarget selector:aSelector userInfo:userInfo repeats:yesOrNo];;
    return timer;
}

- (instancetype)initWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo  {
    self = [super init];
    if (self) {
        _forwarder = [[DJZTimerForwarder alloc] initWithWorker:aTarget];
        _timer = [NSTimer timerWithTimeInterval:ti target:_forwarder selector:aSelector userInfo:userInfo repeats:yesOrNo];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return self;
}

- (void)fire {
    [_timer fire];
}

- (void)invalidate {
    [_timer invalidate];
}

- (void)dealloc {
    [_timer invalidate];
    _timer = nil;
}

@end
