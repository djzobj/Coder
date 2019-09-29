//
//  MissWaterfallLayoutController.m
//  Miss
//
//  Created by 张得军 on 2019/9/9.
//  Copyright © 2019 djz. All rights reserved.
//

#import "MissWaterfallLayoutController.h"

@interface MissWaterfallLayout : UICollectionViewFlowLayout

@property (nonatomic, strong) NSMutableDictionary *columnYDic;
@property (nonatomic, strong) NSMutableArray *attributesArray;

@end

@implementation MissWaterfallLayout

- (NSMutableArray *)attributesArray {
    if (!_attributesArray) {
        _attributesArray = [NSMutableArray array];
    }
    return _attributesArray;
}

- (void)prepareLayout {
    [super prepareLayout];
    _columnYDic = @{@(0):@(0), @(1):@(0)}.mutableCopy;
    [self.attributesArray removeAllObjects];
    for (NSInteger i = 0; i < 40; i ++) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [self.attributesArray addObject:attributes];
    }
}

- (CGSize)collectionViewContentSize {
    __block NSNumber *maxColumn = @(0);
    [self.columnYDic enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSNumber *obj, BOOL * _Nonnull stop) {
        if ([self.columnYDic[maxColumn] floatValue] < obj.floatValue) {
            maxColumn = key;
        }
    }];
    return CGSizeMake(0, [self.columnYDic[maxColumn] floatValue]);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attributesArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat width = kDJZScreenWidth/2 - 15;
    CGFloat height = random()%100 + 70;
    __block NSNumber *minColumn = @(0);
    [self.columnYDic enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSNumber *obj, BOOL * _Nonnull stop) {
        if ([self.columnYDic[minColumn] floatValue] > obj.floatValue) {
            minColumn = key;
        }
    }];
    CGFloat itemY = [self.columnYDic[minColumn] floatValue] + 10;
    CGFloat itemX = 10 + (width + 10) * minColumn.integerValue;
    attributes.frame = CGRectMake(itemX, itemY, width, height);
    self.columnYDic[minColumn] = @(CGRectGetMaxY(attributes.frame));
    return attributes;
}

@end

@interface MissWaterfallLayoutController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation MissWaterfallLayoutController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 40;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor regularGray];
    return cell;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        MissWaterfallLayout *layout = [MissWaterfallLayout new];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
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
