//
//  DJZTimer.h
//  Coder
//
//  Created by 张得军 on 2019/10/18.
//  Copyright © 2019 张得军. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DJZTimer : NSObject

+ (DJZTimer *)timerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo;

- (void)fire;

- (void)invalidate;

@end

NS_ASSUME_NONNULL_END
