//
//  DJZHomeViewController.m
//  Coder
//
//  Created by 张得军 on 2019/9/17.
//  Copyright © 2019 张得军. All rights reserved.
//

#import "DJZHomeViewController.h"
#import "CTMediator+LoginAction.h"
#import <MJRefresh.h>
#import <SDWebImage.h>
#import <WebKit/WKWebView.h>
#import <vector>
#import <objc/runtime.h>
#import "Aspects.h"

using namespace std;

typedef pair<NSString *, Class> RootRow;

typedef NS_ENUM(NSUInteger, DJZLoginType) {
    DJZLoginTypePhone,
    DJZLoginTypeQQ,
    DJZLoginTypeWX,
};

typedef NS_OPTIONS(NSUInteger, DJZXXXType) {
    DJZXXXTypeJ = 1 << 0,
    DJZXXXTypeK = 1 << 1,
    DJZXXXTypeZ = 1 << 2,
};

@protocol DJZHomeViewControllerDelegate <NSObject>

@property (nonatomic, assign) NSInteger index;

@end

@interface TestCopy : NSObject <NSCopying>{
    NSString *_a;
}

@end

@implementation TestCopy

- (id)copyWithZone:(NSZone *)zone{
    return [TestCopy new];
}


@end

@interface TestCopySub : TestCopy <NSCopying>{
    
}

@end

@implementation TestCopySub


@end

@interface DJZHomeViewController ()<UITableViewDataSource, UITableViewDelegate, DJZHomeViewControllerDelegate>{
    vector<RootRow> _dataSource;
    id _a;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, assign) UIEdgeInsets scrollViewOriginalInset;
@property (nonatomic, assign) BOOL hasUA;

@end

@implementation DJZHomeViewController

@synthesize index;


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
    _datas = @[@"DJZLoginViewController", @"CoreGraphicsController", @"DJZPageViewController",@"RuntimeViewControlelr", @"DJZXMLParserController", @"DJZRACStudyController", @"DJZUIWebViewController", @"DJZWKWebViewController", @"DJZArithmeticController", @"ThreadViewController", @"DJZCovariantViewController", @"DJZZoomController", @"MissDatabaseController", @"DJZAnimationVC", @"DJZScrollVC", @"SwiftTestController"];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self.view.mas_top).offset(33);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
    NSObject *objc = [[NSObject alloc] init];
    NSLog(@"objc对象实际需要的内存大小: %zd", class_getInstanceSize([objc class]));
    //NSLog(@"objc对象实际分配的内存大小: %zd", malloc_size((__bridge const void *)(objc)));
    
    UIImageView *icon = [UIImageView new];
    [icon sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1591093413462&di=0242059bc607719aeba913d83667464f&imgtype=0&src=http%3A%2F%2Feaassets-a.akamaihd.net%2Fbattlelog%2Fprod%2Femblem%2F483%2F489%2F256%2F2955059549753107915.png%3Fv%3D1383717050"] placeholderImage:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
}

- (void)handleDeviceOrientationChange {
    UIInterfaceOrientation currentOrientation = UIInterfaceOrientationUnknown;
    if (UIDeviceOrientationIsValidInterfaceOrientation([UIDevice currentDevice].orientation)) {
        currentOrientation = (UIInterfaceOrientation)[UIDevice currentDevice].orientation;
    } else {
        return;
    }
}

- (void)prepareData:(id)text {
    RootRow arr[] = {
        RootRow(@"非完全解耦", DJZHomeViewController.self),
    };
    for (auto value : arr) {
        _dataSource.push_back(value);
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    NSNumber * value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
}

- (BOOL)shouldAutorotate{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}

#pragma mark UITableViewDataSource、UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = _datas[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    NSString *className = _datas[indexPath.row];
    UIViewController *controller = [NSClassFromString(className) new];
    if ([className isEqualToString:@"SwiftTestController"]) {
        controller = [SwiftViewController new];

    }
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)endRefresh {
    self.state = 0;
}

#pragma mark get、set

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.estimatedRowHeight = 50;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    }
    return _tableView;
}

- (void)refresh {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self endRefresh];
        [self.tableView.mj_header endRefreshing];
    });
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
