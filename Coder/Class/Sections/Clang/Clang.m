//
//  Clang.m
//  Coder
//
//  Created by 张得军 on 2019/10/22.
//  Copyright © 2019 张得军. All rights reserved.
//

#import "Clang.h"

@implementation Clang

- (void)test {
    NSInteger a = 0;
    void(^block)(void) = ^() {
        NSLog(@"------%d", a);
    };
}

@end
