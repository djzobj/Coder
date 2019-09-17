//
//  DJZNetWorking.m
//  Coder
//
//  Created by 张得军 on 2019/9/16.
//  Copyright © 2019 张得军. All rights reserved.
//

#import "DJZNetWorking.h"

@implementation DJZNetWorking

+ (RACSignal *)loginWithUserName:(NSString *)name password:(NSString *)password {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:@"登录成功"];
            [subscriber sendCompleted];
        });
        return nil;
    }];
}

@end
