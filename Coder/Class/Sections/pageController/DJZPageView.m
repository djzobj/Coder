//
//  DJZPageView.m
//  Coder
//
//  Created by 张得军 on 2019/12/19.
//  Copyright © 2019 张得军. All rights reserved.
//

#import "DJZPageView.h"
#import "DJZPageTableView.h"

@interface DJZPageView ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) DJZPageTableView *tableView;
@property (nonatomic, weak) UIGestureRecognizer *gesture;

@end

@implementation DJZPageView

- (instancetype)init {
    self = [super init];
    if (self) {
        _tableView = [[DJZPageTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.delegate = self;
        [self addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@", @(indexPath.row)];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_delegate listScrollViewDidScroll:scrollView];
}
@end
