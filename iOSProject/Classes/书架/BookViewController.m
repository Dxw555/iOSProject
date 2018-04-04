//
//  BookViewController.m
//  iOSProject
//
//  Created by 360doc on 2018/3/28.
//  Copyright © 2018年 dxw. All rights reserved.
//

#import "BookViewController.h"

@interface BookViewController ()

@end

@implementation BookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    UIView *view = [[UIView alloc] initWithFrame:DXWAppWindow.bounds];
    
    [DXWAppWindow addSubview:view];
    
    
    UIWindow *w = [[UIWindow alloc] initWithFrame:DXWAppWindow.bounds];
//    w.windowLevel = UIWindowLevelAlert;
    w.backgroundColor = DXWColorHexadecimalAndAlpha(0x000000, 0.3);
    [w makeKeyAndVisible];
    [DXWAppWindow addSubview:w];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
