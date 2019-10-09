//
//  ThreadViewController.m
//  Miss
//
//  Created by 张得军 on 2018/11/23.
//  Copyright © 2018 djz. All rights reserved.
//

#import "ThreadViewController.h"

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
   
    self.aliveThead = thread;
    dispatch_queue_t barrierQueue = dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(barrierQueue, ^{
        [self performSelector:@selector(test) withObject:nil afterDelay:2];
        [[NSRunLoop currentRunLoop] run];
    });
}

- (void)test {
    NSLog(@"test");
}

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
