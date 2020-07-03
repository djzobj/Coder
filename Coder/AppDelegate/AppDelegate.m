//
//  AppDelegate.m
//  Coder
//
//  Created by 张得军 on 2019/9/16.
//  Copyright © 2019 张得军. All rights reserved.
//

#import "AppDelegate.h"
#import "DJZTabBarController.h"
#import <WebKit/WebKit.h>
#import <dlfcn.h>
#import <libkern/OSAtomic.h>

@interface AppDelegate ()

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation AppDelegate


void __sanitizer_cov_trace_pc_guard_init(uint32_t *start,
                                                    uint32_t *stop) {
  static uint64_t N;  // Counter for the guards.
  if (start == stop || *start) return;  // Initialize only once.
  printf("INIT: %p %p\n", start, stop);
  for (uint32_t *x = start; x < stop; x++)
    *x = ++N;  // Guards should start from 1.
}

//原子队列
static OSQueueHead symboList = OS_ATOMIC_QUEUE_INIT;
//定义符号结构体
typedef struct{
    void * pc;
    void * next;
}SymbolNode;

void __sanitizer_cov_trace_pc_guard(uint32_t *guard) {
    //if (!*guard) return;  // Duplicate the guard check.
    
    void *PC = __builtin_return_address(0);
    
    Dl_info info;
    dladdr(PC, &info);
     
//    printf("fname=%s \nfbase=%p \nsname=%s\nsaddr=%p \n",info.dli_fname,info.dli_fbase,info.dli_sname,info.dli_saddr);
//
//    char PcDescr[1024];
//    printf("guard: %p %x PC %s\n", guard, *guard, PcDescr);
    
    SymbolNode * node = malloc(sizeof(SymbolNode));
    *node = (SymbolNode){PC,NULL};
    
    //入队
    // offsetof 用在这里是为了入队添加下一个节点找到 前一个节点next指针的位置
    OSAtomicEnqueue(&symboList, node, offsetof(SymbolNode, next));
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSMutableArray<NSString *> * symbolNames = [NSMutableArray array];
        while (true) {
            //offsetof 就是针对某个结构体找到某个属性相对这个结构体的偏移量
            SymbolNode * node = OSAtomicDequeue(&symboList, offsetof(SymbolNode, next));
            if (node == NULL) break;
            Dl_info info;
            dladdr(node->pc, &info);
            
            NSString * name = @(info.dli_sname);
            
            // 添加 _
            BOOL isObjc = [name hasPrefix:@"+["] || [name hasPrefix:@"-["];
            NSString * symbolName = isObjc ? name : [@"_" stringByAppendingString:name];
            
            //去重
            if (![symbolNames containsObject:symbolName]) {
                [symbolNames addObject:symbolName];
            }
        }

        //取反
        NSArray * symbolAry = [[symbolNames reverseObjectEnumerator] allObjects];
        NSLog(@"%@",symbolAry);
        
        //将结果写入到文件
        NSString * funcString = [symbolAry componentsJoinedByString:@"\n"];
        NSString * filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"lb.order"];
        NSData * fileContents = [funcString dataUsingEncoding:NSUTF8StringEncoding];
        BOOL result = [[NSFileManager defaultManager] createFileAtPath:filePath contents:fileContents attributes:nil];
        if (result) {
            NSLog(@"%@",filePath);
        }else{
            NSLog(@"文件写入出错");
        }
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    DJZTabBarController *tabBarController = [DJZTabBarController new];
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
    
    _webView = [WKWebView new];
    [_webView evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        
    }];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
