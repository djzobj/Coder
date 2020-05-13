//
//  UIViewController+naviagtion.m
//  Coder
//
//  Created by 张得军 on 2020/4/17.
//  Copyright © 2020 张得军. All rights reserved.
//

#import "UIViewController+naviagtion.h"
#import <objc/runtime.h>

@implementation UIViewController (naviagtion)

+ (void)load {
    Method originMethod = class_getInstanceMethod(self, @selector(viewWillAppear:));
    Method hookMethod = class_getInstanceMethod(self, @selector(hook_viewWillAppear:));
    method_exchangeImplementations(originMethod, hookMethod);
}

- (void)hook_viewWillAppear:(BOOL)animated {
    if (self.navigationController.viewControllers.count > 1) {
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftBtn setBackgroundImage:[UIImage imageNamed:@"ico_back_gray"] forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(doBack) forControlEvents:UIControlEventTouchUpInside];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    }
    [self hook_viewWillAppear:animated];
}

- (void)doBack {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
