//
//  DJZLoginView.m
//  Coder
//
//  Created by 张得军 on 2019/9/16.
//  Copyright © 2019 张得军. All rights reserved.
//

#import "DJZLoginView.h"

@implementation DJZLoginView

- (instancetype)initWithViewModel:(DJZLoginViewModel *)viewModel {
    self = [super init];
    if (self) {
        [self setViewModel:viewModel];
    }
    return self;
}

@end
