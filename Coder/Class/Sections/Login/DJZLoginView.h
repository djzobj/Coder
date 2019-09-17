//
//  DJZLoginView.h
//  Coder
//
//  Created by 张得军 on 2019/9/16.
//  Copyright © 2019 张得军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJZLoginViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJZLoginView : UIView

@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;
@property (strong, nonatomic) DJZLoginViewModel *viewModel;

- (instancetype)initWithViewModel:(DJZLoginViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
