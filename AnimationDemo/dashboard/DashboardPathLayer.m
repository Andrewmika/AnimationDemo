//
//  DashboardPathLayer.m
//  AnimationDemo
//
//  Created by Andrew Shen on 2016/11/11.
//  Copyright © 2016年 AndrewShen. All rights reserved.
//

#import "DashboardPathLayer.h"
#import <UIKit/UIKit.h>


@implementation DashboardPathLayer

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.lineWidth = 20;
        self.circleRadius = 100;
    }
    return self;
}

- (void)drawInContext:(CGContextRef)ctx {
    CGMutablePathRef C1Path = CGPathCreateMutable();
    CGFloat radius = self.circleRadius - self.lineWidth * 0.5;
    CGPoint center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);

    CGPoint layerZeroPoint = CGPointMake(self.frame.size.width * 0.5 - radius, self.frame.size.height * 0.5 - radius);
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 addArcWithCenter:center radius:radius startAngle:-(M_PI * (7.0 / 6.0)) endAngle:M_PI * (1.0 / 6.0) clockwise:YES];
    CGContextAddPath(ctx, path1.CGPath);
    CGContextSetLineWidth(ctx, self.lineWidth);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextStrokePath(ctx);
    
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 addArcWithCenter:center radius:radius startAngle:-(M_PI * (5.0 / 6.0)) endAngle:-M_PI * (1.0 / 6.0) clockwise:YES];
    CGContextAddPath(ctx, path2.CGPath);
    CGContextSetLineWidth(ctx, self.lineWidth);
    CGContextSetStrokeColorWithColor(ctx, [UIColor greenColor].CGColor);
    CGContextStrokePath(ctx);

    UIBezierPath *path3 = [UIBezierPath bezierPath];
    [path3 moveToPoint:center];
    [path3 addArcWithCenter:center radius:radius startAngle:-(M_PI * (5.0 / 6.0)) endAngle:-M_PI * (1.0 / 6.0) clockwise:YES];
    CGContextAddPath(ctx, path3.CGPath);
    CGContextSetFillColorWithColor(ctx, [UIColor colorWithRed:0 green:1 blue:0 alpha:0.3].CGColor);
    CGContextFillPath(ctx);

    
}
@end
