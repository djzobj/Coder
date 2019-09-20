//
//  DJZRACStudyController.m
//  Coder
//
//  Created by 张得军 on 2019/9/18.
//  Copyright © 2019 张得军. All rights reserved.
//

#import "DJZRACStudyController.h"

@interface DJZRACStudyController ()
@property (nonatomic, strong) UITextField *TF;
@end

@implementation DJZRACStudyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _TF = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 200, 30)];
    _TF.placeholder = @"xxx";
    [self.view addSubview:_TF];
    [self filter];
    
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        //subscriber并不是一个对象
        //3. 发送信号
        [subscriber sendNext:@"send one Message"];
        
        //发送error信号
        NSError *error = [NSError errorWithDomain:NSURLErrorDomain code:1001 userInfo:@{@"errorMsg":@"this is a error message"}];
        [subscriber sendError:error];
        
        //4. 销毁信号
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"signal已销毁");
        }];
    }];
    
    //2.1 订阅信号
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    //2.2 针对实际中可能出现的逻辑错误，RAC提供了订阅error信号
    [signal subscribeError:^(NSError * _Nullable error) {
        NSLog(@"%@",error);
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)filter
{
    //只有当我们文本框内容长度大于5才想要获取文本框的内容
    [[_TF.rac_textSignal filter:^BOOL(id value) {
        //value:源信号的内容
        return [value length] > 5;
        //返回值就是过滤的条件,只有满足这个条件才能获取到内容
    }] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    [[_TF.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        return [NSString stringWithFormat:@"1111%@", value];
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"-----%@", x);
    }];
}

- (void)ignore
{
    //创建信号
    RACSubject *subject = [RACSubject subject];
    //ignore:忽略一些值
    //ignoreValues:忽略所有值
    RACSignal *ignoreSignal = [subject ignore:@"HMJ"];
    //    RACSignal *ignoreSignal = [subject ignoreValues];
    //订阅信号
    [ignoreSignal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    //发送信号
    [subject sendNext:@"HMJ"];
    [subject sendNext:@"WGQ"];
}

- (void)distinctUntilChanged
{
    //distinctUntilChanged:如果当前的值跟上一个值相同就不会被调用到
    //创建信号
    RACSubject *subject = [RACSubject subject];
    [[subject distinctUntilChanged] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    [subject sendNext:@"HMJ"];
    [subject sendNext:@"HMJ"];
    [subject sendNext:@"HMJ"];
}

- (void)take
{
    //创建信号
    RACSubject *subject = [RACSubject subject];
    RACSubject *signal = [RACSubject subject];
    //take:取前面几个值
    //在没到第三个时就遇到[subject sendCompleted];那么就会停止发送信号
    [[subject take:3] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    //takeLast:取后面多少个值,必须发送完成
    //只有[subject sendCompleted];才会发送信号
    [[subject takeLast:2] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    //takeUntil:只要传入的信号发送完成或者signal发送信号,就不会再接收信号的内容
    [[subject takeUntil:signal] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    //发送任意数据
    [subject sendNext:@1];
    [subject sendNext:@"HMJ"];
    [subject sendNext:@3];
    [subject sendCompleted];
    [subject sendNext:@4];
    [signal sendNext:@"signal"];
}

- (void)switchToLatest
{
    RACSubject *signalOfSignal = [RACSubject subject];
    RACSubject *signal = [RACSubject subject];
    // 获取信号中信号最近发出信号，订阅最近发出的信号。
    // 注意switchToLatest：只能用于信号中的信号
    //订阅信号
    [signalOfSignal.switchToLatest subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    //发送信号
    [signalOfSignal sendNext:signal];
    [signal sendNext:@"signal"];
}

- (void)skip
{
    //skip:跳跃几个值再接收被订阅
    //创建信号
    RACSubject *subject = [RACSubject subject];
    [[subject skip:2] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    [subject sendNext:@"HMJ"];
    [subject sendNext:@"1"];
    [subject sendNext:@"3"];
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
