//
//  ADSKeyFrameAnimation.m
//  AnimationDemo
//
//  Created by Andrew Shen on 2016/11/8.
//  Copyright © 2016年 AndrewShen. All rights reserved.
//

#import "ADSKeyFrameAnimation.h"

@implementation ADSKeyFrameAnimation

+ (instancetype)share {
    static ADSKeyFrameAnimation *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ADSKeyFrameAnimation alloc] init];
    });
    return manager;
}

- (CAKeyframeAnimation *)createHalfCurveAnimation:(NSString *)keypath duration:(CFTimeInterval)duration fromvalue:(id)fromValue toValue:(id)toValue {
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:keypath];
    anim.values = [self p_halfCurveAnimationValues:fromValue toValue:toValue duration:duration];
    anim.duration = duration;
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    return anim;
}

- (CAKeyframeAnimation *)createSpringAnimation:(NSString *)keypath duration:(CFTimeInterval)duration usingSpringWithDamping:(CGFloat)damping initialSpringVolocity:(CGFloat)velocity fromValue:(id)fromValue toValue:(id)toValue {
    CGFloat dampingFactor = 10.0;
    CGFloat velocityFactor = 10.0;
    NSMutableArray *values = [self p_springAnimationValues:fromValue toValue:toValue usingSpringWithDamping:damping * dampingFactor initialSpringVelocity:velocityFactor * velocity duration:duration];
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:keypath];
    anim.values = values;
    anim.duration = duration;
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    return anim;
}

#pragma mark - Private Method

- (NSMutableArray *)p_halfCurveAnimationValues:(id)fromValue toValue:(id)toValue duration:(CGFloat)duration {
    NSInteger frames = duration * 60;
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:frames];
    for (NSInteger i = 0; i < frames; i++) {
        [values addObject:@(0.0)];
    }
    CGFloat diff = [toValue floatValue] - [fromValue floatValue];
    for (NSInteger frame = 0; frame < frames; frame++) {
        CGFloat x = (CGFloat)frame / (CGFloat)frames;
        CGFloat value = [fromValue floatValue] + diff * (-x * (x - 2));
        values[frame] = @(value);
    }
    return values;
}

- (NSMutableArray *)p_springAnimationValues:(id)fromValue toValue:(id)toValue usingSpringWithDamping:(CGFloat)damping initialSpringVelocity:(CGFloat)velocity duration:(CGFloat)duration {
    NSInteger frames = duration * 60;
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:frames];
    for (NSInteger i = 0; i < frames; i ++) {
        [values addObject:@(0.0)];
    }
    CGFloat diff = [toValue floatValue] - [fromValue floatValue];
    for (NSInteger frame = 0; frame < frames; frame++) {
        CGFloat x = (CGFloat)frame / (CGFloat)frames;
        CGFloat value = [toValue floatValue] - diff * (pow(M_E, -damping * x) * cos(velocity * x));
        values[frame] = @(value);
    }
    return values;
}
@end
