//
//  EPUBReadViewController.m
//  iOSProject
//
//  Created by 360doc on 2018/4/17.
//  Copyright © 2018年 dxw. All rights reserved.
//

#import "EPUBReadViewController.h"
#import "EPUBViewController.h"
#import "EPUBBackViewController.h"

@interface EPUBReadViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>

/** pageview */
@property (nonatomic , strong) UIPageViewController *pageViewController;

/** 翻页动画完成 */
@property (nonatomic , assign) BOOL pageAnimationFinished;

@end

@implementation EPUBReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageAnimationFinished = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.pageViewController.view];
    [self addChildViewController:self.pageViewController];
}

#pragma mark - UIPageViewControllerDelegate

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    if (self.pageAnimationFinished) {
        if (pageViewController.transitionStyle == UIPageViewControllerTransitionStylePageCurl) {
            //仿真翻页
            if ([viewController isKindOfClass:[EPUBViewController class]]) {
                //创建背面显示控制器
                EPUBBackViewController *backViewController = [EPUBBackViewController new];
                [backViewController updateWithViewController:(id)viewController];
                return backViewController;
            }else {
                EPUBBackViewController *backViewController = (EPUBBackViewController *)viewController;
                NSInteger index = backViewController.currentViewController.index + 1;
                //获取下一页显示控制器
                EPUBViewController *childViewController = [self viewControllerAtIndex:index];
                return childViewController;
            }
        }else {
            EPUBViewController *controller = (EPUBViewController *)viewController;
            NSInteger index = controller.index + 1;
            
            //平滑翻页
            EPUBViewController *childViewController = [self viewControllerAtIndex:index];
            return childViewController;
        }
    }
    return nil;
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    if (self.pageAnimationFinished) {
        if (pageViewController.transitionStyle == UIPageViewControllerTransitionStylePageCurl) {
            if ([viewController isKindOfClass:[EPUBViewController class]]) {
                EPUBViewController *childViewController = (EPUBViewController *)viewController;
                NSInteger index = childViewController.index - 1;
                if (index < 0) {
                    return nil;
                }
                //创建背面显示控制器
                EPUBBackViewController *backViewController = [EPUBBackViewController new];
                [backViewController updateWithViewController:[self viewControllerAtIndex:index]];
                return backViewController;
            }else {
                EPUBBackViewController *backViewController = (EPUBBackViewController *)viewController;
                //获取上一页显示控制器
                EPUBViewController *childViewController = backViewController.currentViewController;
                return childViewController;
            }
        }else {
            EPUBViewController *controller = (EPUBViewController *)viewController;
            NSInteger index = controller.index - 1;
            if (index < 0) {
                return nil;
            }
            
            EPUBViewController *childViewController = [self viewControllerAtIndex:index];
            return childViewController;
        }
    }
    return nil;
}

// 手势滑动(或翻页)开始时回调
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    self.pageAnimationFinished = NO;
}
// 滑动结束时的回调
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    self.pageAnimationFinished = YES;
}

//page显示控制器
- (EPUBViewController *)viewControllerAtIndex:(NSUInteger)index {
    DLog(@"index = %ld",(long)index);
    EPUBViewController *childViewController = [[EPUBViewController alloc] init];
    childViewController.index = index;
    return childViewController;
}

#pragma mark - ljz
- (UIPageViewController *)pageViewController {
    if (!_pageViewController) {
        
        EPUBViewController *childViewController = [self viewControllerAtIndex:0];
        
        NSDictionary *opinions = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin]
                                                             forKey:UIPageViewControllerOptionSpineLocationKey];
        
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                            options:opinions];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
        _pageViewController.doubleSided = YES;
        
        [_pageViewController setViewControllers:@[childViewController]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:nil];
        [_pageViewController didMoveToParentViewController:self];
    }
    return _pageViewController;
}

@end
