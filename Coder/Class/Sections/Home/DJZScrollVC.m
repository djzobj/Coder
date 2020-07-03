//
//  DJZScrollVC.m
//  Coder
//
//  Created by 张得军 on 2020/6/26.
//  Copyright © 2020 张得军. All rights reserved.
//

#import "DJZScrollVC.h"



@interface DJZScrollView : UIScrollView

@end

@implementation DJZScrollView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"11111--------touchBegin");
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"11111-------touchMove");
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"11111--------touchEnd");
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"1111--------touchCancel");
}

@end

@interface DJZTestView : UIView

@end

@implementation DJZTestView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"2222--------touchBegin");
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"2222-------touchMove");
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"2222--------touchEnd");
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"2222--------touchCancel");
}

@end

@interface DJZScrollVC ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) DJZScrollView *scrollView;

@property (nonatomic, strong) DJZTestView *testView;

@end

@implementation DJZScrollVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _scrollView = [DJZScrollView new];
    _scrollView.contentSize = CGSizeMake(0, 1000);
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    _testView = [DJZTestView new];
    _testView.backgroundColor = [UIColor grayColor];
    _testView.frame = CGRectMake(20, 120, kDJZScreenWidth - 40, 300);
    [_scrollView addSubview:_testView];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    pan.cancelsTouchesInView = NO;
    pan.delegate = self;
    [_testView addGestureRecognizer:pan];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [_testView addGestureRecognizer:tap];
}

- (void)pan:(UIPanGestureRecognizer *)gesture {
    NSLog(@"------pan");
}

- (void)tap:(UITapGestureRecognizer *)gesture {
    NSLog(@"------tap");
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"----------touchBegin");
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"----------touchMove");
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"----------touchEnd");
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"----------touchCancel");
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
