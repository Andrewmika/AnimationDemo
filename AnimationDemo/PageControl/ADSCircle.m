//
//  ADSCircle.m
//  AnimationDemo
//
//  Created by Andrew Shen on 2016/11/9.
//  Copyright © 2016年 AndrewShen. All rights reserved.
//

#import "ADSCircle.h"
#import <UIKit/UIKit.h>
#import "ADSKeyFrameAnimation.h"

@interface ADSCircle ()
@property (nonatomic, assign)  CGFloat  factor; // <##>

@end

@implementation ADSCircle

- (id)initWithLayer:(ADSCircle *)layer {
    self = [super initWithLayer:layer];
    if (self) {
        self.factor = layer.factor;
    }
    return self;
}

+ (BOOL)needsDisplayForKey:(NSString *)key {
    if ([key isEqual:@"factor"]) {
        return YES;
    }
    return [super needsDisplayForKey:key];
}

- (void)drawInContext:(CGContextRef)ctx {
    //设置3.6 出来的弧度最像圆,算法结果
    CGFloat offset = self.currentRect.size.width / 3.6;
    CGPoint rectCenter = CGPointMake(self.currentRect.origin.x + self.currentRect.size.width * 0.5, self.currentRect.origin.y + self.currentRect.size.height * 0.5);
    
    // 8个控制点实际的偏移距离
    CGFloat extra = (self.currentRect.size.width * 2 / 5) * _factor;
    CGPoint pointA = CGPointMake(rectCenter.x, self.currentRect.origin.y + extra);
    CGPoint pointB = CGPointMake(self.scrollDirection == ScrollDirectionLeft ? rectCenter.x + self.currentRect.size.width * 0.5 : rectCenter.x + self.currentRect.size.width * 0.5 + extra * 2, rectCenter.y);
    CGPoint pointC = CGPointMake(rectCenter.x, rectCenter.y + self.currentRect.size.height * 0.5 - extra);
    CGPoint pointD = CGPointMake(self.scrollDirection == ScrollDirectionLeft ? self.currentRect.origin.x - extra * 2 : self.currentRect.origin.x, rectCenter.y);
    CGPoint c1 = CGPointMake(pointA.x + offset, pointA.y);
    CGPoint c2 = CGPointMake(pointB.x, pointB.y - offset);
    
    CGPoint c3 = CGPointMake(pointB.x, pointB.y + offset);
    CGPoint c4 = CGPointMake(pointC.x + offset, pointC.y);
    
    CGPoint c5 = CGPointMake(pointC.x - offset, pointC.y);
    CGPoint c6 = CGPointMake(pointD.x, pointD.y + offset);
    
    CGPoint c7 = CGPointMake(pointD.x, pointD.y - offset);
    CGPoint c8 = CGPointMake(pointA.x - offset, pointA.y);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:pointA];
    [path addCurveToPoint:pointB controlPoint1:c1 controlPoint2:c2];
    [path addCurveToPoint:pointC controlPoint1:c3 controlPoint2:c4];
    [path addCurveToPoint:pointD controlPoint1:c5 controlPoint2:c6];
    [path addCurveToPoint:pointA controlPoint1:c7 controlPoint2:c8];
    [path closePath];
    
    CGContextAddPath(ctx, path.CGPath);
    CGContextSetFillColorWithColor(ctx, [UIColor cyanColor].CGColor);
    CGContextFillPath(ctx);
}

- (void)restoreAnimation:(id)howManyDistance {
    CAKeyframeAnimation *anim = [[ADSKeyFrameAnimation share] createSpringAnimation:@"factor" duration:0.8 usingSpringWithDamping:0.5 initialSpringVolocity:3 fromValue:@(0.5 + [howManyDistance floatValue] * 1.5) toValue:@(0)];
    self.factor = 0;
    [self addAnimation:anim forKey:@"restoreAnimation"];
}
@end
