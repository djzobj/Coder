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
    [self bindViewModel];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)bindViewModel {
    RAC(self.viewModel, userName) = self.loginView.userNameTF.rac_textSignal;
    RAC(self.viewModel, password) = self.loginView.passwordTF.rac_textSignal;
    self.loginView.loginBtn.rac_command = self.viewModel.loginCommand;
    @weakify(self)
    [self.viewModel.refreshUI subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        self.loginView.indicatorView.hidden = ![x boolValue];
    }];
    [self.viewModel.refreshEndSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        self.loginView.indicatorView.hidden = YES;
    }];
}

#pragma mark get/set

- (DJZLoginView *)loginView {
    if (!_loginView) {
        _loginView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(DJZLoginView.class) owner:nil options:nil].firstObject;
        _loginView.frame = self.view.bounds;
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
