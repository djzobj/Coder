//
//  DJZNetWorking.h
//  Coder
//
//  Created by 张得军 on 2019/9/16.
//  Copyright © 2019 张得军. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DJZNetWorking : NSObject

+ (RACSignal *)loginWithUserName:(NSString *) name password:(NSString *)password;

@end

NS_ASSUME_NONNULL_END
