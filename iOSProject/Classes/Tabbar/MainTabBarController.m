//
//  MainTabBarController.m
//  iOSProject
//
//  Created by 360doc on 2018/3/26.
//  Copyright © 2018年 dxw. All rights reserved.
//

#import "MainTabBarController.h"
#import "DXWNavigationController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    DXWNavigationController *nvc1 = [[DXWNavigationController alloc] init];
    nvc1.title = @"nvc1";
    DXWNavigationController *nvc2 = [[DXWNavigationController alloc] init];
    nvc2.title = @"nvc2";
    DXWNavigationController *nvc3 = [[DXWNavigationController alloc] init];
    nvc3.title = @"nvc3";
    DXWNavigationController *nvc4 = [[DXWNavigationController alloc] init];
    nvc4.title = @"nvc4";
    
    nvc1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"nvc2" image:nil selectedImage:nil];
    nvc1.tabBarItem.badgeValue = @"12233";
    nvc1.tabBarItem.badgeColor = [UIColor greenColor];
    self.viewControllers = @[nvc1,nvc2,nvc3,nvc4];
    
    self.tabBar.translucent = NO;
//    self.tabBar.items = @[];
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[UIImage new]];
}


- (void)async {
    dispatch_group_t group=dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        //友盟设置
        
        
    });
    
    dispatch_group_async(dispatch_group_create(), dispatch_get_global_queue(0, 0), ^{
        
    });
}


@end

