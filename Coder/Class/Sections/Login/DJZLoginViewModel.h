//
//  DJZLoginViewModel.h
//  Coder
//
//  Created by 张得军 on 2019/9/16.
//  Copyright © 2019 张得军. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DJZLoginViewModel : NSObject

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, strong) RACCommand *loginCommand;
@property (nonatomic, strong) RACSubject *refreshUI;
@property (nonatomic, strong) RACSubject *refreshEndSubject;

@end

NS_ASSUME_NONNULL_END
