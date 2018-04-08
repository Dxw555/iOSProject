//
//  AppDelegate+VisibleNVC.m
//  iOSProject
//
//  Created by 360doc on 2018/4/8.
//  Copyright © 2018年 dxw. All rights reserved.
//

#import "AppDelegate+VisibleNVC.h"

@implementation AppDelegate (VisibleNVC)

- (UIViewController *)visibleViewController {
    UIViewController *rootViewController = [self.window rootViewController];
    return [self getVisibleViewControllerFrom:rootViewController];
}

- (UIViewController *) getVisibleViewControllerFrom:(UIViewController *) vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self getVisibleViewControllerFrom:[((UINavigationController *) vc) visibleViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self getVisibleViewControllerFrom:[((UITabBarController *) vc) selectedViewController]];
    } else {
        if (vc.presentedViewController) {
            return [self getVisibleViewControllerFrom:vc.presentedViewController];
        } else {
            return vc;
        }
    }
}

- (UINavigationController *)visibleNavigationController {
    return [[self visibleViewController] navigationController];
}

@end
