//
//  GraphicsView.m
//  Miss
//
//  Created by 张得军 on 2018/9/26.
//  Copyright © 2018年 djz. All rights reserved.
//

#import "GraphicsView.h"

@interface GraphicsView ()

@end

@implementation GraphicsView

- (void)drawRect:(CGRect)rect {
    _progress = 0.8;
    // Drawing code
    CGFloat originX = rect.size.width/2;
    CGFloat originY = rect.size.height/2;
    CGFloat radius = MIN(originX, originY) - 20/2;
    //建立一个最小初始弧度制,避免进度progress为0或1时圆环消失
    CGFloat minAngle = M_PI/90 - self.progress * M_PI/80;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetFillColorWithColor(context, [UIColor regularGray].CGColor);
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, 20);
    CGContextSetStrokeColorWithColor(context, [UIColor regularGray].CGColor);
    CGContextAddArc(context, originX, originY, radius, 0, 2*M_PI, YES);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);

    CGContextSaveGState(context);
    CGContextSetLineWidth(context, 20);
    CGContextAddArc(context, originY, originY, radius, -M_PI_2, -M_PI_2 + minAngle + (2 * M_PI)*self.progress, NO);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    NSArray *colors = @[(id)[UIColor miss_colorWithRGB:@"#349CF7"].CGColor, (id)[UIColor miss_colorWithRGB:@"#FE5858"].CGColor, (id)[UIColor miss_colorWithRGB:@"#72DC4F"].CGColor];
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)colors, NULL);
    CGContextReplacePathWithStrokedPath(context);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(rect.size.width/2, 0), CGPointMake(rect.size.width/2, rect.size.height), kCGGradientDrawsBeforeStartLocation);
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    
}

- (id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event
{
    id<CAAction> obj = [super actionForLayer:layer forKey:event];
    NSLog(@"%@",obj);
    return obj;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    return [super pointInside:point withEvent:event];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    return [super hitTest:point withEvent:event];
}

@end
