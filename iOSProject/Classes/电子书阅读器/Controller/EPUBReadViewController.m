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

/** controllers */
@property (nonatomic , strong) NSMutableArray *dataArray;

/** 动画中 */
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
            EPUBViewController *nextController = [self afterViewController];
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
            
            EPUBViewController *nextController = [self beforeViewController];
            if (!nextController) {
                return nil;
            }
            //创建背面显示控制器
            EPUBBackViewController *backViewController = [EPUBBackViewController new];
            backViewController.currentViewController = nextController;
            return backViewController;
        }else {
            EPUBBackViewController *backViewController = (EPUBBackViewController *)viewController;
            //获取上一页显示控制器
            EPUBViewController *childViewController = backViewController.currentViewController;
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
    if (finished || completed) {
        self.pageIsAnimating = NO;
        EPUBViewController *controller = (EPUBViewController *)[pageViewController.viewControllers firstObject];
        EPUBViewController *nowController = [self.dataArray objectAtIndex:1];
        EPUBViewController *afterController = [self.dataArray objectAtIndex:2];
        if (nowController != controller) {
            if (controller == afterController) {
                [self afterViewController];
            }else {
                [self beforeViewController];
            }
        }
    }
   
}

- (void)refreshController {
    [self.dataArray removeAllObjects];
}

/**
 获取后面显示控制器,如果前面没有,返回nil
 @return 后面显示控制器
 */
- (EPUBViewController *)afterViewController {
    EPUBViewController *nowController = [self.dataArray objectAtIndex:1];
    EPUBViewController *nextController = [self.dataArray objectAtIndex:2];
    if (nowController == nextController) {
        return nil;
    }
    EPUBViewController *nextNextController = [self afterEPUBViewControllerWith:nextController];
    [self.dataArray addObject:nextNextController];
    [self.dataArray removeObjectAtIndex:0];
    DLog(@"self.dataArray %@",self.dataArray);
    return nextController;
}

/**
 获取前面显示控制器,如果前面没有,返回nil
 @return 前面显示控制器
 */
- (EPUBViewController *)beforeViewController {
    EPUBViewController *nowController = [self.dataArray objectAtIndex:1];
    EPUBViewController *nextController = [self.dataArray objectAtIndex:0];
    if (nowController == nextController) {
        return nil;
    }
    EPUBViewController *nextNextController = [self beforeEPUBViewControllerWith:nextController];
    [self.dataArray insertObject:nextNextController atIndex:0];
    [self.dataArray removeLastObject];
    return nextController;
}

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
        return controller;
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
        return controller;
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
        
        [self.dataArray addObject:childViewController];
        [self.dataArray addObject:childViewController];
        [self.dataArray addObject:[self afterEPUBViewControllerWith:childViewController]];
        
     
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

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

@end
