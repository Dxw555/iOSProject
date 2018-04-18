//
//  EPUBBackViewController.h
//  iOSProject
//
//  Created by 360doc on 2018/4/17.
//  Copyright © 2018年 dxw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EPUBViewController.h"
@interface EPUBBackViewController : UIViewController
@property (assign, nonatomic) EPUBViewController *currentViewController;
- (void)updateWithViewController:(EPUBViewController *)viewController ;
@end
