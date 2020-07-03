//
//  ThreadViewController.m
//  Miss
//
//  Created by 张得军 on 2018/11/23.
//  Copyright © 2018 djz. All rights reserved.
//

#import "ThreadViewController.h"

@interface NSRunLoop (Hook)

@end

@implementation NSRunLoop (Hook)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //[self _swizzleImpWithOrigin:@selector(runMode:beforeDate:) swizzle:@selector(xd_runMode:beforeDate:)];
    });
}

+ (void)_swizzleImpWithOrigin:(SEL)originSelector swizzle:(SEL)swizzleSelector {

    Class _class = [self class];
    Method originMethod = class_getInstanceMethod(_class, originSelector);
    Method swizzleMethod = class_getInstanceMethod(_class, swizzleSelector);

    IMP originIMP = method_getImplementation(originMethod);
    IMP swizzleIMP = method_getImplementation(swizzleMethod);

    BOOL add = class_addMethod(_class, originSelector, swizzleIMP, method_getTypeEncoding(swizzleMethod));

    if (add) {
        class_addMethod(_class, swizzleSelector, originIMP, method_getTypeEncoding(originMethod));
    } else {
        method_exchangeImplementations(originMethod, swizzleMethod);
    }
}

- (BOOL)xd_runMode:(NSRunLoopMode)mode beforeDate:(NSDate *)limitDate {

    NSThread *thread = [NSThread currentThread];

    // 这里我们只对自己创建的线程runloop的`runMode:beforeDate:`方法进行修改.
    if ([thread.name isEqualToString:@"com.xindong.thread"]) {
        NSLog(@"runloop+hook: com.xindong.thread线程\n\n");
        return YES; //如果这里返回`NO`, runloop会立刻退出, 故要返回`YES`进行验证.
    }

    NSLog(@"runloop+hook: 其他可能未知的线程%@\n\n", thread.name);
    return [self xd_runMode:mode beforeDate:limitDate];
}

@end

@interface ThreadViewController ()

@property (nonatomic, strong) dispatch_semaphore_t semaphore;
@property (nonatomic, strong) NSThread *aliveThead;
@property (nonatomic, assign) BOOL isKeepAlive;
@property (nonatomic, assign) NSInteger ticketCount;

@end

@implementation ThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.isKeepAlive = YES;
 
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        switch (activity) {
            case kCFRunLoopEntry:
                NSLog(@"runloop进入");
                break;
            case kCFRunLoopBeforeTimers:
                NSLog(@"RunLoop要处理Timers了");
                break;
            case kCFRunLoopBeforeSources:
                NSLog(@"RunLoop要处理Sources了");
                break;
            case kCFRunLoopBeforeWaiting:
                NSLog(@"RunLoop要休息了");
                break;
            case kCFRunLoopAfterWaiting:
                NSLog(@"RunLoop醒来了");
                break;
            case kCFRunLoopExit:
                NSLog(@"RunLoop退出了");
                break;
            default:
                break;
        }
    });
    //CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    CFRelease(observer);
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(newThread) object:nil];
    [thread start];
    //[thread setName:@"com.xindong.thread"];
   
    self.aliveThead = thread;
    
    [self netRequestComplete:^{
        NSLog(@"3");
        CFRunLoopStop([NSRunLoop currentRunLoop].getCFRunLoop);
    }];
    // CFRunLoopRun()相当加了do-while,这时候下面的代码执行不了
    CFRunLoopRun();
    NSLog(@"2");
}

- (void)netRequestComplete:(void(^)(void))complete
{
    // 模拟网络请求，主线程回调
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (complete) {
                complete();
            }
        });
    });
}

__weak id refa = nil;

- (void)initTicket {
    _semaphore = dispatch_semaphore_create(1);
    _ticketCount = 20;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self saleTicket];
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self saleTicket];
    });
}

- (void)saleTicket {
    while (1) {
        dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
        if (_ticketCount > 0) {
            _ticketCount --;
            [NSThread sleepForTimeInterval:0.2];
        }else{
            dispatch_semaphore_signal(_semaphore);
            break;
        }
        dispatch_semaphore_signal(_semaphore);
    }
}

- (void)newThread
{
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    [runloop addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    while (self && self.isKeepAlive) {
        [runloop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    NSLog(@"thread sleep");
}

- (void)threadAliveTest {
    
    NSLog(@"----------");
    
}

- (void)clearThread {
    self.isKeepAlive = NO;
    CFRunLoopStop(CFRunLoopGetCurrent());
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self performSelector:@selector(threadAliveTest) onThread:self.aliveThead withObject:nil waitUntilDone:NO];
    static NSInteger count = 0;
    count ++;
    if (count == 4) {
        self.isKeepAlive = NO;
        [self performSelector:@selector(clearThread) onThread:self.aliveThead withObject:nil waitUntilDone:NO];
    }
}

-(void)dealloc {
    
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
