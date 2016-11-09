//
//  ADSKeyFrameAnimation.h
//  AnimationDemo
//
//  Created by Andrew Shen on 2016/11/8.
//  Copyright © 2016年 AndrewShen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ADSKeyFrameAnimation : NSObject

+ (instancetype)share;

- (CAKeyframeAnimation *)createHalfCurveAnimation:(NSString *)keypath duration:(CFTimeInterval)duration fromvalue:(id)fromValue toValue:(id)toValue;

@end
