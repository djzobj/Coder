//
//  Clang.m
//  Coder
//
//  Created by 张得军 on 2019/10/22.
//  Copyright © 2019 张得军. All rights reserved.
//

#import "Clang.h"

@interface MNPerson : NSObject

@property (nonatomic, copy)NSString *name;

- (void)print;

@end

@implementation MNPerson

- (void)print{
    NSLog(@"self.name = %@",self.name);
}

@end

@implementation Clang

- (void)test {
    id cls = [MNPerson class];
    void *obj = &cls;
    [(__bridge id)obj print];
    
}

@end
