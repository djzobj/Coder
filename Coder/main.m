//
//  main.m
//  Coder
//
//  Created by 张得军 on 2019/9/16.
//  Copyright © 2019 张得军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <objc/runtime.h>

@interface FXPerson : NSObject {
    NSString *nickname;
}
@property (nonatomic, copy) NSString *nationality;
+ (void)walk;
- (void)fly;
@end

@implementation FXPerson
+ (void)walk {}
- (void)fly {}
@end


int main(int argc, char * argv[]) {
    @autoreleasepool {
        id a= [FXPerson new];
        id p = [FXPerson class];
        id b = [FXPerson class];
        void *obj = &p;
        id d = object_getClass((__bridge id)obj);
        NSLog(@"");
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
