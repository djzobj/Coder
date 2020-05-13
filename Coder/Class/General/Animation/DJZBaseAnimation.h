//
//  DJZBaseAnimation.h
//  Coder
//
//  Created by 张得军 on 2020/3/25.
//  Copyright © 2020 张得军. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DJZBaseAnimation : NSObject<UIViewControllerAnimatedTransitioning>

@property(nonatomic,assign)UINavigationControllerOperation transitionType;
@property(nonatomic,strong,readwrite)UIPercentDrivenInteractiveTransition *interactivePopTransition;

@end

NS_ASSUME_NONNULL_END
