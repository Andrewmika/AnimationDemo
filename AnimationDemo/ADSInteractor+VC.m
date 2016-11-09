//
//  ADSInteractor+VC.m
//  AnimationDemo
//
//  Created by Andrew Shen on 2016/11/7.
//  Copyright © 2016年 AndrewShen. All rights reserved.
//

#import "ADSInteractor+VC.h"
#import "PageControlViewController.h"

@implementation ADSInteractor (VC)

- (void)go_pushToPagecontrolVC {
    PageControlViewController *VC = [PageControlViewController new];
    [self pushToVC:VC];
}

@end
