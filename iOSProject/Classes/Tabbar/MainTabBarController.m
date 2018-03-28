//
//  MainTabBarController.m
//  iOSProject
//
//  Created by 360doc on 2018/3/26.
//  Copyright © 2018年 dxw. All rights reserved.
//

#import "MainTabBarController.h"
#import "DXWNavigationController.h"
#import "FindViewController.h"
#import "BookViewController.h"
#import "MeViewController.h"
@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addControllers];
    [self tabbarProperty];
}

//添加controller
- (void)addControllers {
    BookViewController *bookVC = [[BookViewController alloc] init];
    DXWNavigationController *nVC1 = [[DXWNavigationController alloc]
                                     initWithRootViewController:bookVC];
    nVC1.tabBarItem.title = @"书架";
    nVC1.tabBarItem.image = [UIImage imageNamed:@"icon_tabbar_book_normal"];
    nVC1.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_tabbar_book_selected"];
    
    FindViewController *findVC = [[FindViewController alloc] init];
    DXWNavigationController *nVC2 = [[DXWNavigationController alloc]
                                     initWithRootViewController:findVC];
    nVC2.tabBarItem.title = @"发现";
    nVC2.tabBarItem.image = [UIImage imageNamed:@"icon_tabbar_find_normal"];
    nVC2.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_tabbar_find_selected"];
    
    MeViewController *meVC = [[MeViewController alloc] init];
    DXWNavigationController *nVC3 = [[DXWNavigationController alloc]
                                     initWithRootViewController:meVC];
    nVC3.tabBarItem.title = @"账户";
    nVC3.tabBarItem.image = [UIImage imageNamed:@"icon_tabbar_me_normal"];
    nVC3.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_tabbar_me_selected"];
    
    self.viewControllers = @[nVC1,nVC2,nVC3];
}

//设置tabbar属性
- (void)tabbarProperty {
    
    //默认字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:DXWColorRGB(171, 171, 171),
      NSForegroundColorAttributeName,
      [UIFont systemFontOfSize:12],
      NSFontAttributeName, nil]
                                             forState:UIControlStateNormal];
    
    //选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:DXWColorRGB(179, 33, 51),
      NSForegroundColorAttributeName,
      [UIFont systemFontOfSize:12],
      NSFontAttributeName, nil]
                                             forState:UIControlStateSelected];
    
    //tabbar背景色
    [[UITabBar appearance] setBackgroundColor:DXWColorWhite];
    [[UITabBar appearance] setTranslucent:NO];
    
}

@end

