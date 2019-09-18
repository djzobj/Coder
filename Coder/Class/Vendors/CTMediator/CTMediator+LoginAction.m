//
//  CTMediator+LoginAction.m
//  Coder
//
//  Created by 张得军 on 2019/9/18.
//  Copyright © 2019 张得军. All rights reserved.
//

#import "CTMediator+LoginAction.h"

@implementation CTMediator (LoginAction)

- (UIViewController *)CTMediator_ViewControllerForLogin {
    UIViewController *controller = [self performTarget:@"Login" action:@"fetchViewController" params:nil];
    return controller;
}

@end
