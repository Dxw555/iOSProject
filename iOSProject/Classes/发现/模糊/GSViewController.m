//
//  GSViewController.m
//  iOSProject
//
//  Created by 360doc on 2018/4/23.
//  Copyright © 2018年 dxw. All rights reserved.
//

#import "GSViewController.h"

@interface GSViewController ()

@end

@implementation GSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:self.view.bounds];
    image.image = [UIImage imageNamed:@"3588.PNG"];
    [self.view addSubview:image];
    
   
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(10, 60, 100, 30);
    btn1.backgroundColor = [UIColor redColor];
    [btn1 setTitle:@"UIBlurEffect" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(showVisualEffectView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];

    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(10, 100, 100, 30);
    btn2.backgroundColor = [UIColor redColor];
    [btn2 setTitle:@"UIToolbar" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(showToolbar) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
}


- (void)showVisualEffectView {
    UIBlurEffect *beffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:beffect];
    effectview.frame = self.view.bounds;
    [self.view addSubview:effectview];
}

- (void)showToolbar {
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:self.view.bounds];
    toolbar.barStyle = UIBarStyleBlackTranslucent;
    [self.view addSubview:toolbar];
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
