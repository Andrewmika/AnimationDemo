//
//  ADSLine.h
//  AnimationDemo
//
//  Created by Andrew Shen on 2016/11/7.
//  Copyright © 2016年 AndrewShen. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#define BALLDiameter 6

@interface ADSLine : CALayer

@property (nonatomic, assign)  NSInteger  selectedIndex; // <##>
@property (nonatomic, assign)  CGFloat  selectedLineLength; // <##>

- (void)animationWithIndex:(NSInteger)selectedIndex;
@end
