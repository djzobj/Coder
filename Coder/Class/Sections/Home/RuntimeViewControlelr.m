//
//  RuntimeViewControlelr.m
//  Miss
//
//  Created by 张得军 on 2018/11/1.
//  Copyright © 2018 djz. All rights reserved.
//

#import "RuntimeViewControlelr.h"
#import <objc/runtime.h>


void dynamicMethodIMP(id reciver, SEL _cmd, int index) {
    NSLog(@"动态解析实现了");
}

@interface Sark : NSObject
@property (nonatomic, copy) NSString *name;
- (void)speak;
@end
@implementation Sark
- (void)speak {
    NSLog(@"my name's %@", self.name);
}
@end

@interface RuntimeViewControlelr ()

@end

@implementation RuntimeViewControlelr

- (void)viewDidLoad {
    [super viewDidLoad];
        NSLog(@"ViewController = %@ , 地址 = %p", self, &self);
    
       id cls = [Sark class];
       NSLog(@"Sark class = %@ 地址 = %p", cls, &cls);
    
       void *obj = &cls;
       NSLog(@"Void *obj = %@ 地址 = %p", obj,&obj);
    
       [(__bridge id)obj speak];
    
       Sark *sark = [[Sark alloc]init];
       NSLog(@"Sark instance = %@ 地址 = %p",sark,&sark);
    
       [sark speak];
       
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, NULL);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        
    });
    dispatch_resume(timer);

}

- (void)unkonwFunc:(NSString *)name {
    NSLog(@"未知函数");
}

+ (BOOL)resolveClassMethod:(SEL)sel {
    if (sel == @selector(eat)) {
        class_addMethod(object_getClass(self), sel, (IMP)dynamicMethodIMP, "v@:");
        return YES;
    }
    return [super resolveClassMethod:sel];
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(eat)) {
        class_addMethod([self class], sel, (IMP)dynamicMethodIMP, "v@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return [super forwardingTargetForSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *signature = [NSMethodSignature signatureWithObjCTypes:"v@:@"];

    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    
    SEL seletor = anInvocation.selector;
    NSString *name = NSStringFromSelector(seletor);
    NSInteger args = anInvocation.methodSignature.numberOfArguments;
    anInvocation.target = self;
    anInvocation.selector = @selector(unkonwFunc:);
    void *argBuff = NULL;
    [anInvocation setArgument:&name atIndex:2];
    [anInvocation invoke];
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
