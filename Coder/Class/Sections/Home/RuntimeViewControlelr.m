//
//  RuntimeViewControlelr.m
//  Miss
//
//  Created by 张得军 on 2018/11/1.
//  Copyright © 2018 djz. All rights reserved.
//

#import "RuntimeViewControlelr.h"
#import <objc/runtime.h>

//MNPerson
@interface MNPerson : NSObject

@property (nonatomic, copy)NSString *name;
@property (nonatomic, assign) NSInteger age;

- (void)print;

@end

@implementation MNPerson

- (void)print{
    NSLog(@"self.name = %@",self.name);
}

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
    if ([key isEqualToString:@"name"]) {
        return NO;
    }
    return [super automaticallyNotifiesObserversForKey:key];
}

@end

@interface RuntimeViewControlelr (){
    MNPerson *_person;
}
@end

@implementation RuntimeViewControlelr

- (void)viewDidLoad {
    [super viewDidLoad];
    id cls = [MNPerson class];
    void *obj = &cls;
    [(__bridge id)obj print];
    
    _person = [MNPerson new];
    [_person addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    _person.name = @"11111";
    _person.age = 11;
    [_person willChangeValueForKey:@"name"];
    [_person didChangeValueForKey:@"name"];

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"");
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
