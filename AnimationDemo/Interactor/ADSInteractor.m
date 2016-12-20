//
//  ADSInteractor.m
//  AnimationDemo
//
//  Created by Andrew Shen on 2016/11/7.
//  Copyright © 2016年 AndrewShen. All rights reserved.
//

#import "ADSInteractor.h"
#import <objc/runtime.h>

@interface ADSInteractor ()
@property (nonatomic, copy, readwrite)  NSString  *navigatorName; // <##>

@end

@implementation ADSInteractor

+ (instancetype)sharedInstance {
    static ADSInteractor *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ADSInteractor alloc] init];
    });
    return sharedInstance;
}

- (void)configBaseNavigatorClassName:(NSString *)baseNaviName {
    self.navigatorName = baseNaviName;
}


- (void)pushToVC:(UIViewController *)VC {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [self pushOrPresentToVC:VC OriginVC:rootViewController];
}

#pragma mark - Private Method
- (UINavigationController *)topNavigationControllerFromVC:(UIViewController *)VC {
    if ([VC isKindOfClass:[UITabBarController class]]) {
        UITabBarController *controller = (UITabBarController *)VC;
        UIViewController *selectVC = controller.selectedViewController;
        [VC setHidesBottomBarWhenPushed:YES];
        return [self topNavigationControllerFromVC:selectVC];
    }
    else if ([VC isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navi = (UINavigationController *)VC;
        UIViewController *topVC = navi.topViewController;
        if (!topVC.presentedViewController) {
            return navi;
        }
        else {
            return [self topNavigationControllerFromVC:topVC.presentedViewController];
        }
    }
    else if ([VC isKindOfClass:[UIViewController class]]) {
        if (!VC.presentedViewController) {
            return nil;
        }
        else {
            return [self topNavigationControllerFromVC:VC.presentedViewController];
        }
    }
    return nil;
}

- (void)pushOrPresentToVC:(UIViewController *)targetVC OriginVC:(UIViewController *)originVC {
    UINavigationController *navi = [self topNavigationControllerFromVC:originVC];
    if (navi) {
        [navi pushViewController:targetVC animated:YES];
    }
    else {
        if (!self.navigatorName) {
            navi = [[UINavigationController alloc] initWithRootViewController:targetVC];
        }
        else {
            Class className = NSClassFromString(self.navigatorName);
            navi = [[className alloc] initWithRootViewController:targetVC];
        }
        UIBarButtonItem *close = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(closePresentedController)];
        NSMutableArray *items = [NSMutableArray arrayWithArray:targetVC.navigationItem.leftBarButtonItems];
        [items insertObject:close atIndex:0];
        [targetVC.navigationItem setLeftBarButtonItems:items];
        [originVC presentViewController:navi animated:YES completion:nil];
    }
}

- (void)closePresentedController {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootViewController dismissViewControllerAnimated:YES completion:nil];
}
@end
