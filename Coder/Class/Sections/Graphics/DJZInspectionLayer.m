//
//  DJZInspectionLayer.m
//  Coder
//
//  Created by 张得军 on 2020/1/15.
//  Copyright © 2020 张得军. All rights reserved.
//

#import "DJZInspectionLayer.h"

@implementation DJZInspectionLayer

- (void)addAnimation:(CAAnimation *)anim forKey:(NSString *)key {
    NSLog(@"adding animation: %@", [anim debugDescription]);
    [super addAnimation:anim forKey:key];
}

- (id<CAAction>)actionForKey:(NSString *)event {
    
    id action = [super actionForKey:event];
    if (action) {
        
    }
    return action;
}

@end
