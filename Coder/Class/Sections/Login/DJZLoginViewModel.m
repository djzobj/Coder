//
//  DJZLoginViewModel.m
//  Coder
//
//  Created by 张得军 on 2019/9/16.
//  Copyright © 2019 张得军. All rights reserved.
//

#import "DJZLoginViewModel.h"
#import "DJZNetWorking.h"

@implementation DJZLoginViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        RACSignal *userNameLengthSignal = [RACObserve(self, userName) map:^id _Nullable(NSString *value) {
            if (value.length > 6) {
                return @(YES);
            }
            return @(NO);
        }];
        RACSignal *passwordLengthSignal = [RACObserve(self, password) map:^id _Nullable(NSString *_Nullable value) {
            if (value.length > 6) {
                return @(YES);
            }
            return @(NO);
        }];
        RACSignal *loginBtnEnable = [RACSignal combineLatest:@[userNameLengthSignal, passwordLengthSignal] reduce:^id _Nullable(NSNumber *userName, NSNumber *password){
            return @(userName.boolValue && password.boolValue);
        }];
        @weakify(self)
        _loginCommand = [[RACCommand alloc] initWithEnabled:loginBtnEnable signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [DJZNetWorking loginWithUserName:self.userName password:self.password];
        }];
        [_loginCommand.executionSignals subscribeNext:^(RACSignal *_Nullable x) {
            @strongify(self)
            [self.refreshUI sendNext:@"正在请求数据"];
            [x subscribeNext:^(id  _Nullable x) {
                [self.refreshEndSubject sendNext:@"数据请求完成"];
            }];
        }];
    }
    return self;
}

- (RACSubject *)refreshUI {
    
    if (!_refreshUI) {
        
        _refreshUI = [RACSubject subject];
    }
    
    return _refreshUI;
}

- (RACSubject *)refreshEndSubject {
    
    if (!_refreshEndSubject) {
        
        _refreshEndSubject = [RACSubject subject];
    }
    
    return _refreshEndSubject;
}

@end
