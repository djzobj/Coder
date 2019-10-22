//
//  DJZCovariantViewController.m
//  Coder
//
//  Created by 张得军 on 2019/10/16.
//  Copyright © 2019 张得军. All rights reserved.
//

#import "DJZCovariantViewController.h"
#import "DJZTimer.h"

// __covariant 协变，子类转父类；泛型名字是ObjectType
@interface Person<__contravariant ObjectType> :NSObject
// 语言
@property (nonatomic, strong) ObjectType language;
@end

@interface Language : NSObject

@end

@implementation Language


@end

@interface Java : Language

@end

@interface iOS : Language

@end

@implementation Person

- (void)test {

    Language *language = [Language new];
    
    Person<Language *>*p = [Person new];
    p.language = language;
    
    Person<iOS *>*p1 = [Person new];
    p1 = p;
}

@end

@interface DJZCovariantViewController ()

@property (nonatomic, strong) DJZTimer *timer;

@end

@implementation DJZCovariantViewController

- (instancetype)initWithCoder:(NSCoder *)coder {
    return [super initWithCoder:coder];
}

- (instancetype)init {
    return [super init];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    return [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.timer = [DJZTimer timerWithTimeInterval:1 target:self selector:@selector(timeRun) userInfo:nil repeats:YES];
    [_timer fire];
}

- (void)timeRun {
    NSLog(@"----------");
}

- (void)dealloc {
    
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
