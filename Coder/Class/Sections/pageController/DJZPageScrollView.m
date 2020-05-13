//
//  DJZPageScrollView.m
//  Coder
//
//  Created by 张得军 on 2019/12/19.
//  Copyright © 2019 张得军. All rights reserved.
//

#import "DJZPageScrollView.h"

@interface DJZPageScrollView ()<UIGestureRecognizerDelegate>

@end

@implementation DJZPageScrollView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
