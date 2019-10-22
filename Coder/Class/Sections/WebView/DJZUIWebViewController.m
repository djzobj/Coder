//
//  DJZUIWebViewController.m
//  Coder
//
//  Created by 张得军 on 2019/9/18.
//  Copyright © 2019 张得军. All rights reserved.
//

#import "DJZUIWebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface DJZUIWebViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) JSContext *jsContext;

@end

@implementation DJZUIWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://activity-1.m.duiba.com.cn/hdtool/index?id=3721052&appKey=U9smCw8qARxWTzoSvL41McNWiRu&openBs=openbs"]]];
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [UIWebView new];
        _webView.delegate = self;
        _webView.backgroundColor = [UIColor whiteColor];
    }
    return _webView;
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.navigationItem.title = [self.title stringByAppendingString:[webView stringByEvaluatingJavaScriptFromString:@"document.title"]];
    [self convertJSFunctionsToOCMethods];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}

#pragma mark - 将JS的函数转换成OC的方法

- (void)convertJSFunctionsToOCMethods
{
    //获取该UIWebview的javascript上下文
    //self持有jsContext
    //@property (nonatomic, strong) JSContext *jsContext;
    self.jsContext = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    //JSContext oc调用js
    //JSValue *value = [self.jsContext evaluateScript:@"document.title"];
    
    //js调用iOS
    //其中share就是js的方法名称，赋给是一个block 里面是iOS代码
    //此方法最终将打印出所有接收到的参数，js参数是不固定的
    self.jsContext[@"share"] = ^() {
        NSArray *args = [JSContext currentArguments];//获取到share里的所有参数
        //args中的元素是JSValue，需要转成OC的对象
        NSMutableArray *messages = [NSMutableArray array];
        for (JSValue *obj in args) {
            [messages addObject:[obj toObject]];
        }
        NSLog(@"点击分享js传回的参数：\n%@", messages);
    };
    
    /*
     //两数相加
     self.jsContext[@"testAddMethod"] = ^NSInteger(NSInteger a, NSInteger b) {
     return a + b;
     };
     */
    
    /*
     //两数相乘
     self.jsContext[@"testAddMethod"] = ^NSInteger(NSInteger a, NSInteger b) {
     return a * b;
     };
     */
    
    //调用方法的本来实现，给原结果乘以10
    JSValue *value = self.jsContext[@"testAddMethod"];
    self.jsContext[@"testAddMethod"] = ^NSInteger(NSInteger a, NSInteger b) {
        JSValue *resultValue = [value callWithArguments:[JSContext currentArguments]];
        return resultValue.toInt32 * 10;
    };
    
    self.jsContext[@"chooseContact"] = ^() {
        NSLog(@"点击了联系人");
    };
    
    //异步回调
    self.jsContext[@"shareNew"] = ^(JSValue *shareData) {
        NSLog(@"%@", [shareData toObject]);
        JSValue *resultFunction = [shareData valueForProperty:@"result"];
        //回调block
        void (^result)(BOOL) = ^(BOOL isSuccess) {
            [resultFunction callWithArguments:@[@(isSuccess)]];
        };
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"回调分享成功");
            result(YES);
        });
    };
    
    //先注入给图片添加点击事件的js
    //防止频繁IO操作，造成性能影响
    static NSString *jsSource;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        jsSource = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ImgAddClickEvent" ofType:@"js"] encoding:NSUTF8StringEncoding error:nil];
    });
    [self.jsContext evaluateScript:jsSource];
    //替换回调方法
    self.jsContext[@"h5ImageDidClick"] = ^(NSDictionary *imgInfo) {
        NSLog(@"UIWebView点击了html上的图片，信息是：%@", imgInfo);
    };
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
