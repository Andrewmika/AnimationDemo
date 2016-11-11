//
//  ADSPageControl.m
//  AnimationDemo
//
//  Created by Andrew Shen on 2016/11/7.
//  Copyright © 2016年 AndrewShen. All rights reserved.
//

#import "ADSPageControl.h"
#import "ADSLine.h"
#import <Masonry/Masonry.h>
#import "ADSCircle.h"

@interface ADSPageControl()
@property (nonatomic, strong)  ADSLine  *lineLayer; // <##>
@property (nonatomic, strong)  ADSCircle  *circleLayer; // <##>
@end
@implementation ADSPageControl

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [self.layer addSublayer:self.lineLayer];
    [self.layer insertSublayer:self.circleLayer above:self.lineLayer];
    [self.lineLayer setNeedsDisplay];
    [self.circleLayer setNeedsDisplay];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.lineLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.circleLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

- (void)animateAtIndex:(NSInteger)index {
    CGFloat HOWMANYDISTANCE =
    ABS((self.lineLayer.selectedLineLength -
         index * ((self.lineLayer.frame.size.width - BALLDiameter) /
                  (self.lineLayer.selectedIndex - 1)))) /
    ((self.lineLayer.frame.size.width - BALLDiameter) /
     (self.lineLayer.selectedIndex - 1));
    self.circleLayer.scrollDirection = self.lineLayer.selectedIndex > index ? ScrollDirectionLeft : ScrollDirectionRight;
    self.circleLayer.currentRect = CGRectMake(0, 0, 6, 6);
    [self.lineLayer animationWithIndex:index];
    
    [self.circleLayer performSelector:@selector(restoreAnimation:) withObject:@(HOWMANYDISTANCE / 6) afterDelay:0.2];
}

#pragma mark - Init
- (ADSLine *)lineLayer {
    if (!_lineLayer) {
        _lineLayer = [ADSLine layer];
        _lineLayer.contentsScale = [UIScreen mainScreen].scale;
    }
    return _lineLayer;
}
- (ADSCircle *)circleLayer {
    if (!_circleLayer) {
        _circleLayer = [ADSCircle layer];
        _circleLayer.contentsScale = [UIScreen mainScreen].scale;
    }
    return _circleLayer;
}
@end
