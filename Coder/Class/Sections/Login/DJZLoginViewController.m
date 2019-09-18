//
//  DJZLoginViewController.m
//  Coder
//
//  Created by 张得军 on 2019/9/16.
//  Copyright © 2019 张得军. All rights reserved.
//

#import "DJZLoginViewController.h"
#import "DJZLoginViewModel.h"
#import "DJZLoginView.h"
#import <CoreLocation/CoreLocation.h>

@interface DJZLoginViewController ()

@property (nonatomic, strong) DJZLoginView *loginView;
@property (nonatomic, strong) DJZLoginViewModel *viewModel;

@end

@implementation DJZLoginViewController

- (void)loadView {
    [super loadView];
    self.view = [UIView new];
    self.view.backgroundColor = [UIColor redColor];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.loginView];
    
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

#pragma mark get/set

- (DJZLoginView *)loginView {
    if (!_loginView) {
        _loginView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(DJZLoginView.class) owner:nil options:nil].firstObject;
        _loginView.viewModel = self.viewModel;
        _loginView.indicatorView.hidden = YES;
    }
    return _loginView;
}

- (DJZLoginViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [DJZLoginViewModel new];
    }
    return _viewModel;
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
