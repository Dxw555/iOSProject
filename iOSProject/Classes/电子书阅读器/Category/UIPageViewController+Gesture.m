//
//  UIPageViewController+Gesture.m
//  iOSProject
//
//  Created by 360doc on 2018/4/25.
//  Copyright © 2018年 dxw. All rights reserved.
//

#import "UIPageViewController+Gesture.h"

@implementation UIPageViewController (Gesture)
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return YES; 
}


@end
