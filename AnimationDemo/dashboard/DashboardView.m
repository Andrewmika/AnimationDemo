//
//  DashboardView.m
//  AnimationDemo
//
//  Created by Andrew Shen on 2016/11/11.
//  Copyright © 2016年 AndrewShen. All rights reserved.
//

#import "DashboardView.h"
#import "DashboardPathLayer.h"

@interface DashboardView ()
@property (nonatomic, strong)  UIImageView  *imageView; // <##>
@end
@implementation DashboardView

+ (Class)layerClass {
    return [DashboardPathLayer class];
}


- (void)willMoveToSuperview:(UIView *)newSuperview {
    DashboardPathLayer *layer = [DashboardPathLayer layer];
    layer.contentsScale = [UIScreen mainScreen].scale;
    layer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self.layer addSublayer:layer];
    [layer setNeedsDisplay];
    [self addSubview:self.imageView];

}

- (void)animatePointWithAngle:(CGFloat)angle {
    [UIView animateWithDuration:1.8 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGAffineTransform t = CGAffineTransformMakeRotation(-M_PI / 6);
        [_imageView setTransform:CGAffineTransformRotate(t, angle)];

    } completion:^(BOOL finished) {
        //
    }];
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_pointer"]];
        _imageView.frame = CGRectMake(self.frame.size.width * 0.5 - 3.25,self.frame.size.height * 0.5 - 42, 6.5, 44);
        _imageView.layer.anchorPoint = CGPointMake(0.5, 0.95);
        _imageView.frame = CGRectMake(self.frame.size.width * 0.5 - 3.25,self.frame.size.height * 0.5 - 42, 6.5, 44);

        [_imageView setTransform:CGAffineTransformMakeRotation(-M_PI * 2 / 3)];
    }
    return _imageView;
}
@end
