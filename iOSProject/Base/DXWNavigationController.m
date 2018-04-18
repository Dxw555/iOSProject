//
//  DXWNavigationController.m
//  iOSProject
//
//  Created by 360doc on 2018/3/28.
//  Copyright © 2018年 dxw. All rights reserved.
//

#import "DXWNavigationController.h"
#import "UIImage+Color.h"


@interface DXWNavigationController ()

@end

@implementation DXWNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.translucent = NO;
//    [self.navigationBar setBackgroundImage:[UIImage initWithColor:DXWColorRGB(200, 39, 39) imageSize:self.navigationBar.frame.size] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.barTintColor = DXWColorRGB(200, 39, 39);
    
}

@end
