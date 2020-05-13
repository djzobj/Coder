//
//  DJZBaseAnimation.m
//  Coder
//
//  Created by 张得军 on 2020/3/25.
//  Copyright © 2020 张得军. All rights reserved.
//

#import "DJZBaseAnimation.h"


@interface DJZBaseAnimation ()<CAAnimationDelegate>
@property (nonatomic, weak) id<UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic, assign) BOOL isPush;
@property (nonatomic, assign) BOOL tabbarFlag;
@end

@implementation DJZBaseAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.4;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    if (self.transitionType == UINavigationControllerOperationPush) {
        [self push:transitionContext];
    }else if (self.transitionType == UINavigationControllerOperationPop) {
        [self pop:transitionContext];
    }
}

- (void)push:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    CGRect bounds = toVC.view.frame;
    UIView *containerView = [transitionContext containerView];
    toVC.view.frame = (CGRect){CGPointMake(bounds.size.width, 0), bounds.size};
    [containerView addSubview:toVC.view];
    
    [UIView animateWithDuration:duration animations:^{
        toVC.view.frame = bounds;
    } completion:^(BOOL finished) {
        [self.transitionContext completeTransition:YES];
    }];
}

- (void)pop:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    CGRect bounds = toVC.view.frame;
    UIView *containerView = [transitionContext containerView];
    toVC.view.frame = (CGRect){CGPointZero, bounds.size};
    [containerView insertSubview:toVC.view belowSubview:fromVC.view];
    
    [UIView animateWithDuration:duration animations:^{
        fromVC.view.frame = (CGRect){CGPointMake(bounds.size.width, 0), bounds.size};
    } completion:^(BOOL finished) {
        [fromVC.view removeFromSuperview];
        [self.transitionContext completeTransition:YES];
    }];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
}

@end
