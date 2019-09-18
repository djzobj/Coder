//
//  DJZTarget_Login.m
//  Coder
//
//  Created by 张得军 on 2019/9/18.
//  Copyright © 2019 张得军. All rights reserved.
//

#import "DJZTarget_Login.h"
#import "DJZLoginViewController.h"

@implementation DJZTarget_Login

- (UIViewController *)Action_fetchViewController:(NSDictionary *)params {
    DJZLoginViewController *controller = [DJZLoginViewController new];
    
    return controller;
}

@end
