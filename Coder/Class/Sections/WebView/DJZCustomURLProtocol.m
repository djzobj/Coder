//
//  DJZCustomURLProtocol.m
//  Coder
//
//  Created by 张得军 on 2020/3/3.
//  Copyright © 2020 张得军. All rights reserved.
//

#import "DJZCustomURLProtocol.h"

static NSString * const URLProtocolHandledKey = @"URLProtocolHandledKey";

@interface DJZCustomURLProtocol ()<NSURLSessionDelegate>

@property (nonatomic, strong) NSURLSession *session;

@end

@implementation DJZCustomURLProtocol

+ (void)load {
    [NSURLProtocol registerClass:self];
    //注册scheme
    Class cls = NSClassFromString(@"WKBrowsingContextController");
    SEL sel = NSSelectorFromString(@"registerSchemeForCustomProtocol:");
    if ([cls respondsToSelector:sel]) {
        // 通过http和https的请求，同理可通过其他的Scheme 但是要满足ULR Loading System
        [cls performSelector:sel withObject:@"https"];
    }
}

//该方法会拿到request的对象，我们可以通过该方法的返回值来筛选request是否需要被NSURLProtocol做拦截处理。

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    NSString * scheme = [[request.URL scheme] lowercaseString];
    if ([scheme isEqual:@"djzhost"]) {
        return YES;
    }
    return NO;
}

//这个方法用来统一处理请求request 对象的，可以修改头信息，或者重定向。没有特殊需要，则直接return request。
//如果要在这里做重定向以及头信息的时候注意检查是否已经添加，因为这个方法可能被调用多次，也可以在后面的方法中做。

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}

//主要判断两个request是否相同，如果相同的话可以使用缓存数据，通常只需要调用父类的实现

+ (BOOL)requestIsCacheEquivalent:(NSURLRequest *)a toRequest:(NSURLRequest *)b {
    return [super requestIsCacheEquivalent:a toRequest:b];
}

- (id)initWithRequest:(NSURLRequest *)request cachedResponse:(NSCachedURLResponse *)cachedResponse client:(id <NSURLProtocolClient>)client {
    request = [self handlePostRequestBodyWithRequest:request];
    return [super initWithRequest:request cachedResponse:cachedResponse client:client];
}

//把当前请求的request拦截下来以后，可以在这里修改请求信息，重定向网络，DNS解析，使用自定义的缓存等

- (void)startLoading {
    NSMutableURLRequest *mutableReqeust = [[self request] mutableCopy];
        //标示该request已经处理过了，防止无限循环
        [NSURLProtocol setProperty:@(YES) forKey:URLProtocolHandledKey inRequest:mutableReqeust];

        //使用NSURLSession继续把request发送出去
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
    //定义全局的NSURLSession对象用于stop请求使用
        self.session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:mainQueue];
        NSURLSessionDataTask *task = [self.session dataTaskWithRequest:self.request];
        [task resume];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    // 打印返回数据
    NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if (dataStr) {
        NSLog(@"***截取数据***: %@", dataStr);
    }
    [self.client URLProtocol:self didLoadData:data];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (error) {
        [self.client URLProtocol:self didFailWithError:error];
    } else {
        [self.client URLProtocolDidFinishLoading:self];
    }
}

- (void)stopLoading {
    [self.session invalidateAndCancel];
    self.session = nil;
}

#pragma mark 处理POST请求相关POST  用HTTPBodyStream来处理BODY体
- (NSMutableURLRequest *)handlePostRequestBodyWithRequest:(NSURLRequest *)request {
    NSMutableURLRequest * req = [request mutableCopy];
    NSString *url = request.URL.absoluteString;
    url = [url stringByReplacingOccurrencesOfString:@"djzhost" withString:@"https"];
    req.URL = [NSURL URLWithString:url];
    if ([request.HTTPMethod isEqualToString:@"POST"]) {
//        NSString *body = @"xxxx";
//        if (body.length) {
//                NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
//                req.HTTPBody = data;
//        }
    }
    return req;
}

@end
