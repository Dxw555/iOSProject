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
    DLog(@"pageViewController %@",pageViewController.viewControllers);
    if (self.pageAnimationFinished) {
        if (pageViewController.transitionStyle == UIPageViewControllerTransitionStylePageCurl) {
            //仿真翻页
            if ([viewController isKindOfClass:[EPUBViewController class]]) {
                //创建背面显示控制器
                EPUBBackViewController *backViewController = [EPUBBackViewController new];
                backViewController.currentViewController = (EPUBViewController *)viewController;
                return backViewController;
            }else {

                EPUBBackViewController *backViewController = (EPUBBackViewController *)viewController;
                EPUBViewController *controller = backViewController.currentViewController;

                //获取下一页显示控制器
                EPUBViewController *childViewController = [self nextEPUBViewControllerWith:controller];
                DLog(@"childViewController %@",childViewController);
                return childViewController;
            }
        }else {
            //平滑翻页
            EPUBViewController *controller = (EPUBViewController *)viewController;
            EPUBViewController *childViewController = [self nextEPUBViewControllerWith:controller];
            
            return childViewController;
        }
    }
    return nil;
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    if (self.pageAnimationFinished) {
        if (pageViewController.transitionStyle == UIPageViewControllerTransitionStylePageCurl) {
            if ([viewController isKindOfClass:[EPUBViewController class]]) {

                EPUBViewController *childViewController = [self onEPUBViewControllerWith:(EPUBViewController *)viewController];
                if (!childViewController) {
                    return nil;
                }
                //创建背面显示控制器
                EPUBBackViewController *backViewController = [EPUBBackViewController new];
                backViewController.currentViewController = childViewController;
                return backViewController;
            }else {
                EPUBBackViewController *backViewController = (EPUBBackViewController *)viewController;
                //获取上一页显示控制器
                EPUBViewController *childViewController = backViewController.currentViewController;
                return childViewController;
            }
        }else {
            EPUBViewController *childViewController = [self onEPUBViewControllerWith:(EPUBViewController *)viewController];
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
- (EPUBViewController *)contentViewController{
    EPUBViewController *childViewController = [[EPUBViewController alloc] init];
    childViewController.epub = self.epub;
    childViewController.currentPageRefIndex = self.epub.epubSetting.currentPageRefIndex;
    childViewController.currentOffYIndexInPage = self.epub.epubSetting.currentOffYIndexInPage;
    return childViewController;
}

- (EPUBViewController *)onEPUBViewControllerWith:(EPUBViewController *)controller {
    EPUBModel *epub = controller.epub;
    
    NSInteger currentPageRefIndex = controller.currentPageRefIndex;
    NSInteger currentOffYIndexInPage = controller.currentOffYIndexInPage;
    NSMutableDictionary *dictPageWithOffYCount = epub.epubSetting.dictPageWithOffYCount;
    NSInteger currentPageCount = [[dictPageWithOffYCount objectForKey:[NSString stringWithFormat:@"%@",@(currentPageRefIndex)]] integerValue];
    if (currentPageCount < 1) {
        currentPageCount = 1;
    }
    currentOffYIndexInPage = currentOffYIndexInPage - 1;
    if (currentOffYIndexInPage < 0) {
        currentPageRefIndex = currentPageRefIndex - 1;
    }
    if (currentPageRefIndex < 0) {
        return nil;
    }
    
    EPUBViewController *childViewController = [[EPUBViewController alloc] init];
    childViewController.epub = self.epub;
    if (controller.currentPageRefIndex == currentPageRefIndex + 1) {
        //向上翻一页
        childViewController.isPrePage = YES;
    }
    childViewController.currentPageRefIndex = currentPageRefIndex;
    childViewController.currentOffYIndexInPage = currentOffYIndexInPage;
    return childViewController;
}

- (EPUBViewController *)nextEPUBViewControllerWith:(EPUBViewController *)controller {
    EPUBModel *epub = controller.epub;
    
    NSInteger currentPageRefIndex = controller.currentPageRefIndex;
    NSInteger currentOffYIndexInPage = controller.currentOffYIndexInPage;
    NSMutableDictionary *dictPageWithOffYCount = epub.epubSetting.dictPageWithOffYCount;
    NSInteger currentPageCount = [[dictPageWithOffYCount objectForKey:[NSString stringWithFormat:@"%@",@(currentPageRefIndex)]] integerValue];
    if (currentPageCount < 1) {
        currentPageCount = 1;
    }
    currentOffYIndexInPage = currentOffYIndexInPage + 1;
    if (currentOffYIndexInPage >= currentPageCount) {
        currentPageRefIndex = currentPageRefIndex + 1;
        currentOffYIndexInPage = 0;
    }
    if (currentPageRefIndex >= epub.epubPageRefs.count) {
        return nil;
    }
    
    EPUBViewController *childViewController = [[EPUBViewController alloc] init];
    childViewController.epub = self.epub;
    childViewController.currentPageRefIndex = currentPageRefIndex;
    childViewController.currentOffYIndexInPage = currentOffYIndexInPage;
    return childViewController;
}

#pragma mark - ljz
- (UIPageViewController *)pageViewController {
    if (!_pageViewController) {
        
        EPUBViewController *childViewController = [self contentViewController];
     
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
                                       animated:YES
                                     completion:nil];
        [_pageViewController didMoveToParentViewController:self];
        
    }
    return _pageViewController;
}

@end
