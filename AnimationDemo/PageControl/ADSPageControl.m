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

@interface ADSPageControl()
@property (nonatomic, strong)  ADSLine  *lineLayer; // <##>
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
    [self.lineLayer setNeedsDisplay];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.lineLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

- (void)animateAtIndex:(NSInteger)index {
    [self.lineLayer animationWithIndex:index];
}

#pragma mark - Init
- (ADSLine *)lineLayer {
    if (!_lineLayer) {
        _lineLayer = [ADSLine layer];
        _lineLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _lineLayer.contentsScale = [UIScreen mainScreen].scale;
    }
    return _lineLayer;
}
@end
