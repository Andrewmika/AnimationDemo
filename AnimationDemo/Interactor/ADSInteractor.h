//
//  ADSInteractor.h
//  AnimationDemo
//
//  Created by Andrew Shen on 2016/11/7.
//  Copyright © 2016年 AndrewShen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ADSInteractor : NSObject
@property (nonatomic, copy, readonly)  NSString  *navigatorName; // <##>
+ (instancetype)sharedInstance;
- (void)configBaseNavigatorClassName:(NSString *)baseNaviName;
// 普通push
- (void)pushToVC:(UIViewController *)VC;

@end
