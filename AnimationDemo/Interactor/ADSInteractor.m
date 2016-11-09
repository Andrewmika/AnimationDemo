//
//  ADSInteractor.m
//  AnimationDemo
//
//  Created by Andrew Shen on 2016/11/7.
//  Copyright © 2016年 AndrewShen. All rights reserved.
//

#import "ADSInteractor.h"
#import <objc/runtime.h>

@implementation ADSInteractor

+ (instancetype)sharedInstance {
    static ADSInteractor *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ADSInteractor alloc] init];
    });
    return sharedInstance;
}

- (NSString *)navigatorName {
    NSString *name = objc_getAssociatedObject(self, _cmd);
    return name;
}

- (void)setNavigatorName:(NSString *)navigatorName {
    objc_setAssociatedObject(self, @selector(navigatorName), navigatorName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)configBaseNavigatorClassName:(NSString *)baseNaviName {
    self.navigatorName = baseNaviName;
}


- (void)pushToVC:(UIViewController *)VC {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *controller = (UITabBarController *)rootViewController;
        UINavigationController *navi = controller.selectedViewController;
        [VC setHidesBottomBarWhenPushed:YES];
        [navi pushViewController:VC animated:YES];
    }
    else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navi = (UINavigationController *)rootViewController;
        [navi pushViewController:VC animated:YES];
    }
    else if ([rootViewController isKindOfClass:[UIViewController class]]) {
        if (!rootViewController.navigationController) {
            UINavigationController *navi;
            if (!self.navigatorName) {
                navi = [[UINavigationController alloc] initWithRootViewController:VC];
            }
            else {
                Class className = NSClassFromString(self.navigatorName);
                navi = [[className alloc] initWithRootViewController:VC];
            }
            UIBarButtonItem *close = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(closePresentedController)];
            NSMutableArray *items = [NSMutableArray arrayWithArray:VC.navigationItem.leftBarButtonItems];
            [items insertObject:close atIndex:0];
            [VC.navigationItem setLeftBarButtonItems:items];
            [rootViewController presentViewController:navi animated:YES completion:nil];

        }
        else {
            [rootViewController.navigationController pushViewController:VC animated:YES];

        }
    }
}

- (void)closePresentedController {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootViewController dismissViewControllerAnimated:YES completion:nil];

}
@end
