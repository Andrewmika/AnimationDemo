//
//  ADSLine.m
//  AnimationDemo
//
//  Created by Andrew Shen on 2016/11/7.
//  Copyright © 2016年 AndrewShen. All rights reserved.
//

#import "ADSLine.h"
#import <UIKit/UIKit.h>
#import "ADSKeyFrameAnimation.h"

#define COUNT 6
#define BALLDiameter 6
#define LINEHEIGHT 2
#define DISTANCE ((self.frame.size.width - BALLDiameter) / (COUNT - 1))

@implementation ADSLine

- (instancetype)initWithLayer:(ADSLine *)layer {
    self = [super initWithLayer:layer];
    if (self) {
        self.selectedIndex = layer.selectedIndex;
        self.selectedLineLength = layer.selectedLineLength;
        self.masksToBounds = layer.masksToBounds;
    }
    
    return self;

}

+ (BOOL)needsDisplayForKey:(NSString *)key {
    if ([key isEqual:@"selectedLineLength"]) {
        return  YES;
    }
    return [super needsDisplayForKey:key];
}

- (void)drawInContext:(CGContextRef)ctx {
    CGMutablePathRef linePath = CGPathCreateMutable();
    CGPathMoveToPoint(linePath, nil, 2, self.frame.size.height * 0.5);
    
    // 画线
    CGPathAddRoundedRect(linePath, nil, CGRectMake(BALLDiameter * 0.5, (self.frame.size.height - LINEHEIGHT) * 0.5, self.frame.size.width - BALLDiameter, LINEHEIGHT), 0, 0);
    // 画圆圈
    for (NSInteger i = 0; i < COUNT; i ++) {
        CGRect circle = CGRectMake(i * DISTANCE, (self.frame.size.height - BALLDiameter) * 0.5 , BALLDiameter, BALLDiameter);
        CGPathAddEllipseInRect(linePath, nil, circle);
    }
    CGContextAddPath(ctx, linePath);
    CGContextSetFillColorWithColor(ctx, [UIColor greenColor].CGColor);
    CGContextFillPath(ctx);
    
    // 填充
    CGContextBeginPath(ctx);
    linePath = CGPathCreateMutable();
    // 带颜色的线
    CGPathAddRoundedRect(linePath, nil, CGRectMake(BALLDiameter * 0.5, (self.frame.size.height - LINEHEIGHT) * 0.5, self.selectedLineLength, LINEHEIGHT), 0, 0);
    // 画圆圈
    for (NSInteger i = 0; i <= self.selectedIndex; i ++) {
        if ((i * DISTANCE) <= (self.selectedLineLength + 0.1)) {
            CGRect circle = CGRectMake(i * DISTANCE, (self.frame.size.height - BALLDiameter) * 0.5 , BALLDiameter, BALLDiameter);
            CGPathAddEllipseInRect(linePath, nil, circle);
        }
    }
    CGContextAddPath(ctx, linePath);
    CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextFillPath(ctx);

}

- (void)animationWithIndex:(NSInteger)selectedIndex {
    CGFloat newLineLength = MAX(0, selectedIndex) * DISTANCE;
    CAKeyframeAnimation *anim = [[ADSKeyFrameAnimation share] createHalfCurveAnimation:@"selectedLineLength" duration:1.0 fromvalue:@(self.selectedLineLength) toValue:@(newLineLength)];
    self.selectedLineLength = newLineLength;
    anim.removedOnCompletion = YES;
    [self addAnimation:anim forKey:@"lineAnimation"];
    self.selectedIndex = selectedIndex;
}


@end
