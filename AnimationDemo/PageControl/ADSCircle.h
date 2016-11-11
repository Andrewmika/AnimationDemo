//
//  ADSCircle.h
//  AnimationDemo
//
//  Created by Andrew Shen on 2016/11/9.
//  Copyright © 2016年 AndrewShen. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

typedef enum ScrollDirection {
    ScrollDirectionNone,
    ScrollDirectionRight,
    ScrollDirectionLeft,
    ScrollDirectionUp,
    ScrollDirectionDown,
    ScrollDirectionCrazy,
} ScrollDirection;


@interface ADSCircle : CALayer
@property(nonatomic, assign) CGRect currentRect;
@property(nonatomic, assign) ScrollDirection scrollDirection;
- (void)restoreAnimation:(id)howManyDistance;

@end
