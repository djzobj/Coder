//
//  DJZLoginView.m
//  Coder
//
//  Created by 张得军 on 2019/9/16.
//  Copyright © 2019 张得军. All rights reserved.
//

#import "DJZLoginView.h"

@implementation DJZLoginView

- (instancetype)initWithViewModel:(DJZLoginViewModel *)viewModel {
    self = [super init];
    if (self) {
        [self setViewModel:viewModel];
    }
    return self;
}

- (void)setViewModel:(DJZLoginViewModel *)viewModel {
    _viewModel = viewModel;
    if (!viewModel) {
        return;
    }
    _viewModel = viewModel;
    RAC(viewModel, userName) = self.userNameTF.rac_textSignal;
    RAC(viewModel, password) = self.passwordTF.rac_textSignal;
    self.loginBtn.rac_command = self.viewModel.loginCommand;
    @weakify(self)
    [viewModel.refreshUI subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        self.indicatorView.hidden = NO;
    }];
    [viewModel.refreshEndSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        self.indicatorView.hidden = YES;
    }];
}

@end
