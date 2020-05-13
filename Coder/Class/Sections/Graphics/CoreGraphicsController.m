//
//  CoreGraphicsController.m
//  Miss
//
//  Created by 张得军 on 2018/9/26.
//  Copyright © 2018年 djz. All rights reserved.
//

#import "CoreGraphicsController.h"
#import "MissDatabaseController.h"
#import "GraphicsView.h"
#import "DJZInspectionView.h"

@interface CoreGraphicsController (){
    GraphicsView *_circleView;
}

@end

@implementation CoreGraphicsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _circleView = [GraphicsView new];
    _circleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_circleView];
    [_circleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(180);
        make.centerX.mas_equalTo(0);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTest)];
    [_circleView addGestureRecognizer:tap];
    
    UISlider *progressView = [UISlider new];
    [progressView addTarget:self action:@selector(didSlider:) forControlEvents:UIControlEventValueChanged];
    progressView.frame = CGRectMake(50, 50, 200, 20);
    [self.view addSubview:progressView];
    
    DJZInspectionView *view = [[DJZInspectionView alloc] initWithFrame:self.view.bounds];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    [UIView animateWithDuration:0.4 animations:^{
        view.frame = CGRectMake(0, 0, 100, 100);
    }];
}

- (void)didSlider:(UISlider *)slider {
    _circleView.progress = slider.value;
    [_circleView setNeedsDisplay];
}

- (void)clickTest {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
