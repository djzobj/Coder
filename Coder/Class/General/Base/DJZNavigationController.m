//
//  DJZNavigationController.m
//  Coder
//
//  Created by 张得军 on 2019/9/17.
//  Copyright © 2019 张得军. All rights reserved.
//

#import "DJZNavigationController.h"
#import "DJZBaseAnimation.h"
#import "DJZBaseVC.h"

@interface DJZNavigationController () <UINavigationControllerDelegate>

@end

@implementation DJZNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.translucent = NO;
    //self.delegate = self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count >= 1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(DJZBaseAnimation *)animationController {
    return animationController.interactivePopTransition;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(DJZBaseVC *)fromVC toViewController:(DJZBaseVC *)toVC {
    if (fromVC.interactivePopTransition) {
        DJZBaseAnimation *animation = [DJZBaseAnimation new];
        animation.transitionType = operation;
        animation.interactivePopTransition = fromVC.interactivePopTransition;
        return animation;
    }else {
        DJZBaseAnimation *animation = [DJZBaseAnimation new];
        animation.transitionType = operation;
        return animation;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
