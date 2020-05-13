//
//  DJZPageView.h
//  Coder
//
//  Created by 张得军 on 2019/12/19.
//  Copyright © 2019 张得军. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DJZPageViewDelegate <NSObject>

- (void)listScrollViewDidScroll:(UIScrollView *)scrollView;

@end

@interface DJZPageView : UIView

@property (nonatomic, weak) id <DJZPageViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
