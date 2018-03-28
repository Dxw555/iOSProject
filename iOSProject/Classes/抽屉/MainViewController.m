//
//  MainViewController.m
//  iOSProject
//
//  Created by 360doc on 2018/3/27.
//  Copyright © 2018年 dxw. All rights reserved.
//
typedef enum {
    
    DXWViewTransformLocationOriginal,
    DXWViewTransformLocationLeft,
    
}DXWViewTransformLocation;


#define DXWTransformMaxW 300.0

#import "MainViewController.h"
#import "MainTabBarController.h"
#import "MainLeftViewController.h"


@interface MainViewController ()

/** 左侧页面控制器 */
@property (nonatomic , strong) MainLeftViewController *leftVC;

/** 右侧页面控制器 */
@property (nonatomic , strong) MainTabBarController *rightVC;

/** 右侧控制器蒙层 */
@property (nonatomic , strong) UIView *rightTopView;

/** transform */
@property (nonatomic , assign) DXWViewTransformLocation transformLocation;

/** 触摸开始时位置 */
@property (nonatomic , assign) CGFloat beganTouchX;



@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewController:self.leftVC];
    [self addChildViewController:self.rightVC];
    [self.view addSubview:self.leftVC.view];
    [self.view addSubview:self.rightVC.view];
    [self.rightVC.view addSubview:self.rightTopView];
    self.rightTopView.hidden = YES;
   
}


//完全展开抽屉
- (void)showLeftView {
    CGRect rect = self.rightVC.view.frame;
    
    NSTimeInterval time = 0.25 * ((DXWTransformMaxW - rect.origin.x)/DXWTransformMaxW);
    
    rect.origin.x = DXWTransformMaxW;
    [UIView animateWithDuration:time animations:^{
        self.rightTopView.hidden = NO;
        self.rightVC.view.frame = rect;;
    }];
}

//隐藏抽屉
- (void)hiddenLeftView {
    CGRect rect = self.rightVC.view.frame;
    
    NSTimeInterval time = 0.25 * (rect.origin.x / DXWTransformMaxW);
    
    rect.origin.x = 0;
    [UIView animateWithDuration:time animations:^{
        self.rightTopView.hidden = YES;
        self.rightVC.view.frame = rect;
    }];
}

//结束手势修正抽屉位置
- (void)amendViewFrame:(UIView *)view {
    CGRect rect = view.frame;
    if (rect.origin.x <= DXWTransformMaxW && rect.origin.x >= 0) {
        if (rect.origin.x > DXWTransformMaxW/2.0) {
            [self showLeftView];
        }else {
            [self hiddenLeftView];
        }
    }
}

//拖动手势
- (void)panGesture:(UIPanGestureRecognizer *)pan {
    
    CGPoint offPoint = [pan translationInView:pan.view];

    //获取需要操作frame的view
    UIView *operationView = pan.view;
    if (operationView == self.rightTopView) {
        operationView = [self.rightTopView superview];
    }
    
    CGRect rect = operationView.frame;
    rect.origin.x = rect.origin.x + offPoint.x;
    if (rect.origin.x >= DXWTransformMaxW) {
        rect.origin.x = DXWTransformMaxW;
    }else if (rect.origin.x <= 0) {
        rect.origin.x = 0;
    }
    operationView.frame = rect;
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        [self amendViewFrame:operationView];
    }
    
    [pan setTranslation:CGPointZero inView:pan.view];
}

//单击手势
-(void) handleTap:(UITapGestureRecognizer *)recognizer {
    [self hiddenLeftView];
}

#pragma mark - 懒加载
//左侧控制器
- (MainLeftViewController *)leftVC {
    if (!_leftVC) {
        _leftVC = [[MainLeftViewController alloc] init];
    }
    return _leftVC;
}
//右侧控制器
- (MainTabBarController *)rightVC {
    if (!_rightVC) {
        _rightVC = [[MainTabBarController alloc] init];
        
        UIScreenEdgePanGestureRecognizer *screenPan = [[UIScreenEdgePanGestureRecognizer alloc]
                                                       initWithTarget:self
                                                       action:@selector(panGesture:)];
        screenPan.edges = UIRectEdgeLeft;
        [_rightVC.view addGestureRecognizer:screenPan];
    }
    return _rightVC;
}
//右侧控制器蒙层
- (UIView *)rightTopView {
    if (!_rightTopView) {
        _rightTopView = [[UIView alloc] initWithFrame:DXWScreenBounds];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]
                                                       initWithTarget:self
                                                       action:@selector(panGesture:)];
        [_rightTopView addGestureRecognizer:pan];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
        tap.numberOfTapsRequired = 1;
        [_rightTopView addGestureRecognizer:tap];
        
    }
    return _rightTopView;
}

@end
