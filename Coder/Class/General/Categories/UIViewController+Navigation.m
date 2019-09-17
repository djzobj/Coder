//
//  UIViewController+Navigation.m
//  Coder
//
//  Created by 张得军 on 2019/9/17.
//  Copyright © 2019 张得军. All rights reserved.
//

#import "UIViewController+Navigation.h"
#import <objc/runtime.h>

@implementation UIViewController (Navigation)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method origin_viewWillAppear = class_getInstanceMethod(self, @selector(viewWillAppear:));
        Method navigation_viewWillAppear = class_getInstanceMethod(self, @selector(navigation_viewWillAppear:));
        method_exchangeImplementations(origin_viewWillAppear, navigation_viewWillAppear);
    });
}

- (void)navigation_viewWillAppear:(BOOL)animation {
    if (self.navigationController.viewControllers.count > 1) {
        UIImage *image = [UIImage imageNamed:@"ico_back_gray"];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(doBack)];
        self.navigationItem.leftBarButtonItem = item;
    }
    [self.navigationController setNavigationBarHidden:NO animated:animation];
    self.view.backgroundColor = [UIColor whiteColor];
    [self navigation_viewWillAppear:animation];
}

- (void)doBack {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
