//
//  DJZPageViewController.m
//  Coder
//
//  Created by 张得军 on 2019/12/19.
//  Copyright © 2019 张得军. All rights reserved.
//

#import "DJZPageViewController.h"
#import "DJZPageScrollView.h"
#import "DJZPageView.h"

@interface DJZPageViewController ()<UIScrollViewDelegate, DJZPageViewDelegate>

@property (nonatomic, strong) DJZPageScrollView *mainScrollView;
@property (nonatomic, strong) DJZPageView *childTableView;
@property (nonatomic, assign) BOOL mainScrollViewCanScroll;
@property (nonatomic, assign) BOOL childScrollViewCanScroll;
@property (nonatomic, assign) BOOL ceiling;
@property (nonatomic, weak) UIScrollView *contentScrollView;
@property (nonatomic, weak) UIScrollView *childScrollView;
@property (nonatomic, strong) UIView *segmentView;
@property (nonatomic, assign) CGPoint lastPoint;
@property (nonatomic, assign) BOOL ceiled;

@end

@implementation DJZPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _mainScrollViewCanScroll = YES;
    _childScrollViewCanScroll = NO;
    _ceiling = YES;
    [self setupView];
}

- (void)setupView {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    UIView *contentView = [UIView new];
    [_mainScrollView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(_mainScrollView);
        make.width.mas_equalTo(_mainScrollView);
    }];
    
    UIView *segmentView = [UIView new];
    segmentView.backgroundColor = [UIColor grayColor];
    [contentView addSubview:segmentView];
    [segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(250);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    _segmentView = segmentView;
    
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.contentSize = CGSizeMake(kDJZScreenWidth * 2, 0);
    [contentView addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(300, 0, 0, 0));
        make.height.mas_equalTo(self.view.bounds.size.height);
    }];
    _contentScrollView = scrollView;
    
    _childTableView = [DJZPageView new];
    _childTableView.delegate = self;
    [scrollView addSubview:_childTableView];
    [_childTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(scrollView.mas_left);
        make.top.mas_equalTo(scrollView.mas_top);
        make.width.mas_equalTo(kDJZScreenWidth);
        make.height.mas_equalTo(self.view.bounds.size.height);
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!_mainScrollViewCanScroll) {
        _mainScrollView.contentOffset = CGPointMake(0, 250);
        _childScrollViewCanScroll = YES;
        return;
    }
    if (_mainScrollView.contentOffset.y >= 250) {
        _mainScrollView.contentOffset = CGPointMake(0, 250);
        _mainScrollViewCanScroll = NO;
        _childScrollViewCanScroll = YES;
        if (_segmentView.frame.size.height == 50) {
            [_segmentView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(100);
                make.top.mas_equalTo(200);
            }];
            _ceiled = YES;
        }
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

}

- (void)listScrollViewDidScroll:(UIScrollView *)scrollView {
    _childScrollView = scrollView;
    if (!_childScrollViewCanScroll) {
        scrollView.contentOffset = CGPointMake(0, 0);
        return;
    }
    if (_ceiling && !_mainScrollViewCanScroll && _ceiled) {
        if (scrollView.contentOffset.y > _lastPoint.y) {
            //向上
            [UIView animateWithDuration:0.1 animations:^{
                _contentScrollView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0);
                _segmentView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0);
            }];
        }else{
            [UIView animateWithDuration:0.1 animations:^{
                _contentScrollView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 50);
                _segmentView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 50);
            }];
        }
        _lastPoint = scrollView.contentOffset;
    }
    if (scrollView.contentOffset.y <= 0) {
        if (_ceiling && !_mainScrollViewCanScroll) {
            return;
        }
        scrollView.contentOffset = CGPointZero;
        _mainScrollViewCanScroll = YES;
        _childScrollViewCanScroll = NO;
    }
}

- (DJZPageScrollView *)mainScrollView {
    if (!_mainScrollView) {
        _mainScrollView = [DJZPageScrollView new];
        _mainScrollView.delegate = self;
    }
    return _mainScrollView;
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
