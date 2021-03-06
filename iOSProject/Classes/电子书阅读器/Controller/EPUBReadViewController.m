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

@property (nonatomic , strong) UIPageViewController *pageViewController;
@property (nonatomic , strong) EPUBViewController *beforeController;
@property (nonatomic , strong) EPUBViewController *afterController;
@property (nonatomic , assign) BOOL pageIsAnimating;

@end

@implementation EPUBReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageIsAnimating = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.pageViewController.view];
    [self addChildViewController:self.pageViewController];
}

#pragma mark - UIPageViewControllerDelegate
//翻页控制器进行向后翻页动作 这个数据源方法返回的视图控制器为要显示视图的视图控制器
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    if (self.pageIsAnimating) {
        return nil;
    }
    if (pageViewController.transitionStyle == UIPageViewControllerTransitionStylePageCurl) {
        //仿真翻页
        if ([viewController isKindOfClass:[EPUBViewController class]]) {
            //创建背面显示控制器
            EPUBBackViewController *backViewController = [EPUBBackViewController new];
            backViewController.currentViewController = (EPUBViewController *)viewController;
            return backViewController;
        }else {
            EPUBBackViewController *backViewController = (EPUBBackViewController *)viewController;
            self.beforeController = backViewController.currentViewController;
            EPUBViewController *nextController = [self afterEPUBViewControllerWith:backViewController.currentViewController];
            return nextController;
        }
    }else {
        //平滑翻页
        EPUBViewController *nextController = [self afterEPUBViewControllerWith:(EPUBViewController *)viewController];
        return nextController;
    }
}
//翻页控制器进行向前翻页动作 这个数据源方法返回的视图控制器为要显示视图的视图控制器
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    if (self.pageIsAnimating) {
        return nil;
    }
    if (pageViewController.transitionStyle == UIPageViewControllerTransitionStylePageCurl) {
        if ([viewController isKindOfClass:[EPUBViewController class]]) {
            if ((EPUBViewController *)viewController == self.beforeController) {
                return nil;
            }
            self.afterController = (EPUBViewController *)viewController;
            
            //创建背面显示控制器
            EPUBBackViewController *backViewController = [EPUBBackViewController new];
            backViewController.currentViewController = self.beforeController;
            return backViewController;
        }else {
            EPUBBackViewController *backViewController = (EPUBBackViewController *)viewController;
            //获取上一页显示控制器
            EPUBViewController *childViewController = backViewController.currentViewController;
            self.beforeController = [self beforeEPUBViewControllerWith:self.beforeController];
            return childViewController;
        }
    }else {
        EPUBViewController *nextController = [self beforeEPUBViewControllerWith:(EPUBViewController *)viewController];
        return nextController;
    }
}
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers {
    self.pageIsAnimating = YES;
}
// 滑动结束时的回调
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    self.pageIsAnimating = NO;
    EPUBViewController *controller = (EPUBViewController *)[pageViewController.viewControllers firstObject];
    if (controller == self.beforeController || controller == self.afterController) {
        self.beforeController = [self beforeEPUBViewControllerWith:controller];
    }
}

#pragma mark - 显示controller
/**
 根据当前显示,创建新的控制器

 @return 新的控制器
 */
- (EPUBViewController *)currentViewController{
    EPUBViewController *childViewController = [[EPUBViewController alloc] initWithPagrRefIndex:self.epub.epubSetting.currentPageRefIndex
                                                                               offYIndexInPage:self.epub.epubSetting.currentOffYIndexInPage
                                                                                     isPrePage:NO
                                                                                          epub:self.epub];
    return childViewController;
}

/**
 创建控制器之前控制器
 @return 如果前面没有了,返回当前控制器
 */
- (EPUBViewController *)beforeEPUBViewControllerWith:(EPUBViewController *)controller {
    
    BOOL isPrePage = NO;
    
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
        //向上翻一页
        isPrePage = YES;
    }
    if (currentPageRefIndex < 0) {
        //前面没有了
        return nil;
    }
    
    EPUBViewController *childViewController = [[EPUBViewController alloc] initWithPagrRefIndex:currentPageRefIndex
                                                                               offYIndexInPage:currentOffYIndexInPage
                                                                                     isPrePage:isPrePage
                                                                                          epub:epub];
    return childViewController;
}
/**
 创建控制器之后控制器
 @return 如果后面没有了,返回当前控制器
 */
- (EPUBViewController *)afterEPUBViewControllerWith:(EPUBViewController *)controller {
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
        //后面没有了
        return nil;
    }
    
    EPUBViewController *childViewController = [[EPUBViewController alloc] initWithPagrRefIndex:currentPageRefIndex
                                                                               offYIndexInPage:currentOffYIndexInPage
                                                                                     isPrePage:NO
                                                                                          epub:epub];
    
    return childViewController;
}

#pragma mark - ljz
- (UIPageViewController *)pageViewController {
    if (!_pageViewController) {
        
        EPUBViewController *childViewController = [self currentViewController];
        
        self.beforeController = childViewController;
     
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
