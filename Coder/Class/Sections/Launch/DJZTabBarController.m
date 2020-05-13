//
//  DJZTabBarController.m
//  Coder
//
//  Created by 张得军 on 2019/9/17.
//  Copyright © 2019 张得军. All rights reserved.
//

#import "DJZTabBarController.h"
#import "DJZNavigationController.h"
#import "DJZHomeViewController.h"

@implementation DJZTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addItems];
}

- (void)addItems {
    DJZNavigationController *navigationController = [[DJZNavigationController alloc] initWithRootViewController:[DJZHomeViewController new]];
    navigationController.tabBarItem.title = @"首页";
    self.viewControllers = @[navigationController];
}

@end
