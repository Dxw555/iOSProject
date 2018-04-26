//
//  EPUBBackViewController.m
//  iOSProject
//
//  Created by 360doc on 2018/4/17.
//  Copyright © 2018年 dxw. All rights reserved.
//

#import "EPUBBackViewController.h"

@interface EPUBBackViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation EPUBBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.imageView.image = [self captureView:_currentViewController.view];
    [self.view addSubview:self.imageView];
}

- (void)setCurrentViewController:(EPUBViewController *)currentViewController {
    DXWWeakSelf(self);
    _currentViewController = currentViewController;
    DXWWeakSelf(_currentViewController);
    _currentViewController.showFinish = ^{
        weakself.imageView.image = [weakself captureView:weak_currentViewController.view];
    };
}

//创建快照
- (UIImage *)captureView:(UIView *)view {
    CGSize size = view.bounds.size;
    CGAffineTransform transform = CGAffineTransformMake(-1,0,0,1,size.width,0);
    UIGraphicsBeginImageContextWithOptions(size, view.opaque, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextConcatCTM(context, transform);
    [view.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma ljz
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        [_imageView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
        _imageView.alpha = 0.8;
    }
    return _imageView;
}

@end
