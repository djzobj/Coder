//
//  DJZInspectionView.m
//  Coder
//
//  Created by 张得军 on 2020/1/15.
//  Copyright © 2020 张得军. All rights reserved.
//

#import "DJZInspectionView.h"
#import "DJZInspectionLayer.h"

@implementation DJZInspectionView

+ (Class)layerClass {
    return [DJZInspectionLayer class];
}

@end
